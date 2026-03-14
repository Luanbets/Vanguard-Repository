-- VANGUARD HUB | VERSION 6.1.0
-- Optimized for Executors (Delta, Synapse, etc.)

local CoreGui = game:GetService("CoreGui")
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")

-- Xóa UI cũ
if CoreGui:FindFirstChild("VanguardUI") then
    CoreGui.VanguardUI:Destroy()
end

-- Generate HWID giả
local function generateHWID()
    local parts = {}
    for i = 1, 4 do
        local part = string.format("%04X", math.random(0, 65535))
        table.insert(parts, part)
    end
    return table.concat(parts, "-")
end

-- Detect Game Name
local function getGameName()
    local success, info = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)
    if success and info then
        return string.upper(info.Name)
    end
    return "UNKNOWN GAME"
end

local HWID = generateHWID()
local GAME_NAME = getGameName()
local TARGET_LINK = "https://link-target.net/4260973/DdlBGNdHRyrN"
local SECRET_KEY = "VANGUARD_SECRET_KEY"

-- ScreenGui
local sg = Instance.new("ScreenGui")
sg.Name = "VanguardUI"
sg.Parent = CoreGui
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Overlay mờ phía sau
local overlay = Instance.new("Frame")
overlay.Parent = sg
overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
overlay.BackgroundTransparency = 0.45
overlay.BorderSizePixel = 0
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.ZIndex = 1

-- Main Window
local main = Instance.new("Frame")
main.Name = "Main"
main.Parent = sg
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
main.BorderSizePixel = 1
main.BorderColor3 = Color3.fromRGB(42, 42, 42)
main.Position = UDim2.new(0.5, -320, 0.5, -130)
main.Size = UDim2.new(0, 640, 0, 260)
main.Active = true
main.Draggable = true
main.ZIndex = 2

-- ===== TITLE BAR =====
local titleBar = Instance.new("Frame")
titleBar.Parent = main
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleBar.BorderSizePixel = 0
titleBar.Size = UDim2.new(1, 0, 0, 34)
titleBar.ZIndex = 3

-- Dot tím
local dot = Instance.new("Frame")
dot.Parent = titleBar
dot.BackgroundColor3 = Color3.fromRGB(99, 102, 241)
dot.BorderSizePixel = 0
dot.Position = UDim2.new(0, 12, 0.5, -4)
dot.Size = UDim2.new(0, 8, 0, 8)
dot.ZIndex = 4
local dotCorner = Instance.new("UICorner")
dotCorner.CornerRadius = UDim.new(1, 0)
dotCorner.Parent = dot

-- Title Text
local titleText = Instance.new("TextLabel")
titleText.Parent = titleBar
titleText.BackgroundTransparency = 1
titleText.Position = UDim2.new(0, 28, 0, 0)
titleText.Size = UDim2.new(1, -100, 1, 0)
titleText.Font = Enum.Font.Code
titleText.Text = "VANGUARD | " .. GAME_NAME
titleText.TextColor3 = Color3.fromRGB(228, 228, 231)
titleText.TextSize = 11
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.ZIndex = 4

-- Version Badge
local versionLabel = Instance.new("TextLabel")
versionLabel.Parent = titleBar
versionLabel.BackgroundTransparency = 1
versionLabel.Position = UDim2.new(1, -120, 0, 0)
versionLabel.Size = UDim2.new(0, 110, 1, 0)
versionLabel.Font = Enum.Font.Code
versionLabel.Text = "STABLE_V6.1.0"
versionLabel.TextColor3 = Color3.fromRGB(63, 63, 70)
versionLabel.TextSize = 9
versionLabel.TextXAlignment = Enum.TextXAlignment.Right
versionLabel.ZIndex = 4

-- Divider bên dưới titlebar
local divider = Instance.new("Frame")
divider.Parent = main
divider.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
divider.BorderSizePixel = 0
divider.Position = UDim2.new(0, 0, 0, 34)
divider.Size = UDim2.new(1, 0, 0, 1)
divider.ZIndex = 3

-- ===== SIDEBAR =====
local sidebar = Instance.new("Frame")
sidebar.Parent = main
sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
sidebar.BorderSizePixel = 0
sidebar.Position = UDim2.new(0, 0, 0, 35)
sidebar.Size = UDim2.new(0, 180, 1, -35)
sidebar.ZIndex = 3

