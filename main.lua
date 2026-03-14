local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")

-- 1. Khởi tạo UI (Xóa cái cũ nếu đang chạy để tránh đè màn hình)
if game:GetService("CoreGui"):FindFirstChild("VanguardUI") then
    game:GetService("CoreGui").VanguardUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanguardUI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 2. Khung chính (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10) -- Đen sâu
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -125)
MainFrame.Size = UDim2.new(0, 500, 0, 250)
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 2

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 6)
Corner.Parent = MainFrame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(45, 45, 45)
Stroke.Thickness = 1
Stroke.Parent = MainFrame

-- 3. Header (Thanh tiêu đề)
local Header = Instance.new("Frame")
Header.Parent = MainFrame
Header.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Header.Size = UDim2.new(1, 0, 0, 35)
Header.ZIndex = 3

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Parent = Header
HeaderTitle.Position = UDim2.new(0, 15, 0, 0)
HeaderTitle.Size = UDim2.new(0, 300, 1, 0)
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.Text = "VANGUARD HUB | GLOBAL ACCESS"
HeaderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HeaderTitle.TextSize = 11
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.BackgroundTransparency = 1

-- 4. Chia Layout Ngang (Sidebar & Content)
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.Size = UDim2.new(0, 150, 1, -35)
Sidebar.ZIndex = 3

local Content = Instance.new("Frame")
Content.Parent = MainFrame
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 150, 0, 35)
Content.Size = UDim2.new(1, -150, 1, -35)
Content.ZIndex = 3

-- 5. Nội dung xác thực (Authentication)
local Title = Instance.new("TextLabel")
Title.Parent = Content
Title.Position = UDim2.new(0, 20, 0, 20)
Title.Size = UDim2.new(0, 200, 0, 20)
Title.Font = Enum.Font.GothamBold
Title.Text = "KEY VERIFICATION"
Title.TextColor3 = Color3.fromRGB(99, 102, 241) -- Màu Indigo uy tín
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

local GetKey = Instance.new("TextButton")
GetKey.Parent = Content
GetKey.Position = UDim2.new(0, 20, 0, 60)
GetKey.Size = UDim2.new(1, -40, 0, 35)
GetKey.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
GetKey.Font = Enum.Font.GothamBold
GetKey.Text = "GET ACCESS KEY"
GetKey.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKey.TextSize = 11
local GKCorner = Instance.new("UICorner")
GKCorner.CornerRadius = UDim.new(0, 4)
GKCorner.Parent = GetKey

local Input = Instance.new("TextBox")
Input.Parent = Content
Input.Position = UDim2.new(0, 20, 0, 105)
Input.Size = UDim2.new(1, -110, 0, 35)
Input.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Input.Font = Enum.Font.Code
Input.PlaceholderText = "Paste key here..."
Input.Text = ""
Input.TextColor3 = Color3.fromRGB(255, 255, 255)
Input.TextSize = 12
local InpCorner = Instance.new("UICorner")
InpCorner.CornerRadius = UDim.new(0, 4)
InpCorner.Parent = Input

local Verify = Instance.new("TextButton")
Verify.Parent = Content
Verify.Position = UDim2.new(1, -80, 0, 105)
Verify.Size = UDim2.new(0, 60, 0, 35)
Verify.BackgroundColor3 = Color3.fromRGB(99, 102, 241)
Verify.Font = Enum.Font.GothamBold
Verify.Text = "ACTIVATE"
Verify.TextColor3 = Color3.fromRGB(255, 255, 255)
Verify.TextSize = 10
local VCorner = Instance.new("UICorner")
VCorner.CornerRadius = UDim.new(0, 4)
VCorner.Parent = Verify

-- 6. Logic Nút bấm
GetKey.MouseButton1Click:Connect(function()
    setclipboard("https://link-target.net/4260973/DdlBGNdHRyrN")
    GetKey.Text = "LINK COPIED!"
    wait(2)
    GetKey.Text = "GET ACCESS KEY"
end)

Verify.MouseButton1Click:Connect(function()
    if Input.Text == "VANGUARD_SECRET_KEY" then
        Verify.Text = "OK!"
        wait(0.5)
        ScreenGui:Destroy()
        -- Chèn code game của bạn ở đây
    else
        Verify.Text = "WRONG!"
        wait(1)
        Verify.Text = "ACTIVATE"
    end
end)

-- Kéo Frame
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
