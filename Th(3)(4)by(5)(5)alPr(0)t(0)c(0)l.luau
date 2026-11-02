-- Global flag to prevent executing the script multiple times in the same session
if _G.TheAbyssProtocolLoaded then
    warn("The Abyss Protocol is already loaded and running!")
    return
end
_G.TheAbyssProtocolLoaded = true

local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function safeCaption(text)
    pcall(function()
        local mainGame = LocalPlayer.PlayerGui:WaitForChild("MainUI", 3):WaitForChild("Initiator", 3):WaitForChild("Main_Game", 3)
        if mainGame then
            require(mainGame).caption(text, true)
        end
    end)
end

-- Tải Spawner V2 1 lần duy nhất để tối ưu hiệu suất
local SpawnerSuccess, Spawner = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()
end)

if not SpawnerSuccess or not Spawner then
    warn("Failed to load Vynixu Spawner V2!")
    return
end

-- Thông báo khởi động (đã rút ngắn thời gian chờ giữa các câu)
task.wait(1)
safeCaption("U executed script")
task.wait(1)
safeCaption("Script by me(viet09544)")
task.wait(1)
safeCaption("The mode may buggy")
task.wait(1)
safeCaption("¶Ω♪`§£→←℅©")
task.wait(1)
safeCaption("|♦♣€✓℅®‰»«↑↓")
task.wait(1)
safeCaption("Special thanks zaydtruck(Zaydtruck🇯🇴🍉)")
task.wait(1)
safeCaption("For teach me wrote this")

-- Intro UI Effect khi mở cửa 1
coroutine.wrap(function()
    local connection
    connection = LocalPlayer:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
        local currentRoom = LocalPlayer:GetAttribute("CurrentRoom")
        if currentRoom and currentRoom >= 1 then
            if connection then connection:Disconnect() end
            
            safeCaption("Have fun!")

            pcall(function()
                local playerGui = LocalPlayer.PlayerGui
                local mainUI = playerGui:WaitForChild("MainUI", 3)
                if mainUI then
                    local initiator = mainUI:WaitForChild("Initiator", 3)
                    local shut = initiator and initiator:WaitForChild("Main_Game", 3)

                    if shut then
                        local intro = shut:FindFirstChild("IntroText") or Instance.new("TextLabel") 
                        intro.Visible = true
                        intro.Text = "Th3 4by55al Pr0t0c0l"
                        intro.TextTransparency = 0

                        local underline = intro:FindFirstChild("Underline")
                        if underline then
                            local targetSize1 = UDim2.new(1.1, 0, 0.015, 6)
                            TweenService:Create(underline, TweenInfo.new(3), {Size = targetSize1}):Play()
                            task.wait(3)

                            local targetSize2 = UDim2.new(0.95, 0, 0.015, 6)
                            TweenService:Create(underline, TweenInfo.new(1.3), {Size = targetSize2}):Play()
                            task.wait(1)

                            TweenService:Create(underline, TweenInfo.new(2), {ImageTransparency = 1}):Play()
                        end

                        TweenService:Create(intro, TweenInfo.new(2), {TextTransparency = 1}):Play()

                        if underline then
                            TweenService:Create(underline, TweenInfo.new(3), {Size = UDim2.new(0, 0, 0.015, 6)}):Play()
                        end

                        task.wait(1)
                        intro.Visible = false
                    end
                end
            end)
        end
    end)
end)()

