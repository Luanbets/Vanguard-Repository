-- VANGUARD HUB V6.2 | FULL SCRIPT
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local MPS = game:GetService("MarketplaceService")

if CoreGui:FindFirstChild("VanguardUI") then
    CoreGui.VanguardUI:Destroy()
end

-- ══════════════════════════════════════
--  RESPONSIVE SCALE
-- ══════════════════════════════════════
local vp = workspace.CurrentCamera.ViewportSize
local isMobile = vp.X < 600

local W   = isMobile and math.min(vp.X - 20, 340) or 580
local H   = isMobile and 300 or 380
local TH  = isMobile and 28 or 32
local SW  = isMobile and 0 or 160
local FS  = isMobile and 12 or 13
local FSS = isMobile and 10 or 11

-- ══════════════════════════════════════
--  GAME DETECTION
-- ══════════════════════════════════════
local gameName = "Unknown Game"
pcall(function()
    local info = MPS:GetProductInfo(game.PlaceId)
    gameName = info.Name or "Unknown Game"
end)

local hwid = ""
for i = 1, 4 do
    hwid = hwid .. (i > 1 and "-" or "")
    for _ = 1, 4 do
        hwid = hwid .. string.format("%X", math.random(0, 15))
    end
end

-- ══════════════════════════════════════
--  SCREEN GUI
-- ══════════════════════════════════════
local sg = Instance.new("ScreenGui")
sg.Name             = "VanguardUI"
sg.Parent           = CoreGui
sg.ResetOnSpawn     = false
sg.IgnoreGuiInset   = false
sg.DisplayOrder     = 999

local overlay = Instance.new("Frame")
overlay.Parent                  = sg
overlay.Size                    = UDim2.new(1,0,1,0)
overlay.BackgroundColor3        = Color3.fromRGB(0,0,0)
overlay.BackgroundTransparency  = 0.45
overlay.BorderSizePixel         = 0
overlay.ZIndex                  = 10

-- ══════════════════════════════════════
--  HELPERS
-- ══════════════════════════════════════
local function makeCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 4)
    c.Parent = parent
end

local function makeStroke(parent, color, thickness)
    -- xóa stroke cũ nếu có
    for _, v in ipairs(parent:GetChildren()) do
        if v:IsA("UIStroke") then v:Destroy() end
    end
    local s = Instance.new("UIStroke")
    s.Color     = color or Color3.fromRGB(50,50,65)
    s.Thickness = thickness or 1
    s.Parent    = parent
end

local function label(parent, text, size, color, bold, xa, ya)
    local l = Instance.new("TextLabel")
    l.Parent                 = parent
    l.BackgroundTransparency = 1
    l.Size                   = UDim2.new(1,0,1,0)
    l.Text                   = text
    l.TextSize               = size or FS
    l.Font                   = bold and Enum.Font.GothamBold or Enum.Font.Gotham
    l.TextColor3             = color or Color3.fromRGB(200,200,210)
    l.TextXAlignment         = xa or Enum.TextXAlignment.Left
    l.TextYAlignment         = ya or Enum.TextYAlignment.Center
    l.TextWrapped            = true
    l.ZIndex                 = 20
    return l
end

local function btn(parent, text, bg, fg, size)
    local b = Instance.new("TextButton")
    b.Parent             = parent
    b.BackgroundColor3   = bg or Color3.fromRGB(50,50,140)
    b.AutoButtonColor    = false
    b.BorderSizePixel    = 0
    b.Size               = size or UDim2.new(1,0,0, isMobile and 34 or 36)
    b.Text               = text
    b.TextSize           = FS
    b.Font               = Enum.Font.GothamBold
    b.TextColor3         = fg or Color3.fromRGB(255,255,255)
    b.ZIndex             = 20
    makeCorner(b, 3)
    local origBg = bg or Color3.fromRGB(50,50,140)
    b.MouseEnter:Connect(function()
        b.BackgroundColor3 = Color3.new(
            math.min(origBg.R + 0.07, 1),
            math.min(origBg.G + 0.07, 1),
            math.min(origBg.B + 0.07, 1)
        )
    end)
    b.MouseLeave:Connect(function()
        b.BackgroundColor3 = origBg
    end)
    return b
end

