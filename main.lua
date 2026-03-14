-- VANGUARD CLEAN FIX (ANTI-BLACK SCREEN)
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

-- Xóa UI cũ để tránh kẹt màn hình
if CoreGui:FindFirstChild("VanguardUI") then
    CoreGui.VanguardUI:Destroy()
end

local sg = Instance.new("ScreenGui")
sg.Name = "VanguardUI"
sg.Parent = CoreGui
sg.IgnoreGuiInset = false -- ← FIX 1: Đổi thành false
sg.ResetOnSpawn = false   -- ← FIX 2: Tránh bị reset

-- Lớp phủ mờ phía sau (thay vì frame đen đặc)
local overlay = Instance.new("Frame")
overlay.Parent = sg
overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
overlay.BackgroundTransparency = 0.5  -- ← FIX 3: Mờ thay vì đen đặc
overlay.BorderSizePixel = 0
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.ZIndex = 1

-- Khung chính
local mf = Instance.new("Frame")
mf.Name = "Main"
mf.Parent = sg
mf.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mf.BorderSizePixel = 2
mf.BorderColor3 = Color3.fromRGB(60, 60, 60)
mf.Position = UDim2.new(0.5, -225, 0.5, -110)
mf.Size = UDim2.new(0, 450, 0, 220)
mf.Active = true
mf.Draggable = true
mf.ZIndex = 2  -- ← FIX 4: Đặt ZIndex cao hơn overlay

-- Header
local head = Instance.new("Frame")
head.Parent = mf
head.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
head.BorderSizePixel = 0
head.Size = UDim2.new(1, 0, 0, 30)
head.ZIndex = 3

local title = Instance.new("TextLabel")
title.Parent = head
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 10, 0, 0)
title.Size = UDim2.new(1, -10, 1, 0)
title.Font = Enum.Font.SourceSansBold
title.Text = "VANGUARD HUB | VERSION 6.0"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 4

-- Body
local body = Instance.new("Frame")
body.Parent = mf
body.BackgroundTransparency = 1
body.Position = UDim2.new(0, 0, 0, 30)
body.Size = UDim2.new(1, 0, 1, -30)
body.ZIndex = 3

local info = Instance.new("TextLabel")
info.Parent = body
info.BackgroundTransparency = 1
info.Position = UDim2.new(0, 20, 0, 15)
info.Size = UDim2.new(1, -40, 0, 40)
info.Font = Enum.Font.SourceSans
info.Text = "Universal Authentication Required. Please get your 24h access key below."
info.TextColor3 = Color3.fromRGB(200, 200, 200)
info.TextSize = 14
info.TextWrapped = true
info.TextYAlignment = Enum.TextYAlignment.Top
info.ZIndex = 4

-- Nút GET KEY
local btnGet = Instance.new("TextButton")
btnGet.Parent = body
btnGet.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
btnGet.BorderSizePixel = 1
btnGet.BorderColor3 = Color3.fromRGB(80, 80, 80)
btnGet.Position = UDim2.new(0.5, -100, 0, 70)
btnGet.Size = UDim2.new(0, 200, 0, 35)
btnGet.Font = Enum.Font.SourceSansBold
btnGet.Text = "GET ACCESS KEY"
btnGet.TextColor3 = Color3.fromRGB(255, 255, 255)
btnGet.TextSize = 16
btnGet.ZIndex = 4

-- Ô nhập key
local box = Instance.new("TextBox")
box.Parent = body
box.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
box.BorderSizePixel = 1
box.BorderColor3 = Color3.fromRGB(80, 80, 80)
box.Position = UDim2.new(0.5, -100, 0, 115)
box.Size = UDim2.new(0, 200, 0, 35)
box.Font = Enum.Font.Code
box.PlaceholderText = "Paste key here..."
box.Text = ""
box.TextColor3 = Color3.fromRGB(100, 255, 100)
box.TextSize = 14
box.ZIndex = 4

-- Nút VERIFY
local btnVerify = Instance.new("TextButton")
btnVerify.Parent = body
btnVerify.BackgroundColor3 = Color3.fromRGB(70, 80, 200)
btnVerify.BorderSizePixel = 0
btnVerify.Position = UDim2.new(0.5, -100, 0, 160)
btnVerify.Size = UDim2.new(0, 200, 0, 35)
btnVerify.Font = Enum.Font.SourceSansBold
btnVerify.Text = "ACTIVATE SYSTEM"
btnVerify.TextColor3 = Color3.fromRGB(255, 255, 255)
btnVerify.TextSize = 16
btnVerify.ZIndex = 4

-- Logic
btnGet.MouseButton1Click:Connect(function()
    setclipboard("https://link-target.net/4260973/DdlBGNdHRyrN")
    btnGet.Text = "COPIED TO CLIPBOARD!"
    task.wait(2)  -- ← FIX 5: Dùng task.wait thay vì wait (deprecated)
    btnGet.Text = "GET ACCESS KEY"
end)

btnVerify.MouseButton1Click:Connect(function()
    if box.Text == "VANGUARD_SECRET_KEY" then
        btnVerify.Text = "SUCCESS!"
        btnVerify.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        task.wait(1)
        sg:Destroy()
    else
        btnVerify.Text = "INVALID KEY"
        btnVerify.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        task.wait(1)
        btnVerify.Text = "ACTIVATE SYSTEM"
        btnVerify.BackgroundColor3 = Color3.fromRGB(70, 80, 200)
    end
end)