-- Sidebar divider kẻ phải
local sideDiv = Instance.new("Frame")
sideDiv.Parent = sidebar
sideDiv.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
sideDiv.BorderSizePixel = 0
sideDiv.Position = UDim2.new(1, -1, 0, 0)
sideDiv.Size = UDim2.new(0, 1, 1, 0)
sideDiv.ZIndex = 4

-- Nav: AUTH SYSTEM (active)
local navAuth = Instance.new("Frame")
navAuth.Parent = sidebar
navAuth.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
navAuth.BorderSizePixel = 0
navAuth.Position = UDim2.new(0, 0, 0, 10)
navAuth.Size = UDim2.new(1, -2, 0, 26)
navAuth.ZIndex = 4

local navAuthAccent = Instance.new("Frame")
navAuthAccent.Parent = navAuth
navAuthAccent.BackgroundColor3 = Color3.fromRGB(99, 102, 241)
navAuthAccent.BorderSizePixel = 0
navAuthAccent.Size = UDim2.new(0, 2, 1, 0)
navAuthAccent.ZIndex = 5

local navAuthLabel = Instance.new("TextLabel")
navAuthLabel.Parent = navAuth
navAuthLabel.BackgroundTransparency = 1
navAuthLabel.Position = UDim2.new(0, 10, 0, 0)
navAuthLabel.Size = UDim2.new(1, -10, 1, 0)
navAuthLabel.Font = Enum.Font.Code
navAuthLabel.Text = "AUTH SYSTEM"
navAuthLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
navAuthLabel.TextSize = 9
navAuthLabel.TextXAlignment = Enum.TextXAlignment.Left
navAuthLabel.ZIndex = 5

-- Nav: MODULE LIST (disabled)
local navModule = Instance.new("TextLabel")
navModule.Parent = sidebar
navModule.BackgroundTransparency = 1
navModule.Position = UDim2.new(0, 10, 0, 42)
navModule.Size = UDim2.new(1, -10, 0, 26)
navModule.Font = Enum.Font.Code
navModule.Text = "MODULE LIST"
navModule.TextColor3 = Color3.fromRGB(63, 63, 70)
navModule.TextSize = 9
navModule.TextXAlignment = Enum.TextXAlignment.Left
navModule.ZIndex = 4

-- Nav: CONFIGURATION (disabled)
local navConfig = Instance.new("TextLabel")
navConfig.Parent = sidebar
navConfig.BackgroundTransparency = 1
navConfig.Position = UDim2.new(0, 10, 0, 70)
navConfig.Size = UDim2.new(1, -10, 0, 26)
navConfig.Font = Enum.Font.Code
navConfig.Text = "CONFIGURATION"
navConfig.TextColor3 = Color3.fromRGB(63, 63, 70)
navConfig.TextSize = 9
navConfig.TextXAlignment = Enum.TextXAlignment.Left
navConfig.ZIndex = 4

-- Discord Button
local discordBtn = Instance.new("TextButton")
discordBtn.Parent = sidebar
discordBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
discordBtn.BorderSizePixel = 1
discordBtn.BorderColor3 = Color3.fromRGB(42, 42, 42)
discordBtn.Position = UDim2.new(0, 8, 1, -60)
discordBtn.Size = UDim2.new(1, -16, 0, 22)
discordBtn.Font = Enum.Font.Code
discordBtn.Text = "OFFICIAL DISCORD"
discordBtn.TextColor3 = Color3.fromRGB(129, 140, 248)
discordBtn.TextSize = 9
discordBtn.ZIndex = 4

-- Target Game label
local gameLabel = Instance.new("TextLabel")
gameLabel.Parent = sidebar
gameLabel.BackgroundTransparency = 1
gameLabel.Position = UDim2.new(0, 10, 1, -32)
gameLabel.Size = UDim2.new(1, -14, 0, 12)
gameLabel.Font = Enum.Font.Code
gameLabel.Text = "TARGET GAME:"
gameLabel.TextColor3 = Color3.fromRGB(63, 63, 70)
gameLabel.TextSize = 8
gameLabel.TextXAlignment = Enum.TextXAlignment.Left
gameLabel.ZIndex = 4

local gameNameLabel = Instance.new("TextLabel")
gameNameLabel.Parent = sidebar
gameNameLabel.BackgroundTransparency = 1
gameNameLabel.Position = UDim2.new(0, 10, 1, -18)
gameNameLabel.Size = UDim2.new(1, -14, 0, 14)
gameNameLabel.Font = Enum.Font.Code
gameNameLabel.Text = GAME_NAME
gameNameLabel.TextColor3 = Color3.fromRGB(113, 113, 122)
gameNameLabel.TextSize = 9
gameNameLabel.TextXAlignment = Enum.TextXAlignment.Left
gameNameLabel.TextTruncate = Enum.TextTruncate.AtEnd
gameNameLabel.ZIndex = 4