-- ══════════════════════════════════════
--  MAIN WINDOW
-- ══════════════════════════════════════
local mf = Instance.new("Frame")
mf.Name             = "Main"
mf.Parent           = sg
mf.BackgroundColor3 = Color3.fromRGB(14,14,20)
mf.BorderSizePixel  = 0
mf.Size             = UDim2.new(0, W, 0, H)
mf.Position         = UDim2.new(0.5, -W/2, 0.5, -H/2)
mf.Active           = true
mf.Draggable        = true
mf.ZIndex           = 11
makeCorner(mf, 6)
makeStroke(mf, Color3.fromRGB(45,45,65), 1)

-- ── TITLEBAR ──────────────────────────
local titlebar = Instance.new("Frame")
titlebar.Parent           = mf
titlebar.BackgroundColor3 = Color3.fromRGB(18,18,26)
titlebar.BorderSizePixel  = 0
titlebar.Size             = UDim2.new(1,0,0,TH)
titlebar.ZIndex           = 12
makeCorner(titlebar, 6)

local titleFix = Instance.new("Frame")
titleFix.Parent           = titlebar
titleFix.BackgroundColor3 = Color3.fromRGB(18,18,26)
titleFix.BorderSizePixel  = 0
titleFix.Position         = UDim2.new(0,0,0.5,0)
titleFix.Size             = UDim2.new(1,0,0.5,0)
titleFix.ZIndex           = 12

local dot = Instance.new("Frame")
dot.Parent           = titlebar
dot.BackgroundColor3 = Color3.fromRGB(100,102,241)
dot.BorderSizePixel  = 0
dot.Size             = UDim2.new(0,7,0,7)
dot.Position         = UDim2.new(0,10,0.5,-3)
dot.ZIndex           = 13
makeCorner(dot, 10)

local titleLbl = label(titlebar,
    "VANGUARD HUB  |  " .. gameName:upper(),
    FSS, Color3.fromRGB(160,160,200), true)
titleLbl.Position = UDim2.new(0,24,0,0)
titleLbl.Size     = UDim2.new(1,-90,1,0)
titleLbl.ZIndex   = 13

local verBadge = Instance.new("Frame")
verBadge.Parent           = titlebar
verBadge.BackgroundColor3 = Color3.fromRGB(30,30,45)
verBadge.BorderSizePixel  = 0
verBadge.Size             = UDim2.new(0,70,0,18)
verBadge.Position         = UDim2.new(1,-80,0.5,-9)
verBadge.ZIndex           = 13
makeCorner(verBadge, 3)
local verLbl = label(verBadge, "V6.2 STABLE", FSS-1,
    Color3.fromRGB(90,90,120), false, Enum.TextXAlignment.Center)
verLbl.ZIndex = 14

local closeBtn = Instance.new("TextButton")
closeBtn.Parent           = titlebar
closeBtn.BackgroundColor3 = Color3.fromRGB(160,40,40)
closeBtn.BorderSizePixel  = 0
closeBtn.Size             = UDim2.new(0,18,0,18)
closeBtn.Position         = UDim2.new(1,-28,0.5,-9)
closeBtn.Text             = "x"
closeBtn.TextSize         = FSS
closeBtn.Font             = Enum.Font.GothamBold
closeBtn.TextColor3       = Color3.fromRGB(255,255,255)
closeBtn.ZIndex           = 14
makeCorner(closeBtn, 3)
closeBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

-- ── BODY ──────────────────────────────
local bodyFrame = Instance.new("Frame")
bodyFrame.Parent                 = mf
bodyFrame.BackgroundTransparency = 1
bodyFrame.BorderSizePixel        = 0
bodyFrame.Position               = UDim2.new(0,0,0,TH)
bodyFrame.Size                   = UDim2.new(1,0,1,-TH-(isMobile and 0 or 28))
bodyFrame.ZIndex                 = 12

