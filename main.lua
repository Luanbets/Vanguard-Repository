--[[
    VANGUARD UNIVERSAL HUB - AUTHENTICATION SYSTEM
    Thiết kế tối giản, uy tín, tự động nhận diện Game.
]]

local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

-- 1. Lấy tên Game hiện tại
local gameName = "Unknown Game"
local success, info = pcall(function()
    return MarketplaceService:GetProductInfo(game.PlaceId).Name
end)
if success then gameName = info end

-- 2. Tạo HWID giả lập (hoặc lấy từ ClientId)
local hwid = "ID-" .. string.upper(string.sub(game:GetService("RbxAnalyticsService"):GetClientId(), 1, 12))

-- 3. Cấu hình UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanguardUI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -125)
MainFrame.Size = UDim2.new(0, 500, 0, 250)
MainFrame.ClipsDescendants = true

-- Bo góc cho MainFrame
local Corner = Instance.new("UICorner")
Corner.CornerRadius = ToolAddress.new(0, 4)
Corner.Parent = MainFrame

-- Hiệu ứng bóng đổ/viền
local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(40, 40, 40)
Stroke.Thickness = 1
Stroke.Parent = MainFrame

-- 4. Header Bar
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = MainFrame
Header.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Header.Size = UDim2.new(1, 0, 0, 35)

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Parent = Header
HeaderTitle.Position = UDim2.new(0, 40, 0, 0)
HeaderTitle.Size = UDim2.new(0, 300, 1, 0)
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.Text = "VANGUARD | " .. string.upper(gameName)
HeaderTitle.TextColor3 = Color3.fromRGB(230, 230, 230)
HeaderTitle.TextSize = 11
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left

local Dot = Instance.new("Frame")
Dot.Parent = Header
Dot.BackgroundColor3 = Color3.fromRGB(99, 102, 241) -- Indigo
Dot.Position = UDim2.new(0, 15, 0.5, -3)
Dot.Size = UDim2.new(0, 6, 0, 6)
local DotCorner = Instance.new("UICorner")
DotCorner.CornerRadius = UDim.new(1, 0)
DotCorner.Parent = Dot

-- 5. Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.Size = UDim2.new(0, 140, 1, -35)

local SidebarLine = Instance.new("Frame")
SidebarLine.Parent = Sidebar
SidebarLine.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SidebarLine.Position = UDim2.new(1, -1, 0, 0)
SidebarLine.Size = UDim2.new(0, 1, 1, 0)