-- ===== MAIN CONTENT PANEL =====
local content = Instance.new("Frame")
content.Parent = main
content.BackgroundTransparency = 1
content.Position = UDim2.new(0, 180, 0, 35)
content.Size = UDim2.new(1, -180, 1, -35)
content.ZIndex = 3

-- Title
local verifyTitle = Instance.new("TextLabel")
verifyTitle.Parent = content
verifyTitle.BackgroundTransparency = 1
verifyTitle.Position = UDim2.new(0, 24, 0, 22)
verifyTitle.Size = UDim2.new(1, -48, 0, 16)
verifyTitle.Font = Enum.Font.Code
verifyTitle.Text = "VERIFICATION REQUIRED"
verifyTitle.TextColor3 = Color3.fromRGB(244, 244, 245)
verifyTitle.TextSize = 11
verifyTitle.TextXAlignment = Enum.TextXAlignment.Left
verifyTitle.ZIndex = 4

-- Description
local desc = Instance.new("TextLabel")
desc.Parent = content
desc.BackgroundTransparency = 1
desc.Position = UDim2.new(0, 24, 0, 40)
desc.Size = UDim2.new(1, -48, 0, 30)
desc.Font = Enum.Font.Code
desc.Text = "To access " .. GAME_NAME .. " premium features, please\nprovide a unique 24-hour access key."
desc.TextColor3 = Color3.fromRGB(82, 82, 91)
desc.TextSize = 10
desc.TextXAlignment = Enum.TextXAlignment.Left
desc.TextYAlignment = Enum.TextYAlignment.Top
desc.ZIndex = 4

-- Input Box
local keyBox = Instance.new("TextBox")
keyBox.Parent = content
keyBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
keyBox.BorderSizePixel = 1
keyBox.BorderColor3 = Color3.fromRGB(39, 39, 42)
keyBox.Position = UDim2.new(0, 24, 0, 82)
keyBox.Size = UDim2.new(1, -116, 0, 32)
keyBox.Font = Enum.Font.Code
keyBox.PlaceholderText = "ENTER KEY"
keyBox.PlaceholderColor3 = Color3.fromRGB(39, 39, 42)
keyBox.Text = ""
keyBox.TextColor3 = Color3.fromRGB(129, 140, 248)
keyBox.TextSize = 11
keyBox.ClearTextOnFocus = false
keyBox.ZIndex = 4

-- Verify Button
local verifyBtn = Instance.new("TextButton")
verifyBtn.Parent = content
verifyBtn.BackgroundColor3 = Color3.fromRGB(79, 70, 229)
verifyBtn.BorderSizePixel = 0
verifyBtn.Position = UDim2.new(1, -84, 0, 82)
verifyBtn.Size = UDim2.new(0, 80, 0, 32)
verifyBtn.Font = Enum.Font.Code
verifyBtn.Text = "VERIFY"
verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
verifyBtn.TextSize = 10
verifyBtn.ZIndex = 4

-- Get Key Link
local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Parent = content
getKeyBtn.BackgroundTransparency = 1
getKeyBtn.BorderSizePixel = 0
getKeyBtn.Position = UDim2.new(0, 24, 0, 122)
getKeyBtn.Size = UDim2.new(0, 160, 0, 18)
getKeyBtn.Font = Enum.Font.Code
getKeyBtn.Text = "CLICK HERE TO GET KEY"
getKeyBtn.TextColor3 = Color3.fromRGB(113, 113, 122)
getKeyBtn.TextSize = 9
getKeyBtn.TextXAlignment = Enum.TextXAlignment.Left
getKeyBtn.ZIndex = 4

-- Status Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Parent = content
statusLabel.BackgroundTransparency = 1
statusLabel.Position = UDim2.new(1, -200, 0, 122)
statusLabel.Size = UDim2.new(0, 196, 0, 18)
statusLabel.Font = Enum.Font.Code
statusLabel.Text = "INITIALIZING SYSTEM"
statusLabel.TextColor3 = Color3.fromRGB(82, 82, 91)
statusLabel.TextSize = 9
statusLabel.TextXAlignment = Enum.TextXAlignment.Right
statusLabel.ZIndex = 4

-- ===== FOOTER =====
local footer = Instance.new("Frame")
footer.Parent = main
footer.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
footer.BorderSizePixel = 0
footer.Position = UDim2.new(0, 0, 1, -24)
footer.Size = UDim2.new(1, 0, 0, 24)
footer.ZIndex = 3