---==================================================
--- 1. ENTITY: SMILE (Thời gian chờ: 20 giây)
---==================================================
coroutine.wrap(function()
    while true do
        task.wait(20)

        local smileSound = Instance.new("Sound")
        smileSound.Name = "SmileSound"
        smileSound.SoundId = "rbxassetid://9114223297"
        smileSound.Volume = 6
        smileSound.PlaybackSpeed = 1.1
        smileSound.Parent = SoundService

        local Smile = Spawner.Create({
            Entity = { Name = "Smile", Asset = "rbxassetid://108764900572976", HeightOffset = 0 },
            Movement = { Speed = 105, Delay = 2, Reversed = false },
            Damage = { Enabled = true, Range = 40, Amount = 125, IgnoreHiding = false },
            Rebounding = { Enabled = true, Type = "Ambush", Min = 4, Max = 7, Delay = 1.7 },
            Lights = { Flicker = { Enabled = true, Duration = 1 }, Shatter = false, Repair = false },
            Earthquake = { Enabled = false },
            CameraShake = { Enabled = true, Values = {5, 25, 0.2, 3.2}, Range = 100 },
            Crucifixion = { Type = "Curious", Enabled = true, Range = 40, Resist = false, Break = true },
            Death = {
                Type = "Curious",
                Hints = {"You died to the Smile...", "It lurks in dark places and moves extremely fast.", "Try hiding in a closet or breaking line of sight!"},
                Cause = "Smile"
            }
        })

        Smile:SetCallback("OnSpawned", function() smileSound:Play() end)
        Smile:SetCallback("OnDespawned", function()
            local fadeOut = TweenService:Create(smileSound, TweenInfo.new(1), {Volume = 0})
            fadeOut:Play()
            task.delay(1, function()
                smileSound:Stop()
                smileSound:Destroy()
            end)
        end)

        Smile:Run()
    end
end)()

---==================================================
--- 2. SCARY ENTITY (Thời gian chờ: 35 giây)
---==================================================
coroutine.wrap(function()
    while true do
        task.wait(35)

        local originalAmbient = Lighting.Ambient
        local originalOutdoorAmbient = Lighting.OutdoorAmbient
        local originalClockTime = Lighting.ClockTime

        local spawnSound = Instance.new("Sound")
        spawnSound.Name = "ScarySpawnSound"
        spawnSound.SoundId = "rbxassetid://9114227045"
        spawnSound.Volume = 5
        spawnSound.PlaybackSpeed = 0.5
        spawnSound.Parent = SoundService

        local function applyScarySky()
            if Lighting:FindFirstChild("ScarySky") then Lighting.ScarySky:Destroy() end
            local sky = Instance.new("Sky")
            sky.Name = "ScarySky"
            local skyId = "rbxassetid://13720474225"
            sky.SkyboxBk, sky.SkyboxDn, sky.SkyboxFt, sky.SkyboxLf, sky.SkyboxRt, sky.SkyboxUp = skyId, skyId, skyId, skyId, skyId, skyId
            sky.Parent = Lighting

            Lighting.Ambient = Color3.fromRGB(40, 0, 0)
            Lighting.OutdoorAmbient = Color3.fromRGB(20, 0, 0)
            Lighting.ClockTime = 0
        end

        local function removeScarySky()
            if Lighting:FindFirstChild("ScarySky") then Lighting.ScarySky:Destroy() end
            Lighting.Ambient = originalAmbient
            Lighting.OutdoorAmbient = originalOutdoorAmbient
            Lighting.ClockTime = originalClockTime
        end

        local ScaryEntity = Spawner.Create({
            Entity = { Name = "Scary Entity", Asset = "rbxassetid://13124351651", HeightOffset = 0 },
            Lights = { Flicker = { Enabled = true, Duration = 0 }, Shatter = true, Repair = false },
            Earthquake = { Enabled = true },
            CameraShake = { Enabled = true, Range = 100, Values = {1.5, 20, 0.1, 1} },
            Movement = { Speed = 100, Delay = 2, Reversed = false },
            Rebounding = { Enabled = true, Type = "Ambush", Min = 1, Max = 1, Delay = 2 },
            Damage = { Enabled = true, IgnoreHiding = false, Range = 40, Amount = 125 },
            Crucifixion = { Type = "Curious", Enabled = true, Range = 40, Resist = false, Break = true },
            Death = {
                Type = "Curious",
                Hints = {"You died by Scary.... Thing", "Ground transit means it will arrive", "Hide", "Good luck next time"},
                Cause = "Scary Thing....?"
            }
        })

        ScaryEntity:SetCallback("OnSpawned", function()
            applyScarySky()
            spawnSound:Play()
        end)

        ScaryEntity:SetCallback("OnDespawned", function()
            TweenService:Create(spawnSound, TweenInfo.new(2), {Volume = 0}):Play()
            task.delay(2, function()
                spawnSound:Stop()
                spawnSound:Destroy()
            end)
            removeScarySky()
        end)

        ScaryEntity:Run()
    end
end)()