-- Sidebar Buttons (Giả lập menu uy tín)
local function CreateSidebarItem(name, isActive)
    local btn = Instance.new("TextLabel")
    btn.Parent = Sidebar
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Position = UDim2.new(0, 0, 0, (#Sidebar:GetChildren() - 1) * 30)
    btn.BackgroundColor3 = isActive and Color3.fromRGB(25, 25, 25) or Color3.fromRGB(0,0,0)
    btn.BackgroundTransparency = isActive and 0.5 or 1
    btn.Font = Enum.Font.GothamBold
    btn.Text = "  " .. name
    btn.TextColor3 = isActive and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(80, 80, 80)
    btn.TextSize = 9
    btn.TextXAlignment = Enum.TextXAlignment.Left
    
    if isActive then
        local activeLine = Instance.new("Frame")
        activeLine.Parent = btn
        activeLine.BackgroundColor3 = Color3.fromRGB(99, 102, 241)
        activeLine.Size = UDim2.new(0, 2, 1, 0)
    end
end

CreateSidebarItem("AUTHENTICATION", true)
CreateSidebarItem("MODULE LIST", false)
CreateSidebarItem("CONFIGURATIONS", false)
CreateSidebarItem("SETTINGS", false)

-- 6. Main Content
local Content = Instance.new("Frame")
Content.Parent = MainFrame
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 140, 0, 35)
Content.Size = UDim2.new(1, -140, 1, -35)

local Title = Instance.new("TextLabel")
Title.Parent = Content
Title.Position = UDim2.new(0, 25, 0, 25)
Title.Size = UDim2.new(0, 200, 0, 20)
Title.Font = Enum.Font.GothamBold
Title.Text = "CLIENT ACTIVATION"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

local Subtitle = Instance.new("TextLabel")
Subtitle.Parent = Content
Subtitle.Position = UDim2.new(0, 25, 0, 45)
Subtitle.Size = UDim2.new(0, 280, 0, 40)
Subtitle.BackgroundTransparency = 1
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "To access " .. gameName .. " premium features, please provide a unique 24-hour access key."
Subtitle.TextColor3 = Color3.fromRGB(120, 120, 120)
Subtitle.TextSize = 10
Subtitle.TextWrapped = true
Subtitle.TextXAlignment = Enum.TextXAlignment.Left

-- Nút Get Key
local GetKey = Instance.new("TextButton")
GetKey.Parent = Content
GetKey.Position = UDim2.new(0, 25, 0, 100)
GetKey.Size = UDim2.new(0, 285, 0, 35)
GetKey.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
GetKey.BorderSizePixel = 0
GetKey.Font = Enum.Font.GothamBold
GetKey.Text = "GET ACCESS KEY"
GetKey.TextColor3 = Color3.fromRGB(200, 200, 200)
GetKey.TextSize = 10

local GetKeyStroke = Instance.new("UIStroke")
GetKeyStroke.Color = Color3.fromRGB(40, 40, 40)
GetKeyStroke.Parent = GetKey

-- Ô nhập Key
local Input = Instance.new("TextBox")
Input.Parent = Content
Input.Position = UDim2.new(0, 25, 0, 145)
Input.Size = UDim2.new(0, 200, 0, 35)
Input.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Input.BorderSizePixel = 0
Input.Font = Enum.Font.Code
Input.PlaceholderText = "ENTER KEY"
Input.Text = ""
Input.TextColor3 = Color3.fromRGB(99, 102, 241)
Input.TextSize = 11

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(30, 30, 30)
InputStroke.Parent = Input

-- Nút Verify
local Verify = Instance.new("TextButton")
Verify.Parent = Content
Verify.Position = UDim2.new(0, 235, 0, 145)
Verify.Size = UDim2.new(0, 75, 0, 35)
Verify.BackgroundColor3 = Color3.fromRGB(99, 102, 241)
Verify.BorderSizePixel = 0
Verify.Font = Enum.Font.GothamBold
Verify.Text = "VERIFY"
Verify.TextColor3 = Color3.fromRGB(255, 255, 255)
Verify.TextSize = 10

-- Footer Info
local Footer = Instance.new("TextLabel")
Footer.Parent = Content
Footer.Position = UDim2.new(0, 25, 1, -30)
Footer.Size = UDim2.new(0, 285, 0, 20)
Footer.BackgroundTransparency = 1
Footer.Font = Enum.Font.Code
Footer.Text = "HWID: " .. hwid
Footer.TextColor3 = Color3.fromRGB(50, 50, 50)
Footer.TextSize = 8
Footer.TextXAlignment = Enum.TextXAlignment.Left

-- 7. Chức năng (Logic)
GetKey.MouseButton1Click:Connect(function()
    setclipboard("https://link-target.net/4260973/DdlBGNdHRyrN")
    GetKey.Text = "LINK COPIED TO CLIPBOARD"
    wait(2)
    GetKey.Text = "GET ACCESS KEY"
end)

Verify.MouseButton1Click:Connect(function()
    if Input.Text == "VANGUARD_SECRET_KEY" then -- Thay Key thật của bạn ở đây
        Verify.Text = "SUCCESS"
        Verify.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
        wait(1)
        MainFrame:Destroy()
        -- Chạy script hack thật tại đây
    else
        Verify.Text = "INVALID"
        Verify.BackgroundColor3 = Color3.fromRGB(220, 38, 38)
        wait(1)
        Verify.Text = "VERIFY"
        Verify.BackgroundColor3 = Color3.fromRGB(99, 102, 241)
    end
end)

-- Cho phép kéo giao diện
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
MainFrame.InputChanged:Connect(function(input)
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

print("Vanguard System Loaded Successfully.")