local footerDiv = Instance.new("Frame")
footerDiv.Parent = footer
footerDiv.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
footerDiv.BorderSizePixel = 0
footerDiv.Size = UDim2.new(1, 0, 0, 1)
footerDiv.ZIndex = 4

local footerLeft = Instance.new("TextLabel")
footerLeft.Parent = footer
footerLeft.BackgroundTransparency = 1
footerLeft.Position = UDim2.new(0, 12, 0, 0)
footerLeft.Size = UDim2.new(0.7, 0, 1, 0)
footerLeft.Font = Enum.Font.Code
footerLeft.Text = "GAME ID IDENTIFIED   •   HWID: " .. HWID
footerLeft.TextColor3 = Color3.fromRGB(63, 63, 70)
footerLeft.TextSize = 8
footerLeft.TextXAlignment = Enum.TextXAlignment.Left
footerLeft.ZIndex = 4

local footerRight = Instance.new("TextLabel")
footerRight.Parent = footer
footerRight.BackgroundTransparency = 1
footerRight.Position = UDim2.new(0.3, 0, 0, 0)
footerRight.Size = UDim2.new(0.7, -12, 1, 0)
footerRight.Font = Enum.Font.Code
footerRight.Text = "ENCRYPTED SESSION"
footerRight.TextColor3 = Color3.fromRGB(39, 39, 42)
footerRight.TextSize = 8
footerRight.TextXAlignment = Enum.TextXAlignment.Right
footerRight.ZIndex = 4

-- ===== LOGIC =====
local function setStatus(text, r, g, b)
    statusLabel.Text = string.upper(text)
    statusLabel.TextColor3 = Color3.fromRGB(r, g, b)
end

-- Khởi động: set status sau 1.5s
task.delay(1.5, function()
    setStatus("System ready for " .. GAME_NAME, 113, 113, 122)
end)

-- GET KEY Button
getKeyBtn.MouseButton1Click:Connect(function()
    pcall(function() setclipboard(TARGET_LINK) end)
    getKeyBtn.Text = "COPIED TO CLIPBOARD!"
    getKeyBtn.TextColor3 = Color3.fromRGB(129, 140, 248)
    setStatus("Link copied", 129, 140, 248)
    task.delay(2, function()
        getKeyBtn.Text = "CLICK HERE TO GET KEY"
        getKeyBtn.TextColor3 = Color3.fromRGB(113, 113, 122)
    end)
end)

-- VERIFY Button
verifyBtn.MouseButton1Click:Connect(function()
    local key = keyBox.Text
    if key == "" then
        setStatus("No key provided", 248, 113, 113)
        keyBox.BorderColor3 = Color3.fromRGB(153, 27, 27)
        task.delay(1.5, function()
            keyBox.BorderColor3 = Color3.fromRGB(39, 39, 42)
        end)
        return
    end

    verifyBtn.Text = "..."
    verifyBtn.BackgroundColor3 = Color3.fromRGB(63, 63, 70)
    setStatus("Authenticating...", 113, 113, 122)

    task.delay(1.4, function()
        if key == SECRET_KEY then
            verifyBtn.Text = "SUCCESS!"
            verifyBtn.BackgroundColor3 = Color3.fromRGB(22, 163, 74)
            setStatus("Access granted", 74, 222, 128)
            -- ✅ Dán script chính của bạn vào đây
        else
            verifyBtn.Text = "INVALID"
            verifyBtn.BackgroundColor3 = Color3.fromRGB(153, 27, 27)
            keyBox.BorderColor3 = Color3.fromRGB(153, 27, 27)
            setStatus("Auth failed: invalid key", 248, 113, 113)
            task.delay(2, function()
                verifyBtn.Text = "VERIFY"
                verifyBtn.BackgroundColor3 = Color3.fromRGB(79, 70, 229)
                keyBox.BorderColor3 = Color3.fromRGB(39, 39, 42)
            end)
        end
    end)
end)

-- Hover effect cho Verify button
verifyBtn.MouseEnter:Connect(function()
    if verifyBtn.Text == "VERIFY" then
        verifyBtn.BackgroundColor3 = Color3.fromRGB(99, 102, 241)
    end
end)
verifyBtn.MouseLeave:Connect(function()
    if verifyBtn.Text == "VERIFY" then
        verifyBtn.BackgroundColor3 = Color3.fromRGB(79, 70, 229)
    end
end)