-- ── SIDEBAR (desktop only) ────────────
if not isMobile then
    local sb = Instance.new("Frame")
    sb.Parent           = bodyFrame
    sb.BackgroundColor3 = Color3.fromRGB(11,11,18)
    sb.BorderSizePixel  = 0
    sb.Size             = UDim2.new(0,SW,1,0)
    sb.ZIndex           = 13

    local sbItems = {
        {"AUTH SYSTEM",   true},
        {"MODULE LIST",   false},
        {"CONFIGURATION", false},
    }
    for i, item in ipairs(sbItems) do
        local row = Instance.new("Frame")
        row.Parent                 = sb
        row.BackgroundColor3       = Color3.fromRGB(25,25,45)
        row.BackgroundTransparency = item[2] and 0 or 1
        row.BorderSizePixel        = 0
        row.Size                   = UDim2.new(1,0,0,32)
        row.Position               = UDim2.new(0,0,0,(i-1)*34+10)
        row.ZIndex                 = 14
        if item[2] then
            local accent = Instance.new("Frame")
            accent.Parent           = row
            accent.BackgroundColor3 = Color3.fromRGB(100,102,241)
            accent.BorderSizePixel  = 0
            accent.Size             = UDim2.new(0,2,1,0)
            accent.ZIndex           = 15
        end
        local rowLbl = label(row, item[1], FSS-1,
            item[2] and Color3.fromRGB(160,160,220)
                     or  Color3.fromRGB(70,70,90), item[2])
        rowLbl.Position = UDim2.new(0,10,0,0)
        rowLbl.ZIndex   = 15
    end

    local hwidLbl = label(sb, "HWID", FSS-2, Color3.fromRGB(55,55,75))
    hwidLbl.Position = UDim2.new(0,8,1,-38)
    hwidLbl.Size     = UDim2.new(1,-8,0,14)
    hwidLbl.ZIndex   = 14

    local hwidVal = label(sb, hwid, FSS-2, Color3.fromRGB(75,75,95))
    hwidVal.Position    = UDim2.new(0,8,1,-24)
    hwidVal.Size        = UDim2.new(1,-8,0,20)
    hwidVal.TextWrapped = true
    hwidVal.ZIndex      = 14
end

-- ── MAIN CONTENT ──────────────────────
local content = Instance.new("Frame")
content.Parent                 = bodyFrame
content.BackgroundTransparency = 1
content.BorderSizePixel        = 0
content.Position               = UDim2.new(0, SW+(isMobile and 12 or 16), 0, 0)
content.Size                   = UDim2.new(1, -(SW+(isMobile and 24 or 32)), 1, 0)
content.ZIndex                 = 13

local authTitle = label(content, "VERIFICATION REQUIRED",
    isMobile and 13 or 14, Color3.fromRGB(220,220,240), true)
authTitle.Position = UDim2.new(0,0,0, isMobile and 12 or 16)
authTitle.Size     = UDim2.new(1,0,0,20)
authTitle.ZIndex   = 14

local desc = label(content,
    "Authenticate your session for " .. gameName .. ". Enter your 24-hour access key below.",
    isMobile and 11 or 12, Color3.fromRGB(110,110,140))
desc.Position    = UDim2.new(0,0,0, isMobile and 38 or 44)
desc.Size        = UDim2.new(1,0,0,30)
desc.TextWrapped = true
desc.ZIndex      = 14

-- status bar
local statusBar = Instance.new("Frame")
statusBar.Parent           = content
statusBar.BackgroundColor3 = Color3.fromRGB(10,10,18)
statusBar.BorderSizePixel  = 0
statusBar.Position         = UDim2.new(0,0,0, isMobile and 74 or 82)
statusBar.Size             = UDim2.new(1,0,0,26)
statusBar.ZIndex           = 14
makeCorner(statusBar, 3)
makeStroke(statusBar, Color3.fromRGB(35,35,55), 1)

local statusDot = Instance.new("Frame")
statusDot.Parent           = statusBar
statusDot.BackgroundColor3 = Color3.fromRGB(80,80,80)
statusDot.BorderSizePixel  = 0
statusDot.Size             = UDim2.new(0,6,0,6)
statusDot.Position         = UDim2.new(0,8,0.5,-3)
statusDot.ZIndex           = 15
makeCorner(statusDot, 10)

local statusLbl = label(statusBar, "INITIALIZING SYSTEM...",
    FSS-1, Color3.fromRGB(100,100,130))
statusLbl.Position = UDim2.new(0,22,0,0)
statusLbl.Size     = UDim2.new(1,-30,1,0)
statusLbl.ZIndex   = 15

