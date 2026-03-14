local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Vanguard Hub | Global Authentication",
   LoadingTitle = "Vanguard Systems",
   LoadingSubtitle = "by Luanbets",
   ConfigurationSaving = {
      Enabled = false
   },
   Discord = {
      Enabled = true,
      Invite = "vanguard", -- Nhìn cho uy tín
      RememberJoins = true
   },
   KeySystem = true, -- Bật hệ thống Key chính chủ của Library
   KeySettings = {
      Title = "Vanguard | Access Key",
      Subtitle = "Join Discord to get your free key",
      Note = "Key link is copied to your clipboard",
      FileName = "VanguardKey", 
      SaveKey = true, 
      GrabKeyFromSite = false, 
      Key = {"VANGUARD_SECRET_KEY"} -- Key của bạn
   }
})

-- Tạo thông báo khi load xong
Rayfield:Notify({
   Title = "System Verified",
   Content = "Welcome to Vanguard Premium Hub",
   Duration = 5,
   Image = 4483345998,
})

-- Tạo một Tab chính để người dùng thấy sau khi nhập Key
local MainTab = Window:CreateTab("Home", 4483345998) 

MainTab:CreateSection("Game Info")

MainTab:CreateLabel("Detected Game: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)

MainTab:CreateButton({
   Name = "Copy Key Link Again",
   Callback = function()
      setclipboard("https://link-target.net/4260973/DdlBGNdHRyrN")
      Rayfield:Notify({
         Title = "Success",
         Content = "Link copied to clipboard!",
         Duration = 3,
      })
   end,
})

-- Tự động copy link khi mới mở cho người dùng dễ làm
setclipboard("https://link-target.net/4260973/DdlBGNdHRyrN")