---==================================================
--- 3. ENTITY: PHANTOM (Thời gian chờ: 45 giây)
---==================================================
coroutine.wrap(function()
    while true do
        task.wait(45)

        local phantomSound = Instance.new("Sound")
        phantomSound.Name = "PhantomSound"
        phantomSound.SoundId = "rbxassetid://9114224856"
        phantomSound.Volume = 6
        phantomSound.PlaybackSpeed = 1.4
        phantomSound.Parent = SoundService

        local Phantom = Spawner.Create({
            Entity = { Name = "Phantom", Asset = "rbxassetid://13124351651", HeightOffset = 0 },
            Movement = { Speed = 140, Delay = 1.5, Reversed = false },
            Damage = { Enabled = true, Range = 40, Amount = 15, IgnoreHiding = false },
            Rebounding = { Enabled = true, Type = "Ambush", Min = 2, Max = 12, Delay = 0.9 },
            Lights = { Flicker = { Enabled = true, Duration = 1.5 }, Shatter = true, Repair = false },
            Earthquake = { Enabled = true },
            CameraShake = { Enabled = true, Values = {4, 20, 0.25, 2.5}, Range = 90 },
            Crucifixion = { Type = "Curious", Enabled = true, Range = 35, Resist = false, Break = true },
            Death = {
                Type = "Curious",
                Hints = {"You died to Phantom...", "It moves at blinding speeds and rebounds multiple times", "Listen for its approach and hide immediately!"},
                Cause = "Phantom"
            }
        })

        Phantom:SetCallback("OnSpawned", function() phantomSound:Play() end)
        Phantom:SetCallback("OnDespawned", function()
            TweenService:Create(phantomSound, TweenInfo.new(1.5), {Volume = 0}):Play()
            task.delay(1.5, function()
                phantomSound:Stop()
                phantomSound:Destroy()
            end)
        end)

        Phantom:Run()
    end
end)()