-- key input
local inputFrame = Instance.new("Frame")
inputFrame.Parent           = content
inputFrame.BackgroundColor3 = Color3.fromRGB(8,8,14)
inputFrame.BorderSizePixel  = 0
inputFrame.Position         = UDim2.new(0,0,0, isMobile and 108 or 118)
inputFrame.Size             = UDim2.new(1,0,0, isMobile and 34 or 36)
inputFrame.ZIndex           = 14
makeCorner(inputFrame, 3)
makeStroke(inputFrame, Color3.fromRGB(40,40,65), 1)

local keyBox = Instance.new("TextBox")
keyBox.Parent                = inputFrame
keyBox.BackgroundTransparency = 1
keyBox.BorderSizePixel       = 0
keyBox.Position              = UDim2.new(0,10,0,0)
keyBox.Size                  = UDim2.new(1,-10,1,0)
keyBox.Font                  = Enum.Font.Code
keyBox.PlaceholderText       = "XXXX-XXXX-XXXX-XXXX"
keyBox.PlaceholderColor3     = Color3.fromRGB(55,55,75)
keyBox.Text                  = ""
keyBox.TextColor3            = Color3.fromRGB(140,145,255)
keyBox.TextSize              = FS
keyBox.ClearTextOnFocus      = false
keyBox.ZIndex                = 15

-- button row
local btnRow = Instance.new("Frame")
btnRow.Parent                 = content
btnRow.BackgroundTransparency = 1
btnRow.BorderSizePixel        = 0
btnRow.Position               = UDim2.new(0,0,0, isMobile and 150 or 164)
btnRow.Size                   = UDim2.new(1,0,0, isMobile and 34 or 36)
btnRow.ZIndex                 = 14

local btnGetKey = btn(btnRow, "GET KEY",
    Color3.fromRGB(28,28,42),
    Color3.fromRGB(160,160,200),
    UDim2.new(0.48,0,1,0))
btnGetKey.Position = UDim2.new(0,0,0,0)
makeStroke(btnGetKey, Color3.fromRGB(50,50,70), 1)

local btnVerify = btn(btnRow, "ACTIVATE",
    Color3.fromRGB(55,52,160),
    Color3.fromRGB(220,220,255),
    UDim2.new(0.48,0,1,0))
btnVerify.Position = UDim2.new(0.52,0,0,0)

-- progress bar
local progBg = Instance.new("Frame")
progBg.Parent           = content
progBg.BackgroundColor3 = Color3.fromRGB(10,10,18)
progBg.BorderSizePixel  = 0
progBg.Position         = UDim2.new(0,0,0, isMobile and 192 or 210)
progBg.Size             = UDim2.new(1,0,0,3)
progBg.ZIndex           = 14
makeCorner(progBg, 2)

local progFill = Instance.new("Frame")
progFill.Parent           = progBg
progFill.BackgroundColor3 = Color3.fromRGB(100,102,241)
progFill.BorderSizePixel  = 0
progFill.Size             = UDim2.new(0,0,1,0)
progFill.ZIndex           = 15
makeCorner(progFill, 2)

-- ── FOOTER (desktop only) ─────────────
if not isMobile then
    local footer = Instance.new("Frame")
    footer.Parent           = mf
    footer.BackgroundColor3 = Color3.fromRGB(11,11,18)
    footer.BorderSizePixel  = 0
    footer.Position         = UDim2.new(0,0,1,-28)
    footer.Size             = UDim2.new(1,0,0,28)
    footer.ZIndex           = 12
    makeCorner(footer, 6)

    local footFix = Instance.new("Frame")
    footFix.Parent           = footer
    footFix.BackgroundColor3 = Color3.fromRGB(11,11,18)
    footFix.BorderSizePixel  = 0
    footFix.Size             = UDim2.new(1,0,0.5,0)
    footFix.ZIndex           = 12

    local footLbl = label(footer,
        "HWID: "..hwid.."   |   ENCRYPTED SESSION   |   VANGUARD SECURE",
        FSS-2, Color3.fromRGB(55,55,75), false, Enum.TextXAlignment.Center)
    footLbl.ZIndex = 13
end

-- ══════════════════════════════════════
--  LOGIC HELPERS
-- ══════════════════════════════════════
local function setStatus(text, dotColor, textColor)
    statusLbl.Text             = text
    statusLbl.TextColor3       = textColor  or Color3.fromRGB(100,100,130)
    statusDot.BackgroundColor3 = dotColor   or Color3.fromRGB(80,80,80)
