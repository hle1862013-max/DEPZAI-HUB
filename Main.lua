-- [[ DEPZAI HUB - FLUENT SUPREME EDITION ]] --
-- Chuyển đổi toàn bộ chức năng từ bản Supreme sang giao diện Fluent UI

local Fluent = loadstring(game:HttpGet("https://github.com"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com"))()

-- Cấu hình Cửa sổ chính (Fluent UI)
local Window = Fluent:CreateWindow({
    Title = "DEPZAI HUB | V5.00",
    SubTitle = "by vanhoang (God Mode)",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- HỆ THỐNG CORE (DỊCH CHUYỂN & LOGIC)
local function TweenTo(target)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local dist = (target.p - char.HumanoidRootPart.Position).Magnitude
        game:GetService("TweenService"):Create(char.HumanoidRootPart, TweenInfo.new(dist / 320, Enum.EasingStyle.Linear), {CFrame = target}):Play()
    end
end

-- TẠO CÁC TAB THEO PHONG CÁCH FLUENT
local Tabs = {
    Main = Window:AddTab({ Title = "Config Farm Tab", Icon = "settings" }),
    V4 = Window:AddTab({ Title = "Race V4 Tab", Icon = "Zap" }),
    Stats = Window:AddTab({ Title = "Stats Tab", Icon = "bar-chart" }),
    Teleport = Window:AddTab({ Title = "Farming Tab", Icon = "Map" }),
    Visuals = Window:AddTab({ Title = "Items Tab", Icon = "Eye" }),
    Misc = Window:AddTab({ Title = "Settings", Icon = "MoreHorizontal" })
}

-- ==========================================
-- TAB 1: AUTO FARM (SMART & FAST)
-- ==========================================
Tabs.Main:AddDropdown("Weapon", {
    Title = "Chọn Vũ Khí",
    Values = {"Melee", "Sword", "Fruit"},
    Default = "Melee",
    Callback = function(v) getgenv().SelectWeapon = v end
})

Tabs.Main:AddToggle("AutoFarmLevel", {
    Title = "Auto Farm Level (Smart)",
    Default = false,
    Callback = function(state)
        getgenv().AutoFarm = state
        spawn(function()
            while getgenv().AutoFarm do task.wait(0.1)
                pcall(function()
                    local myLevel = game.Players.LocalPlayer.Data.Level.Value
                    if myLevel < 10 then
                        TweenTo(CFrame.new(1059, 16, 1550))
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "BanditQuest1", 1)
                        for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if v.Name == "Bandit" then 
                                v.HumanoidRootPart.CanCollide = false
                                TweenTo(v.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)) 
                            end
                        end
                    end
                end)
            end
        end)
    end
})

Tabs.Main:AddToggle("AutoClick", {
    Title = "Auto Click & Equip",
    Default = false,
    Callback = function(state)
        getgenv().AutoClick = state
        spawn(function()
            while getgenv().AutoClick do task.wait()
                pcall(function()
                    local lp = game.Players.LocalPlayer
                    if lp.Backpack:FindFirstChild(getgenv().SelectWeapon) then
                        lp.Humanoid:EquipTool(lp.Backpack[getgenv().SelectWeapon])
                    end
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                end)
            end
        end)
    end
})

Tabs.Main:AddToggle("BringMob", {
    Title = "Gom Quái (Bring Mob)",
    Default = false,
    Callback = function(state) getgenv().BringMob = state end
})

-- ==========================================
-- TAB 2: RACE V4 & MIRAGE
-- ==========================================
Tabs.V4:AddButton({
    Title = "Bay đến Đền Thời Gian",
    Callback = function() TweenTo(CFrame.new(28282, 14891, 102)) end
})

Tabs.V4:AddToggle("FindMirage", {
    Title = "Dò Đảo Bí Ẩn (Auto Find)",
    Default = false,
    Callback = function(state)
        getgenv().FindMirage = state
        spawn(function()
            while getgenv().FindMirage do task.wait(2)
                if game.Workspace:FindFirstChild("Mirage Island") then
                    TweenTo(game.Workspace["Mirage Island"].Center.CFrame)
                end
            end
        end)
    end
})

Tabs.V4:AddButton({
    Title = "Dịch chuyển Blue Gear",
    Callback = function()
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v.Name == "Blue Gear" then TweenTo(v.CFrame) end
        end
    end
})

-- ==========================================
-- TAB 3: AUTO STATS
-- ==========================================
local stats = {"Melee", "Defense", "Sword", "Gun", "Demon Fruit"}
for _, s in pairs(stats) do
    Tabs.Stats:AddToggle("Auto"..s, {
        Title = "Auto "..s,
        Default = false,
        Callback = function(state)
            getgenv()["Auto"..s] = state
            spawn(function()
                while getgenv()["Auto"..s] do task.wait(1)
                    game:GetService("ReplicatedStorage").Remotes.StatsPoints:FireServer(s, 1)
                end
            end)
        end
    })
end

-- ==========================================
-- TAB 4: TELEPORT
-- ==========================================
Tabs.Teleport:AddButton({
    Title = "TP to Cafe (Sea 2)",
    Callback = function() TweenTo(CFrame.new(-382, 73, 290)) end
})

Tabs.Teleport:AddButton({
    Title = "TP to Mansion (Sea 3)",
    Callback = function() TweenTo(CFrame.new(-12463, 332, -3482)) end
})

-- ==========================================
-- TAB 5: VISUALS (ESP)
-- ==========================================
Tabs.Visuals:AddToggle("PlayerESP", {
    Title = "Player ESP",
    Default = false,
    Callback = function(state) getgenv().PESP = state end
})

Tabs.Visuals:AddToggle("FruitESP", {
    Title = "Fruit ESP",
    Default = false,
    Callback = function(state) getgenv().FESP = state end
})

-- ==========================================
-- TAB 6: MISC SETTINGS
-- ==========================================
Tabs.Misc:AddButton({
    Title = "Nhập Full Code x2 EXP",
    Callback = function()
        local codes = {"SUB2CAPTAINMAUI", "DEVSCOOKING", "KIT_RESET", "ADMIN_TROLL"}
        for _, c in pairs(codes) do game:GetService("ReplicatedStorage").Remotes.RedeemCode:FireServer(c) end
    end
})

Tabs.Misc:AddButton({
    Title = "Cất Trái Ác Quỷ (Store)",
    Callback = function()
        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if string.find(v.Name, "Fruit") then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", v:GetAttribute("FruitName"), v)
            end
        end
    end
})

Tabs.Misc:AddButton({
    Title = "Server Hop (Đổi Server)",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end
})

-- KHỞI TẠO MENU
Window:SelectTab(1)
Fluent:Notify({
    Title = "DEPZAI HUB",
    Content = "Đã chuyển đổi thành công sang Fluent UI!",
    Duration = 5
})