---==================================================
--- 4. ENTITY: GLITCHER (Thời gian chờ: 25 giây)
---==================================================
coroutine.wrap(function()
    while true do
        task.wait(25)

        local glitchSound = Instance.new("Sound")
        glitchSound.Name = "GlitcherSound"
        glitchSound.SoundId = "rbxassetid://9114225501"
        glitchSound.Volume = 8
        glitchSound.PlaybackSpeed = 0.8
        glitchSound.Parent = SoundService

        local glitchGui = Instance.new("ScreenGui")
        glitchGui.Name = "GlitcherEffectGui"
        glitchGui.IgnoreGuiInset = true
        glitchGui.DisplayOrder = 99999
        
        local glitchFrame = Instance.new("Frame")
        glitchFrame.Size = UDim2.new(1, 0, 1, 0)
        glitchFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        glitchFrame.BackgroundTransparency = 1
        glitchFrame.Parent = glitchGui
        
        local glitchText = Instance.new("TextLabel")
        glitchText.Size = UDim2.new(1, 0, 0, 100)
        glitchText.Position = UDim2.new(0, 0, 0.4, 0)
        glitchText.BackgroundTransparency = 1
        glitchText.TextColor3 = Color3.fromRGB(255, 0, 0)
        glitchText.TextScaled = true
        glitchText.Font = Enum.Font.SpecialElite
        glitchText.Text = "ERR_GLITCH_SYSTEM_OVERLOAD"
        glitchText.TextTransparency = 1
        glitchText.Parent = glitchGui

        glitchGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

        local Glitcher = Spawner.Create({
            Entity = { Name = "Glitcher", Asset = "rbxassetid://13124351651", HeightOffset = 1 },
            Movement = { Speed = 160, Delay = 1, Reversed = true },
            Damage = { Enabled = true, Range = 50, Amount = 80, IgnoreHiding = false },
            Rebounding = { Enabled = true, Type = "Ambush", Min = 3, Max = 6, Delay = 0.5 },
            Lights = { Flicker = { Enabled = true, Duration = 3.5 }, Shatter = true, Repair = false },
            Earthquake = { Enabled = true },
            CameraShake = { Enabled = true, Values = {8, 35, 0.1, 4}, Range = 120 },
            Crucifixion = { Type = "Curious", Enabled = true, Range = 40, Resist = true, Break = true },
            Death = {
                Type = "Curious",
                Hints = {"You died to Glitcher...", "It distorts reality and moves in unpredictable patterns.", "Pay attention to extreme camera shaking and hide early!"},
                Cause = "Glitcher"
            }
        })

        Glitcher:SetCallback("OnSpawned", function()
            glitchSound:Play()
            TweenService:Create(glitchFrame, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {BackgroundTransparency = 0.7}):Play()
            TweenService:Create(glitchText, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {TextTransparency = 0.2}):Play()
        end)

        Glitcher:SetCallback("OnDespawned", function()
            task.delay(0.367, function()
                TweenService:Create(glitchSound, TweenInfo.new(0.5), {Volume = 0}):Play()
                TweenService:Create(glitchFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
                TweenService:Create(glitchText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()

                task.wait(0.5)
                glitchSound:Stop()
                glitchSound:Destroy()
                glitchGui:Destroy()
            end)
        end)

        Glitcher:Run()
    end
end)()

---==================================================
--- 5. ENTITY: VOID (Thời gian chờ: 50 giây)
---==================================================
coroutine.wrap(function()
    while true do
        task.wait(50)

        local originalAmbient = Lighting.Ambient
        local originalOutdoorAmbient = Lighting.OutdoorAmbient
        local originalBrightness = Lighting.Brightness

        local voidSound = Instance.new("Sound")
        voidSound.Name = "VoidSound"
        voidSound.SoundId = "rbxassetid://9114226194"
        voidSound.Volume = 8
        voidSound.PlaybackSpeed = 0.4
        voidSound.Parent = SoundService

        local VoidEntity = Spawner.Create({
            Entity = { Name = "Void", Asset = "rbxassetid://13124351651", HeightOffset = 0 },
            Movement = { Speed = 130, Delay = 2.5, Reversed = false },
            Damage = { Enabled = true, Range = 45, Amount = 100, IgnoreHiding = false },
            Rebounding = { Enabled = true, Type = "Ambush", Min = 2, Max = 4, Delay = 1.2 },
            Lights = { Flicker = { Enabled = true, Duration = 0 }, Shatter = true, Repair = false },
            Earthquake = { Enabled = true },
            CameraShake = { Enabled = true, Values = {6, 30, 0.2, 3}, Range = 110 },
            Crucifixion = { Type = "Curious", Enabled = true, Range = 35, Resist = false, Break = true },
            Death = {
                Type = "Curious",
                Hints = {"You died to Void...", "It plunges the hotel into absolute darkness.", "Keep your flashlight ready and hide quickly!"},
                Cause = "Void"
            }
        })

        VoidEntity:SetCallback("OnSpawned", function()
            Lighting.Ambient = Color3.fromRGB(0, 0, 0)
            Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
            Lighting.Brightness = 0
            voidSound:Play()
        end)

        VoidEntity:SetCallback("OnDespawned", function()
            TweenService:Create(voidSound, TweenInfo.new(2), {Volume = 0}):Play()
            Lighting.Ambient = originalAmbient
            Lighting.OutdoorAmbient = originalOutdoorAmbient
            Lighting.Brightness = originalBrightness

            task.delay(2, function()
                voidSound:Stop()
                voidSound:Destroy()
            end)
        end)

        VoidEntity:Run()
    end
end)()

---==================================================
--- 6. ENTITY: THE DARKNESS EYE (Thời gian chờ: 30 - 50 giây)
---==================================================
coroutine.wrap(function()
    while true do
        task.wait(math.random(30, 50))

        local eyesSound = Instance.new("Sound")
        eyesSound.Name = "GroupDarknessEyeSound"
        eyesSound.SoundId = "rbxassetid://9114224164"
        eyesSound.Volume = 5
        eyesSound.PlaybackSpeed = 1.2
        eyesSound.Looped = true
        eyesSound.Parent = SoundService

        local eyesCount = math.random(1, 2)
        local activeModels = {}
        eyesSound:Play()

        for i = 1, eyesCount do
            local DarknessEye = Spawner.Create({
                Entity = { Name = "TheDarknessEye_" .. i, Asset = "rbxassetid://108764900572976", HeightOffset = math.random(1, 4) },
                Movement = { Speed = 0, Delay = 0, Reversed = false },
                Damage = { Enabled = true, Range = 50, Amount = 10, IgnoreHiding = true },
                Rebounding = { Enabled = false },
                Lights = { Flicker = { Enabled = false }, Shatter = false, Repair = false },
                Earthquake = { Enabled = false },
                CameraShake = { Enabled = true, Values = {2, 10, 0.1, 1}, Range = 80 },
                Crucifixion = { Type = "Curious", Enabled = true, Range = 30, Resist = false, Break = true },
                Death = {
                    Type = "Curious",
                    Hints = {"You died to The Darkness Eye...", "Don't look at them when entering the room!"},
                    Cause = "The Darkness Eye"
                }
            })

            DarknessEye:SetCallback("OnSpawned", function(model)
                if model then table.insert(activeModels, model) end
            end)

            DarknessEye:Run()
        end

        local currentRoomVal = LocalPlayer:GetAttribute("CurrentRoom") or 1
        local dismissed = false
        local connection
        connection = RunService.Heartbeat:Connect(function()
            local newRoomVal = LocalPlayer:GetAttribute("CurrentRoom")
            if newRoomVal and newRoomVal > currentRoomVal then
                dismissed = true
                if connection then connection:Disconnect() end
            end
        end)

        local timer = 0
        while not dismissed and timer < 15 do
            task.wait(0.5)
            timer = timer + 0.5
        end

        if connection then connection:Disconnect() end

        TweenService:Create(eyesSound, TweenInfo.new(0.5), {Volume = 0}):Play()
        task.delay(0.5, function()
            eyesSound:Stop()
            eyesSound:Destroy()
        end)

        for _, mdl in ipairs(activeModels) do
            if mdl and mdl.Parent then mdl:Destroy() end
        end
    end
end)()

---==================================================
--- 7. ENTITY: NIGHTMARE RUSH (Thời gian chờ: 40 - 60 giây)
---==================================================
coroutine.wrap(function()
    while true do
        task.wait(math.random(40, 60))

        local nightmareSound = Instance.new("Sound")
        nightmareSound.Name = "NightmareRushSound"
        nightmareSound.SoundId = "rbxassetid://9114227891"
        nightmareSound.Volume = 8
        nightmareSound.PlaybackSpeed = 0.7
        nightmareSound.Parent = SoundService

        local NightmareRush = Spawner.Create({
            Entity = { Name = "Nightmare Rush", Asset = "rbxassetid://108764900572976", HeightOffset = 0 },
            Movement = { Speed = 180, Delay = 1, Reversed = false },
            Damage = { Enabled = true, Range = 45, Amount = 90, IgnoreHiding = false },
            Rebounding = { Enabled = true, Type = "Ambush", Min = 3, Max = 5, Delay = 1 },
            Lights = { Flicker = { Enabled = true, Duration = 2 }, Shatter = true, Repair = false },
            Earthquake = { Enabled = true },
            CameraShake = { Enabled = true, Values = {7, 30, 0.15, 3}, Range = 100 },
            Crucifixion = { Type = "Curious", Enabled = true, Range = 40, Resist = false, Break = true },
            Death = {
                Type = "Curious",
                Hints = {"You died to Nightmare Rush...", "It strikes swiftly with extreme force.", "Hide as soon as you see the lights flicker intensely!"},
                Cause = "Nightmare Rush"
            }
        })

        NightmareRush:SetCallback("OnSpawned", function() nightmareSound:Play() end)
        NightmareRush:SetCallback("OnDespawned", function()
            TweenService:Create(nightmareSound, TweenInfo.new(1), {Volume = 0}):Play()
            task.delay(1, function()
                nightmareSound:Stop()
                nightmareSound:Destroy()
            end)
        end)

        NightmareRush:Run()
    end
end)()