end

local function setProgress(pct)
    progFill.Size = UDim2.new(pct/100, 0, 1, 0)
end

local function animateProgress(from, to, duration)
    local steps    = 20
    local stepTime = duration / steps
    for i = 1, steps do
        task.wait(stepTime)
        setProgress(from + ((to - from) * i / steps))
    end
end

-- startup
task.spawn(function()
    task.wait(0.8)
    setStatus("GAME: "..gameName:upper().." — READY",
        Color3.fromRGB(100,102,241),
        Color3.fromRGB(140,140,200))
    animateProgress(0, 30, 0.6)
end)

-- ══════════════════════════════════════
--  GET KEY
-- ══════════════════════════════════════
btnGetKey.MouseButton1Click:Connect(function()
    local link = "https://link-target.net/4260973/DdlBGNdHRyrN"

    local ok = pcall(function()
        setclipboard(link)
    end)

    if ok then
        btnGetKey.Text       = "COPIED TO CLIPBOARD!"
        btnGetKey.TextColor3 = Color3.fromRGB(100,102,241)
        setStatus("LINK COPIED — PASTE INTO BROWSER",
            Color3.fromRGB(100,102,241),
            Color3.fromRGB(140,140,200))
    else
        btnGetKey.Text       = "OPEN LINK BELOW"
        btnGetKey.TextColor3 = Color3.fromRGB(250,180,50)
        setStatus("COPY LINK: " .. link,
            Color3.fromRGB(250,200,50),
            Color3.fromRGB(180,170,80))
    end

    task.wait(3)
    btnGetKey.Text       = "GET KEY"
    btnGetKey.TextColor3 = Color3.fromRGB(160,160,200)
    setStatus("AWAITING KEY INPUT...",
        Color3.fromRGB(100,102,241),
        Color3.fromRGB(130,130,180))
end)

-- ══════════════════════════════════════
--  VERIFY / ACTIVATE
-- ══════════════════════════════════════
btnVerify.MouseButton1Click:Connect(function()
    local key = keyBox.Text:gsub("%s+", "")

    if key == "" then
        setStatus("NO KEY PROVIDED",
            Color3.fromRGB(200,50,50),
            Color3.fromRGB(200,80,80))
        makeStroke(inputFrame, Color3.fromRGB(150,30,30), 1)
        task.wait(1.5)
        makeStroke(inputFrame, Color3.fromRGB(40,40,65), 1)
        return
    end

    btnVerify.Text             = "CHECKING..."
    btnVerify.BackgroundColor3 = Color3.fromRGB(40,40,60)
    setStatus("CONNECTING TO AUTH SERVER...",
        Color3.fromRGB(250,200,50),
        Color3.fromRGB(180,170,80))
    animateProgress(30, 70, 0.8)

    task.wait(0.9)
    animateProgress(70, 95, 0.5)
    task.wait(0.6)

    if key == "KEY_03152026" then
        setProgress(100)
        btnVerify.Text             = "ACCESS GRANTED"
        btnVerify.BackgroundColor3 = Color3.fromRGB(20,100,50)
        setStatus("AUTHENTICATED — LOADING MODULES",
            Color3.fromRGB(50,200,80),
            Color3.fromRGB(80,200,100))
        task.wait(1.2)
        sg:Destroy()
        -- ← PASTE SCRIPT THẬT CỦA BẠN Ở ĐÂY

    else
        setProgress(0)
        btnVerify.Text             = "INVALID KEY"
        btnVerify.BackgroundColor3 = Color3.fromRGB(130,20,20)
        setStatus("AUTH FAILED — INVALID KEY",
            Color3.fromRGB(200,50,50),
            Color3.fromRGB(200,70,70))
        makeStroke(inputFrame, Color3.fromRGB(150,30,30), 1)
        task.wait(2)
        btnVerify.Text             = "ACTIVATE"
        btnVerify.BackgroundColor3 = Color3.fromRGB(55,52,160)
        setStatus("READY — ENTER VALID KEY",
            Color3.fromRGB(100,102,241),
            Color3.fromRGB(120,120,180))
        makeStroke(inputFrame, Color3.fromRGB(40,40,65), 1)
    end
end)
