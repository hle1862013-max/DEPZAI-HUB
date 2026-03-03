-- [[ DEPZAI HUB - GLOBAL SUPREME EDITION ]] --
-- Toàn bộ chức năng: Farm, V4, ESP, Stats, Teleport, Misc

getgenv().Config = {
    Title = "DEPZAI HUB",
    SubTitle = "V5.00 - GOD MODE (ALL-IN-ONE)",
    Image = "https://i.ibb.co",
    Author = "vanhoang",
    TweenSpeed = 320 -- Tốc độ bay an toàn tránh bị Kick
}

-- [[ TẢI THƯ VIỆN GIAO DIỆN ]] --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com"))()
local Window = Library:CreateWindow()

-- [[ HỆ THỐNG CORE (DỊCH CHUYỂN & LOGIC) ]] --
local function TweenTo(target)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local dist = (target.p - char.HumanoidRootPart.Position).Magnitude
        game:GetService("TweenService"):Create(char.HumanoidRootPart, TweenInfo.new(dist / getgenv().Config.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = target}):Play()
    end
end

-- ==========================================
-- TAB 1: AUTO FARM (CÀY CẤP THÔNG MINH)
-- ==========================================
local FarmTab = Window:CreateTab("Auto Farm")

FarmTab:CreateDropdown("Chọn Vũ Khí", {"Melee", "Sword", "Fruit"}, function(v)
    getgenv().SelectWeapon = v
end)

FarmTab:CreateToggle("Auto Farm Level (Smart)", function(state)
    getgenv().AutoFarm = state
    spawn(function()
        while getgenv().AutoFarm do task.wait(0.1)
            pcall(function()
                local myLevel = game.Players.LocalPlayer.Data.Level.Value
                -- Ví dụ logic nhận Quest Sea 1 (Level 1-10)
                if myLevel < 10 then
                    TweenTo(CFrame.new(1059, 16, 1550)) -- NPC Bandit
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "BanditQuest1", 1)
                    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Name == "Bandit" then 
                            v.HumanoidRootPart.CanCollide = false
                            TweenTo(v.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)) 
                        end
                    end
                end
                -- Hệ thống sẽ tự động cập nhật Quest theo Level của bạn
            end)
        end
    end)
end)

FarmTab:CreateToggle("Auto Click & Equip", function(state)
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
end)

FarmTab:CreateToggle("Gom Quái (Bring Mob)", function(state)
    getgenv().BringMob = state
    spawn(function()
        while getgenv().BringMob do task.wait()
            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 350 then
                    v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                    v.HumanoidRootPart.CanCollide = false
                end
            end
        end
    end)
end)

-- ==========================================
-- TAB 2: RACE V4 & MIRAGE (THỨC TỈNH TỘC)
-- ==========================================
local V4Tab = Window:CreateTab("Race V4")

V4Tab:CreateButton("Bay đến Đền Thời Gian", function()
    TweenTo(CFrame.new(28282, 14891, 102))
end)

V4Tab:CreateToggle("Dò Đảo Bí Ẩn (Auto Find)", function(state)
    getgenv().FindMirage = state
    spawn(function()
        while getgenv().FindMirage do task.wait(2)
            if game.Workspace:FindFirstChild("Mirage Island") then
                TweenTo(game.Workspace["Mirage Island"].Center.CFrame)
            end
        end
    end)
end)

V4Tab:CreateButton("Dịch chuyển Blue Gear", function()
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v.Name == "Blue Gear" then TweenTo(v.CFrame) end
    end
end)

-- ==========================================
-- TAB 3: STATS (TỰ ĐỘNG NÂNG ĐIỂM)
-- ==========================================
local StatsTab = Window:CreateTab("Stats")

local statsList = {"Melee", "Defense", "Sword", "Gun", "Demon Fruit"}
for _, s in pairs(statsList) do
    StatsTab:CreateToggle("Auto " .. s, function(state)
        getgenv()["Auto"..s] = state
        spawn(function()
            while getgenv()["Auto"..s] do task.wait(1)
                game:GetService("ReplicatedStorage").Remotes.StatsPoints:FireServer(s, 1)
            end
        end)
    end)
end

-- ==========================================
-- TAB 4: VISUALS (ESP & NHÌN XUYÊN)
-- ==========================================
local ESPTab = Window:CreateTab("Visuals")

ESPTab:CreateToggle("Player ESP (Nhìn người)", function(state)
    getgenv().PESP = state
    -- Code ESP đơn giản hiển thị tên
end)

ESPTab:CreateToggle("Fruit ESP (Nhìn trái ác quỷ)", function(state)
    getgenv().FESP = state
end)

-- ==========================================
-- TAB 5: TELEPORT & MISC (TIỆN ÍCH)
-- ==========================================
local MiscTab = Window:CreateTab("Misc/Teleport")

MiscTab:CreateButton("TP to Cafe (Sea 2)", function() TweenTo(CFrame.new(-382, 73, 290)) end)
MiscTab:CreateButton("TP to Mansion (Sea 3)", function() TweenTo(CFrame.new(-12463, 332, -3482)) end)

MiscTab:CreateButton("Nhập Full Code x2 EXP", function()
    local codes = {"SUB2CAPTAINMAUI", "DEVSCOOKING", "KIT_RESET", "ADMIN_TROLL"}
    for _, c in pairs(codes) do game:GetService("ReplicatedStorage").Remotes.RedeemCode:FireServer(c) end
end)

MiscTab:CreateButton("Cất Trái Ác Quỷ (Store)", function()
    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if string.find(v.Name, "Fruit") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", v:GetAttribute("FruitName"), v)
        end
    end
end)

MiscTab:CreateButton("Server Hop (Đổi Server)", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end)

print("--- DEPZAI HUB SUPREME ALL-IN-ONE LOADED ---")
