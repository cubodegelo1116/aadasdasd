-- ============================================
-- RXT ADMIN - COMANDOS
-- ============================================

-- ============================================
-- INVFLY (INVISIBLE + FLY + NOCLIP NO CLONE)
-- ============================================

local invflyRunning = false
local invflyIsInvis = false
local invflyInvisibleCharacter = nil
local invflyCharacter = nil
local invflyDied = nil
local invflyFix = nil
local invflyIsRunning = false
local invflyCF = nil
local invflyViewConn = nil
local invflyFlyData = nil
local invflySpeed = 50
local invflyNoclipConn = nil

local function invflyRespawn()
    local player = _G.RXT_Player
    if not player then return end
    
    invflyIsRunning = false
    if invflyIsInvis == true then
        pcall(function()
            player.Character = invflyCharacter
            task.wait()
            if invflyCharacter then
                invflyCharacter.Parent = workspace
                local hum = invflyCharacter:FindFirstChildOfClass("Humanoid")
                if hum then hum:Destroy() end
                invflyIsInvis = false
                if invflyInvisibleCharacter then invflyInvisibleCharacter.Parent = nil end
                invflyRunning = false
            end
        end)
    elseif invflyIsInvis == false then
        pcall(function()
            player.Character = invflyCharacter
            task.wait()
            if invflyCharacter then
                invflyCharacter.Parent = workspace
                local hum = invflyCharacter:FindFirstChildOfClass("Humanoid")
                if hum then hum:Destroy() end
                invflyTurnVisible()
            end
        end)
    end
end

function invflyTurnVisible()
    local player = _G.RXT_Player
    if not player then return end
    
    if invflyIsInvis == false then return end
    
    if invflyFix then
        pcall(function() invflyFix:Disconnect() end)
        invflyFix = nil
    end
    if invflyDied then
        pcall(function() invflyDied:Disconnect() end)
        invflyDied = nil
    end
    if invflyViewConn then
        pcall(function() invflyViewConn:Disconnect() end)
        invflyViewConn = nil
    end
    if invflyNoclipConn then
        pcall(function() invflyNoclipConn:Disconnect() end)
        invflyNoclipConn = nil
    end
    
    -- Remove fly do clone
    if invflyFlyData then
        if invflyFlyData.bodyGyro then invflyFlyData.bodyGyro:Destroy() end
        if invflyFlyData.bodyVelocity then invflyFlyData.bodyVelocity:Destroy() end
        if invflyFlyData.renderConn then invflyFlyData.renderConn:Disconnect() end
        if invflyFlyData.keyDown then invflyFlyData.keyDown:Disconnect() end
        if invflyFlyData.keyUp then invflyFlyData.keyUp:Disconnect() end
        invflyFlyData = nil
    end
    
    -- Remove noclip do clone
    if invflyInvisibleCharacter then
        for _, part in ipairs(invflyInvisibleCharacter:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
    
    invflyCF = workspace.CurrentCamera.CFrame
    invflyCharacter = invflyCharacter
    
    local character = player.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    local CF_1 = rootPart and rootPart.CFrame or CFrame.new(0,0,0)
    
    if invflyCharacter then
        local charRoot = invflyCharacter:FindFirstChild("HumanoidRootPart")
        if charRoot then
            charRoot.CFrame = CF_1
        end
    end
    
    if invflyInvisibleCharacter then
        invflyInvisibleCharacter:Destroy()
        invflyInvisibleCharacter = nil
    end
    
    player.Character = invflyCharacter
    if invflyCharacter then
        invflyCharacter.Parent = workspace
    end
    invflyIsInvis = false
    
    workspace.CurrentCamera.CameraSubject = player.Character
    
    if player.Character then
        local animate = player.Character:FindFirstChild("Animate")
        if animate then
            animate.Disabled = true
            animate.Disabled = false
        end
    end
    
    if invflyCharacter then
        local hum = invflyCharacter:FindFirstChildOfClass("Humanoid")
        if hum then
            invflyDied = hum.Died:Connect(function()
                invflyRespawn()
                if invflyDied then
                    pcall(function() invflyDied:Disconnect() end)
                    invflyDied = nil
                end
            end)
        end
    end
    
    invflyRunning = false
    _G.RXT_ShowPopup("Invfly desativado!")
end

local function toggleInvfly(velocidade)
    local player = _G.RXT_Player
    if not player then return end
    
    if invflyRunning then
        _G.RXT_ShowPopup("Já está invfly ativado!")
        return
    end
    
    if velocidade and tonumber(velocidade) then
        invflySpeed = tonumber(velocidade)
    else
        invflySpeed = 50
    end
    
    invflyRunning = true
    
    repeat task.wait(0.1) until player.Character
    
    local character = player.Character
    if not character then
        invflyRunning = false
        return
    end
    
    character.Archivable = true
    invflyIsInvis = false
    invflyIsRunning = true
    
    invflyInvisibleCharacter = character:Clone()
    invflyInvisibleCharacter.Parent = game:GetService("Lighting")
    invflyInvisibleCharacter.Name = ""
    
    local Void = workspace.FallenPartsDestroyHeight or -500
    
    invflyFix = game:GetService("RunService").Stepped:Connect(function()
        pcall(function()
            local IsInteger
            if tostring(Void):find('-') then
                IsInteger = true
            else
                IsInteger = false
            end
            
            local char = player.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            
            local pos = root.Position
            local posString = tostring(pos)
            local posSeperate = posString:split(', ')
            local Y = tonumber(posSeperate[2])
            
            if IsInteger == true then
                if Y <= Void then
                    invflyRespawn()
                end
            elseif IsInteger == false then
                if Y >= Void then
                    invflyRespawn()
                end
            end
        end)
    end)
    
    for _, v in ipairs(invflyInvisibleCharacter:GetDescendants()) do
        if v:IsA("BasePart") then
            if v.Name == "HumanoidRootPart" then
                v.Transparency = 1
            else
                v.Transparency = 0.5
            end
        end
    end
    
    local function localRespawn()
        invflyIsRunning = false
        if invflyIsInvis == true then
            pcall(function()
                player.Character = invflyCharacter
                task.wait()
                if invflyCharacter then
                    invflyCharacter.Parent = workspace
                    local hum = invflyCharacter:FindFirstChildOfClass("Humanoid")
                    if hum then hum:Destroy() end
                    invflyIsInvis = false
                    if invflyInvisibleCharacter then invflyInvisibleCharacter.Parent = nil end
                    invflyRunning = false
                end
            end)
        elseif invflyIsInvis == false then
            pcall(function()
                player.Character = invflyCharacter
                task.wait()
                if invflyCharacter then
                    invflyCharacter.Parent = workspace
                    local hum = invflyCharacter:FindFirstChildOfClass("Humanoid")
                    if hum then hum:Destroy() end
                    invflyTurnVisible()
                end
            end)
        end
    end
    
    local cloneHum = invflyInvisibleCharacter:FindFirstChildOfClass("Humanoid")
    if cloneHum then
        invflyDied = cloneHum.Died:Connect(function()
            localRespawn()
            if invflyDied then
                pcall(function() invflyDied:Disconnect() end)
                invflyDied = nil
            end
        end)
    end
    
    if invflyIsInvis == true then
        invflyRunning = false
        return
    end
    
    invflyIsInvis = true
    invflyCharacter = character
    
    invflyCF = workspace.CurrentCamera.CFrame
    local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
    local CF_1 = rootPart and rootPart.CFrame or CFrame.new(0,0,0)
    
    character:MoveTo(Vector3.new(0, math.pi * 1000000, 0))
    
    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
    task.wait(0.2)
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    
    invflyInvisibleCharacter = invflyInvisibleCharacter
    character.Parent = game:GetService("Lighting")
    invflyInvisibleCharacter.Parent = workspace
    
    if invflyInvisibleCharacter then
        local invRoot = invflyInvisibleCharacter:FindFirstChild("HumanoidRootPart")
        if invRoot then
            invRoot.CFrame = CF_1
        end
        player.Character = invflyInvisibleCharacter
    end
    
    -- ============================================
    -- NOCLIP NO CLONE
    -- ============================================
    
    if invflyInvisibleCharacter then
        for _, part in ipairs(invflyInvisibleCharacter:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
        
        -- Mantém noclip sempre ativo
        invflyNoclipConn = game:GetService("RunService").Stepped:Connect(function()
            if not invflyIsInvis or not invflyInvisibleCharacter or not invflyInvisibleCharacter.Parent then
                return
            end
            
            for _, part in ipairs(invflyInvisibleCharacter:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    end
    
    -- ============================================
    -- FLY NO CLONE
    -- ============================================
    
    local flyTorso = invflyInvisibleCharacter:FindFirstChild("Torso") or invflyInvisibleCharacter:FindFirstChild("UpperTorso")
    local flyHumanoid = invflyInvisibleCharacter:FindFirstChild("Humanoid")
    
    if flyTorso and flyHumanoid then
        local bg = Instance.new("BodyGyro", flyTorso)
        local bv = Instance.new("BodyVelocity", flyTorso)
        
        bg.P = 9e4
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.CFrame = flyTorso.CFrame
        
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Velocity = Vector3.new(0, 0, 0)
        
        flyHumanoid.PlatformStand = true
        
        local ctrl = {f = 0, b = 0, l = 0, r = 0}
        local spd = invflySpeed
        
        local renderConn = game:GetService("RunService").RenderStepped:Connect(function()
            if not invflyIsInvis or not invflyInvisibleCharacter or not invflyInvisibleCharacter.Parent then
                return
            end
            
            local cam = workspace.CurrentCamera
            local torso = invflyInvisibleCharacter:FindFirstChild("Torso") or invflyInvisibleCharacter:FindFirstChild("UpperTorso")
            if not torso then return end
            
            local bg = torso:FindFirstChild("BodyGyro")
            local bv = torso:FindFirstChild("BodyVelocity")
            
            if bg and bv then
                local forward = cam.CFrame.LookVector * (ctrl.f + ctrl.b)
                local right = cam.CFrame.RightVector * (ctrl.r + ctrl.l)
                local up = Vector3.new(0, 0.1, 0)
                local move = forward + right
                
                if ctrl.f == 0 and ctrl.b == 0 and ctrl.l == 0 and ctrl.r == 0 then
                    bv.Velocity = Vector3.new(0, 0, 0)
                else
                    bv.Velocity = (move * spd) + up
                end
                bg.CFrame = cam.CFrame
            end
        end)
        
        local keyDown = game:GetService("UserInputService").InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                local key = string.lower(input.KeyCode.Name)
                if key == "w" then ctrl.f = 1 end
                if key == "s" then ctrl.b = -1 end
                if key == "a" then ctrl.l = -1 end
                if key == "d" then ctrl.r = 1 end
            end
        end)
        
        local keyUp = game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                local key = string.lower(input.KeyCode.Name)
                if key == "w" then ctrl.f = 0 end
                if key == "s" then ctrl.b = 0 end
                if key == "a" then ctrl.l = 0 end
                if key == "d" then ctrl.r = 0 end
            end
        end)
        
        invflyFlyData = {
            bodyGyro = bg,
            bodyVelocity = bv,
            renderConn = renderConn,
            keyDown = keyDown,
            keyUp = keyUp,
            ctrl = ctrl,
            spd = spd
        }
    end
    
    -- FIXCAM
    workspace.CurrentCamera.CameraSubject = player.Character
    
    if player.Character then
        local animate = player.Character:FindFirstChild("Animate")
        if animate then
            animate.Disabled = true
            animate.Disabled = false
        end
    end
    
    _G.RXT_ShowPopup("Invfly ativado! (velocidade: " .. invflySpeed .. ")")
end

-- ============================================
-- INVISIBLE / VISIBLE (CÓDIGO ORIGINAL)
-- ============================================

local invisRunning = false
local IsInvis = false
local InvisibleCharacter = nil
local Character = nil
local invisDied = nil
local invisFix = nil
local IsRunning = false
local CF = nil

local function Respawn()
    local player = _G.RXT_Player
    if not player then return end
    
    IsRunning = false
    if IsInvis == true then
        pcall(function()
            player.Character = Character
            task.wait()
            if Character then
                Character.Parent = workspace
                local hum = Character:FindFirstChildOfClass("Humanoid")
                if hum then hum:Destroy() end
                IsInvis = false
                if InvisibleCharacter then InvisibleCharacter.Parent = nil end
                invisRunning = false
            end
        end)
    elseif IsInvis == false then
        pcall(function()
            player.Character = Character
            task.wait()
            if Character then
                Character.Parent = workspace
                local hum = Character:FindFirstChildOfClass("Humanoid")
                if hum then hum:Destroy() end
                TurnVisible()
            end
        end)
    end
end

function TurnVisible()
    local player = _G.RXT_Player
    if not player then return end
    
    if IsInvis == false then return end
    
    if invisFix then
        pcall(function() invisFix:Disconnect() end)
        invisFix = nil
    end
    if invisDied then
        pcall(function() invisDied:Disconnect() end)
        invisDied = nil
    end
    
    CF = workspace.CurrentCamera.CFrame
    Character = Character
    
    local character = player.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    local CF_1 = rootPart and rootPart.CFrame or CFrame.new(0,0,0)
    
    if Character then
        local charRoot = Character:FindFirstChild("HumanoidRootPart")
        if charRoot then
            charRoot.CFrame = CF_1
        end
    end
    
    if InvisibleCharacter then
        InvisibleCharacter:Destroy()
        InvisibleCharacter = nil
    end
    
    player.Character = Character
    if Character then
        Character.Parent = workspace
    end
    IsInvis = false
    
    if player.Character then
        local animate = player.Character:FindFirstChild("Animate")
        if animate then
            animate.Disabled = true
            animate.Disabled = false
        end
    end
    
    if Character then
        local hum = Character:FindFirstChildOfClass("Humanoid")
        if hum then
            invisDied = hum.Died:Connect(function()
                Respawn()
                if invisDied then
                    pcall(function() invisDied:Disconnect() end)
                    invisDied = nil
                end
            end)
        end
    end
    
    invisRunning = false
    _G.RXT_ShowPopup("Visível novamente")
end

local function toggleInvisible()
    local player = _G.RXT_Player
    if not player then return end
    
    if invisRunning then
        _G.RXT_ShowPopup("Já está invisível!")
        return
    end
    
    invisRunning = true
    
    repeat task.wait(0.1) until player.Character
    
    local character = player.Character
    if not character then
        invisRunning = false
        return
    end
    
    character.Archivable = true
    IsInvis = false
    IsRunning = true
    
    InvisibleCharacter = character:Clone()
    InvisibleCharacter.Parent = game:GetService("Lighting")
    InvisibleCharacter.Name = ""
    
    local Void = workspace.FallenPartsDestroyHeight or -500
    
    invisFix = game:GetService("RunService").Stepped:Connect(function()
        pcall(function()
            local IsInteger
            if tostring(Void):find('-') then
                IsInteger = true
            else
                IsInteger = false
            end
            
            local char = player.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            
            local pos = root.Position
            local posString = tostring(pos)
            local posSeperate = posString:split(', ')
            local Y = tonumber(posSeperate[2])
            
            if IsInteger == true then
                if Y <= Void then
                    Respawn()
                end
            elseif IsInteger == false then
                if Y >= Void then
                    Respawn()
                end
            end
        end)
    end)
    
    for _, v in ipairs(InvisibleCharacter:GetDescendants()) do
        if v:IsA("BasePart") then
            if v.Name == "HumanoidRootPart" then
                v.Transparency = 1
            else
                v.Transparency = 0.5
            end
        end
    end
    
    local function localRespawn()
        IsRunning = false
        if IsInvis == true then
            pcall(function()
                player.Character = Character
                task.wait()
                if Character then
                    Character.Parent = workspace
                    local hum = Character:FindFirstChildOfClass("Humanoid")
                    if hum then hum:Destroy() end
                    IsInvis = false
                    if InvisibleCharacter then InvisibleCharacter.Parent = nil end
                    invisRunning = false
                end
            end)
        elseif IsInvis == false then
            pcall(function()
                player.Character = Character
                task.wait()
                if Character then
                    Character.Parent = workspace
                    local hum = Character:FindFirstChildOfClass("Humanoid")
                    if hum then hum:Destroy() end
                    TurnVisible()
                end
            end)
        end
    end
    
    local cloneHum = InvisibleCharacter:FindFirstChildOfClass("Humanoid")
    if cloneHum then
        invisDied = cloneHum.Died:Connect(function()
            localRespawn()
            if invisDied then
                pcall(function() invisDied:Disconnect() end)
                invisDied = nil
            end
        end)
    end
    
    if IsInvis == true then
        invisRunning = false
        return
    end
    
    IsInvis = true
    Character = character
    
    CF = workspace.CurrentCamera.CFrame
    local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
    local CF_1 = rootPart and rootPart.CFrame or CFrame.new(0,0,0)
    
    character:MoveTo(Vector3.new(0, math.pi * 1000000, 0))
    
    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
    task.wait(0.2)
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    
    InvisibleCharacter = InvisibleCharacter
    character.Parent = game:GetService("Lighting")
    InvisibleCharacter.Parent = workspace
    
    if InvisibleCharacter then
        local invRoot = InvisibleCharacter:FindFirstChild("HumanoidRootPart")
        if invRoot then
            invRoot.CFrame = CF_1
        end
        player.Character = InvisibleCharacter
    end
    
    -- FIXCAM (igual ao original)
    workspace.CurrentCamera.CameraSubject = player.Character
    
    if player.Character then
        local animate = player.Character:FindFirstChild("Animate")
        if animate then
            animate.Disabled = true
            animate.Disabled = false
        end
    end
    
    _G.RXT_ShowPopup("Invisível ativado!")
end

-- ============================================
-- FUNÇÃO PRINCIPAL QUE EXECUTA OS COMANDOS
-- ============================================

_G.RXT_ExecuteCommand = function(cmd, args)
    local player = _G.RXT_Player
    local gui = _G.RXT_GUI
    
    if not player or not gui then
        warn("RXT: Player ou GUI não inicializados")
        return false
    end
    
    if cmd == "cmds" then
        _G.RXT_AnimateCmdsList(not gui.CmdsLIST.Visible)
        return true
        
    elseif cmd == "prefix" then
        if #args > 0 then
            _G.RXT_Config.Prefix = args[1]
            _G.RXT_ShowPopup("Prefixo alterado para: " .. args[1])
        else
            _G.RXT_ShowPopup("Use: prefix [novo prefixo]")
        end
        return true
        
    elseif cmd == "vprefix" then
        _G.RXT_ShowPopup("Prefixo atual: " .. _G.RXT_Config.Prefix)
        return true
        
    elseif cmd == "popup" then
        if #args > 0 then
            if args[1] == "true" then
                _G.RXT_Config.Popups = true
                _G.RXT_ShowPopup("Popups ativados")
            elseif args[1] == "false" then
                _G.RXT_Config.Popups = false
            else
                _G.RXT_ShowPopup("Use: popup true ou popup false")
            end
        else
            _G.RXT_ShowPopup("Use: popup true ou popup false")
        end
        return true
        
    elseif cmd == "executor" then
        local executorFrame = _G.RXT_ExecutorFrame
        if executorFrame then
            executorFrame.Visible = not executorFrame.Visible
            if executorFrame.Visible then
                task.wait(0.1)
                if _G.RXT_ExecutorTextBox then
                    _G.RXT_ExecutorTextBox:CaptureFocus()
                end
            end
        end
        return true
        
    elseif cmd == "rspy" then
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua"))()
        end)
        if not success then
            _G.RXT_ShowPopup("Erro ao carregar SimpleSpy: " .. tostring(err))
        else
            _G.RXT_ShowPopup("SimpleSpy V3 carregado!")
        end
        return true
        
    elseif cmd == "invisible" or cmd == "invis" then
        toggleInvisible()
        return true
        
    elseif cmd == "visible" or cmd == "vis" or cmd == "uninvisible" then
        TurnVisible()
        return true
        
    elseif cmd == "invfly" then
        if #args > 0 then
            local speed = tonumber(args[1])
            if speed and speed > 0 then
                toggleInvfly(speed)
            else
                toggleInvfly(nil)
            end
        else
            toggleInvfly(nil)
        end
        return true
        
    elseif cmd == "uninvfly" then
        invflyTurnVisible()
        return true
        
    elseif cmd == "rejoin" then
        game:GetService("TeleportService"):Teleport(game.PlaceId, player)
        return true
        
    elseif cmd == "reset" then
        local char = player.Character
        if char then
            char:BreakJoints()
            _G.RXT_ShowPopup("Resetado!")
        end
        return true
        
    elseif cmd == "sit" then
        local char = player.Character
        local humanoid = char and char:FindFirstChild("Humanoid")
        if not humanoid then return false end
        
        _G.RXT_SitActive = not _G.RXT_SitActive
        humanoid.Sit = _G.RXT_SitActive
        _G.RXT_ShowPopup(_G.RXT_SitActive and "Sentado" or "Levantado")
        return true
    end
    
    -- ============================================
    -- ESTADO GLOBAL
    -- ============================================
    
    if not _G.RXT_State then
        _G.RXT_State = {
            flyActive = false,
            flyData = {},
            flySpeed = 50,
            noclipActive = false,
            noclipConn = nil,
            speedLoopActive = false,
            speedLoopConn = nil,
            speedLoopValue = nil,
            jumpLoopActive = false,
            jumpLoopConn = nil,
            jumpLoopValue = nil,
            infJumpActive = false,
            infJumpData = nil,
            viewActive = false,
            viewConn = nil,
            viewTarget = nil,
            tpToolActive = false,
            tpTool = nil,
            tpToolConn = nil,
            espActive = false,
            espConnections = {},
            espHighlight = {},
            walkflingActive = false,
            walkflingLoop = nil,
            walkflingDiedConn = nil,
            floatActive = false,
            floatName = "",
            floatPart = nil,
            floatValue = -3.1,
            floatConnections = {},
            sitActive = false,
        }
    end
    
    local state = _G.RXT_State
    
    -- ============================================
    -- NOCLIP
    -- ============================================
    
    local function toggleNoclip(enable, noNotify)
        local character = player.Character
        if not character then return end
        
        if enable and not state.noclipActive then
            state.noclipActive = true
            
            state.noclipConn = game:GetService("RunService").Stepped:Connect(function()
                if not state.noclipActive or not character or not character.Parent then
                    toggleNoclip(false, true)
                    return
                end
                
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
            
            if not noNotify then
                _G.RXT_ShowPopup("Noclip ativado")
            end
            
        elseif not enable and state.noclipActive then
            state.noclipActive = false
            
            if state.noclipConn then
                state.noclipConn:Disconnect()
                state.noclipConn = nil
            end
            
            if character then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
            
            if not noNotify then
                _G.RXT_ShowPopup("Noclip desativado")
            end
        end
    end
    
    -- ============================================
    -- WALKFLING
    -- ============================================
    
    local function toggleWalkfling(enable)
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        
        if enable and not state.walkflingActive then
            if state.walkflingActive then
                toggleWalkfling(false)
            end
            
            state.walkflingActive = true
            toggleNoclip(true, true)
            
            if humanoid then
                state.walkflingDiedConn = humanoid.Died:Connect(function()
                    toggleWalkfling(false)
                end)
            end
            
            state.walkflingLoop = game:GetService("RunService").Heartbeat:Connect(function()
                local character = player.Character
                local root = _G.RXT_GetRoot(character)
                local vel, movel = nil, 0.1
                
                while not (character and character.Parent and root and root.Parent) do
                    game:GetService("RunService").Heartbeat:Wait()
                    character = player.Character
                    root = _G.RXT_GetRoot(character)
                end
                
                vel = root.Velocity
                root.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
                
                game:GetService("RunService").RenderStepped:Wait()
                if character and character.Parent and root and root.Parent then
                    root.Velocity = vel
                end
                
                game:GetService("RunService").Stepped:Wait()
                if character and character.Parent and root and root.Parent then
                    root.Velocity = vel + Vector3.new(0, movel, 0)
                    movel = movel * -1
                end
            end)
            
            _G.RXT_ShowPopup("Walkfling ativado")
            
        elseif not enable and state.walkflingActive then
            state.walkflingActive = false
            
            if state.walkflingLoop then
                state.walkflingLoop:Disconnect()
                state.walkflingLoop = nil
            end
            
            if state.walkflingDiedConn then
                state.walkflingDiedConn:Disconnect()
                state.walkflingDiedConn = nil
            end
            
            toggleNoclip(false, true)
            _G.RXT_ShowPopup("Walkfling desativado")
        end
    end
    
    -- ============================================
    -- FLY
    -- ============================================
    
    local function toggleFly(enable)
        local character = player.Character
        if not character then return end
        
        local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
        local humanoid = character:FindFirstChild("Humanoid")
        if not torso or not humanoid then return end
        
        if enable and not state.flyActive then
            state.flyActive = true
            
            local bg = Instance.new("BodyGyro", torso)
            local bv = Instance.new("BodyVelocity", torso)
            
            bg.P = 9e4
            bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.CFrame = torso.CFrame
            
            bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bv.Velocity = Vector3.new(0, 0, 0)
            
            humanoid.PlatformStand = true
            
            local ctrl = {f = 0, b = 0, l = 0, r = 0}
            local spd = state.flySpeed
            
            local renderConn = game:GetService("RunService").RenderStepped:Connect(function()
                if not state.flyActive or not character or not character.Parent then
                    toggleFly(false)
                    return
                end
                
                local cam = workspace.CurrentCamera
                local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
                if not torso then return end
                
                local bg = torso:FindFirstChild("BodyGyro")
                local bv = torso:FindFirstChild("BodyVelocity")
                
                if bg and bv then
                    local forward = cam.CFrame.LookVector * (ctrl.f + ctrl.b)
                    local right = cam.CFrame.RightVector * (ctrl.r + ctrl.l)
                    local up = Vector3.new(0, 0.1, 0)
                    local move = forward + right
                    
                    if ctrl.f == 0 and ctrl.b == 0 and ctrl.l == 0 and ctrl.r == 0 then
                        bv.Velocity = Vector3.new(0, 0, 0)
                    else
                        bv.Velocity = (move * spd) + up
                    end
                    bg.CFrame = cam.CFrame
                end
            end)
            
            local keyDown = game:GetService("UserInputService").InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    local key = string.lower(input.KeyCode.Name)
                    if key == "w" then ctrl.f = 1 end
                    if key == "s" then ctrl.b = -1 end
                    if key == "a" then ctrl.l = -1 end
                    if key == "d" then ctrl.r = 1 end
                end
            end)
            
            local keyUp = game:GetService("UserInputService").InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    local key = string.lower(input.KeyCode.Name)
                    if key == "w" then ctrl.f = 0 end
                    if key == "s" then ctrl.b = 0 end
                    if key == "a" then ctrl.l = 0 end
                    if key == "d" then ctrl.r = 0 end
                end
            end)
            
            state.flyData = {
                bodyGyro = bg,
                bodyVelocity = bv,
                renderConn = renderConn,
                keyDown = keyDown,
                keyUp = keyUp,
                ctrl = ctrl,
                spd = spd
            }
            
            _G.RXT_ShowPopup("Fly ativado (velocidade: " .. spd .. ")")
            
        elseif not enable and state.flyActive then
            state.flyActive = false
            
            if state.flyData.bodyGyro then state.flyData.bodyGyro:Destroy() end
            if state.flyData.bodyVelocity then state.flyData.bodyVelocity:Destroy() end
            if state.flyData.renderConn then state.flyData.renderConn:Disconnect() end
            if state.flyData.keyDown then state.flyData.keyDown:Disconnect() end
            if state.flyData.keyUp then state.flyData.keyUp:Disconnect() end
            
            if character and character:FindFirstChild("Humanoid") then
                character.Humanoid.PlatformStand = false
            end
            
            state.flyData = {}
            _G.RXT_ShowPopup("Fly desativado")
        end
    end
    
    -- ============================================
    -- SPEED E JUMP
    -- ============================================
    
    local function setSpeed(value)
        local character = player.Character
        local humanoid = character and character:FindFirstChild("Humanoid")
        if not humanoid then return end
        
        if value then
            humanoid.WalkSpeed = value
            _G.RXT_ShowPopup("Velocidade: " .. value)
        else
            humanoid.WalkSpeed = 16
            _G.RXT_ShowPopup("Velocidade normal")
        end
    end
    
    local function setJump(value)
        local character = player.Character
        local humanoid = character and character:FindFirstChild("Humanoid")
        if not humanoid then return end
        
        if value then
            humanoid.JumpPower = value
            _G.RXT_ShowPopup("Pulo: " .. value)
        else
            humanoid.JumpPower = 50
            _G.RXT_ShowPopup("Pulo normal")
        end
    end
    
    -- ============================================
    -- LOOP
    -- ============================================
    
    local function toggleSpeedLoop(value)
        if state.speedLoopActive then
            if state.speedLoopConn then
                state.speedLoopConn:Disconnect()
                state.speedLoopConn = nil
            end
            state.speedLoopActive = false
            state.speedLoopValue = nil
            _G.RXT_ShowPopup("Loop speed desativado")
            return
        end
        
        if not value then
            _G.RXT_ShowPopup("Use: loopspeed [numero]")
            return
        end
        
        state.speedLoopActive = true
        state.speedLoopValue = value
        
        local function applySpeedLoop()
            local character = player.Character
            local humanoid = character and character:FindFirstChild("Humanoid")
            if humanoid and state.speedLoopActive then
                humanoid.WalkSpeed = state.speedLoopValue
            end
        end
        
        state.speedLoopConn = game:GetService("RunService").RenderStepped:Connect(applySpeedLoop)
        
        player.CharacterAdded:Connect(function()
            if state.speedLoopActive and state.speedLoopValue then
                task.wait(0.1)
                local character = player.Character
                local humanoid = character and character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = state.speedLoopValue
                end
            end
        end)
        
        applySpeedLoop()
        _G.RXT_ShowPopup("Loop speed ativado: " .. value)
    end
    
    local function toggleJumpLoop(value)
        if state.jumpLoopActive then
            if state.jumpLoopConn then
                state.jumpLoopConn:Disconnect()
                state.jumpLoopConn = nil
            end
            state.jumpLoopActive = false
            state.jumpLoopValue = nil
            _G.RXT_ShowPopup("Loop jump desativado")
            return
        end
        
        if not value then
            _G.RXT_ShowPopup("Use: loopjump [numero]")
            return
        end
        
        state.jumpLoopActive = true
        state.jumpLoopValue = value
        
        local function applyJumpLoop()
            local character = player.Character
            local humanoid = character and character:FindFirstChild("Humanoid")
            if humanoid and state.jumpLoopActive then
                humanoid.JumpPower = state.jumpLoopValue
            end
        end
        
        state.jumpLoopConn = game:GetService("RunService").RenderStepped:Connect(applyJumpLoop)
        
        player.CharacterAdded:Connect(function()
            if state.jumpLoopActive and state.jumpLoopValue then
                task.wait(0.1)
                local character = player.Character
                local humanoid = character and character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.JumpPower = state.jumpLoopValue
                end
            end
        end)
        
        applyJumpLoop()
        _G.RXT_ShowPopup("Loop jump ativado: " .. value)
    end
    
    -- ============================================
    -- INFJUMP
    -- ============================================
    
    local function toggleInfJump(enable)
        local character = player.Character
        local humanoid = character and character:FindFirstChild("Humanoid")
        if not humanoid then return end
        
        if enable and not state.infJumpActive then
            state.infJumpActive = true
            
            local conn
            conn = game:GetService("UserInputService").JumpRequest:Connect(function()
                if state.infJumpActive then
                    local char = player.Character
                    local hum = char and char:FindFirstChild("Humanoid")
                    if hum then
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
            
            state.infJumpData = conn
            _G.RXT_ShowPopup("Pulo infinito ativado")
            
        elseif not enable and state.infJumpActive then
            state.infJumpActive = false
            if state.infJumpData then
                state.infJumpData:Disconnect()
                state.infJumpData = nil
            end
            _G.RXT_ShowPopup("Pulo infinito desativado")
        end
    end
    
    -- ============================================
    -- GOTO, BRING, VIEW
    -- ============================================
    
    local function teleportTo(target)
        local character = player.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        
        local targetChar = target.Character
        local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
        if not targetRoot then
            _G.RXT_ShowPopup("Jogador sem personagem")
            return
        end
        
        rootPart.CFrame = targetRoot.CFrame + Vector3.new(0, 2, 0)
        _G.RXT_ShowPopup("Teleportado para " .. target.Name)
    end
    
    local function bringPlayer(target)
        local character = player.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        
        local targetChar = target.Character
        local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
        if not targetRoot then
            _G.RXT_ShowPopup("Jogador sem personagem")
            return
        end
        
        targetRoot.CFrame = rootPart.CFrame + Vector3.new(0, 2, 0)
        _G.RXT_ShowPopup(target.Name .. " trazido ate voce")
    end
    
    local function toggleView(target)
        local camera = workspace.CurrentCamera
        
        if state.viewActive then
            if state.viewConn then
                state.viewConn:Disconnect()
                state.viewConn = nil
            end
            state.viewActive = false
            state.viewTarget = nil
            camera.CameraSubject = player.Character
            _G.RXT_ShowPopup("View desativado")
            return
        end
        
        if not target then
            _G.RXT_ShowPopup("Use: view [nome]")
            return
        end
        
        local targetChar = target.Character
        local targetHead = targetChar and targetChar:FindFirstChild("Head")
        if not targetHead then
            _G.RXT_ShowPopup("Jogador sem personagem")
            return
        end
        
        state.viewActive = true
        state.viewTarget = target
        camera.CameraSubject = targetHead
        
        state.viewConn = game:GetService("RunService").RenderStepped:Connect(function()
            if not state.viewActive or not state.viewTarget or not state.viewTarget.Parent then
                toggleView(nil)
                return
            end
            
            local char = state.viewTarget.Character
            local head = char and char:FindFirstChild("Head")
            if head then
                camera.CameraSubject = head
            end
        end)
        
        _G.RXT_ShowPopup("Observando " .. target.Name)
    end
    
    -- ============================================
    -- ESP
    -- ============================================
    
    local function toggleESP(enable)
        if enable and not state.espActive then
            state.espActive = true
            
            for _, p in ipairs(game.Players:GetPlayers()) do
                if p ~= player then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESP_Highlight"
                    highlight.Parent = p.Character or p
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.OutlineTransparency = 0
                    highlight.Adornee = p.Character
                    table.insert(state.espHighlight, highlight)
                end
            end
            
            local function onPlayerAdded(p)
                if p ~= player then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESP_Highlight"
                    highlight.Parent = p.Character or p
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.OutlineTransparency = 0
                    highlight.Adornee = p.Character
                    table.insert(state.espHighlight, highlight)
                end
            end
            
            local function onPlayerRemoving(p)
                for i, highlight in ipairs(state.espHighlight) do
                    if highlight and (highlight.Parent == p.Character or highlight.Adornee == p.Character) then
                        highlight:Destroy()
                        table.remove(state.espHighlight, i)
                        break
                    end
                end
            end
            
            local function onCharacterAdded(character)
                local p = game.Players:GetPlayerFromCharacter(character)
                if p and p ~= player then
                    for i, highlight in ipairs(state.espHighlight) do
                        if highlight.Adornee == character then
                            highlight:Destroy()
                            table.remove(state.espHighlight, i)
                            break
                        end
                    end
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESP_Highlight"
                    highlight.Parent = character
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.OutlineTransparency = 0
                    highlight.Adornee = character
                    table.insert(state.espHighlight, highlight)
                end
            end
            
            state.espConnections.PlayerAdded = game.Players.PlayerAdded:Connect(onPlayerAdded)
            state.espConnections.PlayerRemoving = game.Players.PlayerRemoving:Connect(onPlayerRemoving)
            state.espConnections.CharacterAdded = game.Players.PlayerAdded:Connect(function(p)
                p.CharacterAdded:Connect(onCharacterAdded)
            end)
            
            _G.RXT_ShowPopup("ESP ativado")
            
        elseif not enable and state.espActive then
            state.espActive = false
            
            for _, highlight in ipairs(state.espHighlight) do
                highlight:Destroy()
            end
            state.espHighlight = {}
            
            for _, conn in pairs(state.espConnections) do
                conn:Disconnect()
            end
            state.espConnections = {}
            
            _G.RXT_ShowPopup("ESP desativado")
        end
    end
    
    -- ============================================
    -- TP TOOL
    -- ============================================
    
    local function toggleTPTool(enable)
        local backpack = player:FindFirstChild("Backpack")
        
        if enable and not state.tpToolActive then
            if state.tpTool then
                state.tpTool:Destroy()
                state.tpTool = nil
            end
            if state.tpToolConn then
                state.tpToolConn:Disconnect()
                state.tpToolConn = nil
            end
            
            local tool = Instance.new("Tool")
            tool.Name = "TP Tool"
            tool.RequiresHandle = false
            tool.CanBeDropped = false
            tool.ToolTip = "Clique em algum lugar para teleportar"
            tool.Parent = backpack
            tool.Grip = CFrame.new(0, 0, 0)
            
            local mouse = player:GetMouse()
            local currentConn = nil
            
            local function onMouseClick()
                local character = player.Character
                local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                if not rootPart then return end
                
                local target = mouse.Target
                local hit = mouse.Hit
                
                if target and hit then
                    local position = hit.Position
                    rootPart.CFrame = CFrame.new(position.X, position.Y + 2, position.Z)
                end
            end
            
            tool.Equipped:Connect(function()
                if currentConn then
                    currentConn:Disconnect()
                    currentConn = nil
                end
                currentConn = mouse.Button1Down:Connect(onMouseClick)
            end)
            
            tool.Unequipped:Connect(function()
                if currentConn then
                    currentConn:Disconnect()
                    currentConn = nil
                end
            end)
            
            if player.Character and player.Character:FindFirstChild(tool.Name) then
                currentConn = mouse.Button1Down:Connect(onMouseClick)
            end
            
            state.tpToolConn = currentConn
            state.tpTool = tool
            state.tpToolActive = true
            
        elseif not enable and state.tpToolActive then
            if state.tpTool then
                state.tpTool:Destroy()
                state.tpTool = nil
            end
            if state.tpToolConn then
                state.tpToolConn:Disconnect()
                state.tpToolConn = nil
            end
            state.tpToolActive = false
        end
    end
    
    -- ============================================
    -- FLOAT
    -- ============================================
    
    local function toggleFloat(enable)
        local char = player.Character
        local humanoid = char and char:FindFirstChild("Humanoid")
        
        if enable and not state.floatActive then
            state.floatActive = true
            state.floatName = tostring(math.random(100000, 999999))
            
            if char and not char:FindFirstChild(state.floatName) then
                task.spawn(function()
                    local Float = Instance.new("Part")
                    Float.Name = state.floatName
                    Float.Parent = char
                    Float.Transparency = 1
                    Float.Size = Vector3.new(2, 0.2, 1.5)
                    Float.Anchored = true
                    state.floatValue = -3.1
                    
                    local rootPart = char:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        Float.CFrame = rootPart.CFrame * CFrame.new(0, state.floatValue, 0)
                    end
                    
                    state.floatPart = Float
                    
                    _G.RXT_ShowPopup("Float ativado (Q desce, E sobe)")
                    
                    local function FloatPadLoop()
                        if char:FindFirstChild(state.floatName) and char:FindFirstChild("HumanoidRootPart") then
                            local root = char:FindFirstChild("HumanoidRootPart")
                            Float.CFrame = root.CFrame * CFrame.new(0, state.floatValue, 0)
                        else
                            if state.floatConnections.FloatingFunc then state.floatConnections.FloatingFunc:Disconnect() end
                            if state.floatConnections.qUp then state.floatConnections.qUp:Disconnect() end
                            if state.floatConnections.eUp then state.floatConnections.eUp:Disconnect() end
                            if state.floatConnections.qDown then state.floatConnections.qDown:Disconnect() end
                            if state.floatConnections.eDown then state.floatConnections.eDown:Disconnect() end
                            if state.floatConnections.floatDied then state.floatConnections.floatDied:Disconnect() end
                            Float:Destroy()
                            state.floatActive = false
                        end
                    end
                    
                    state.floatConnections.qUp = game:GetService("UserInputService").InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            local key = string.lower(input.KeyCode.Name)
                            if key == "q" then
                                state.floatValue = state.floatValue + 0.5
                            end
                        end
                    end)
                    
                    state.floatConnections.eUp = game:GetService("UserInputService").InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            local key = string.lower(input.KeyCode.Name)
                            if key == "e" then
                                state.floatValue = state.floatValue - 1.5
                            end
                        end
                    end)
                    
                    state.floatConnections.qDown = game:GetService("UserInputService").InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            local key = string.lower(input.KeyCode.Name)
                            if key == "q" then
                                state.floatValue = state.floatValue - 0.5
                            end
                        end
                    end)
                    
                    state.floatConnections.eDown = game:GetService("UserInputService").InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            local key = string.lower(input.KeyCode.Name)
                            if key == "e" then
                                state.floatValue = state.floatValue + 1.5
                            end
                        end
                    end)
                    
                    if humanoid then
                        state.floatConnections.floatDied = humanoid.Died:Connect(function()
                            if state.floatConnections.FloatingFunc then state.floatConnections.FloatingFunc:Disconnect() end
                            if state.floatConnections.qUp then state.floatConnections.qUp:Disconnect() end
                            if state.floatConnections.eUp then state.floatConnections.eUp:Disconnect() end
                            if state.floatConnections.qDown then state.floatConnections.qDown:Disconnect() end
                            if state.floatConnections.eDown then state.floatConnections.eDown:Disconnect() end
                            if state.floatConnections.floatDied then state.floatConnections.floatDied:Disconnect() end
                            Float:Destroy()
                            state.floatActive = false
                        end)
                    end
                    
                    state.floatConnections.FloatingFunc = game:GetService("RunService").Heartbeat:Connect(FloatPadLoop)
                end)
            end
            
        elseif not enable and state.floatActive then
            state.floatActive = false
            
            local char = player.Character
            if char and char:FindFirstChild(state.floatName) then
                char:FindFirstChild(state.floatName):Destroy()
            end
            
            if state.floatConnections.FloatingFunc then state.floatConnections.FloatingFunc:Disconnect() end
            if state.floatConnections.qUp then state.floatConnections.qUp:Disconnect() end
            if state.floatConnections.eUp then state.floatConnections.eUp:Disconnect() end
            if state.floatConnections.qDown then state.floatConnections.qDown:Disconnect() end
            if state.floatConnections.eDown then state.floatConnections.eDown:Disconnect() end
            if state.floatConnections.floatDied then state.floatConnections.floatDied:Disconnect() end
            state.floatConnections = {}
            
            _G.RXT_ShowPopup("Float desativado")
        end
    end
    
    -- ============================================
    -- EXECUTAR COMANDOS
    -- ============================================
    
    if cmd == "noclip" then
        toggleNoclip(true, false)
        return true
        
    elseif cmd == "clip" then
        toggleNoclip(false, false)
        return true
        
    elseif cmd == "fly" then
        if #args > 0 then
            local speed = tonumber(args[1])
            if speed and speed > 0 then
                state.flySpeed = speed
            end
        end
        toggleFly(true)
        return true
        
    elseif cmd == "unfly" then
        toggleFly(false)
        return true
        
    elseif cmd == "speed" then
        if #args > 0 then
            local value = tonumber(args[1])
            if value then
                setSpeed(value)
            else
                _G.RXT_ShowPopup("Use: speed [numero]")
            end
        else
            setSpeed(nil)
        end
        return true
        
    elseif cmd == "jump" then
        if #args > 0 then
            local value = tonumber(args[1])
            if value then
                setJump(value)
            else
                _G.RXT_ShowPopup("Use: jump [numero]")
            end
        else
            setJump(nil)
        end
        return true
        
    elseif cmd == "loopspeed" then
        if #args > 0 then
            local value = tonumber(args[1])
            if value then
                toggleSpeedLoop(value)
            else
                _G.RXT_ShowPopup("Use: loopspeed [numero]")
            end
        else
            toggleSpeedLoop(nil)
        end
        return true
        
    elseif cmd == "unloopspeed" then
        toggleSpeedLoop(nil)
        return true
        
    elseif cmd == "loopjump" then
        if #args > 0 then
            local value = tonumber(args[1])
            if value then
                toggleJumpLoop(value)
            else
                _G.RXT_ShowPopup("Use: loopjump [numero]")
            end
        else
            toggleJumpLoop(nil)
        end
        return true
        
    elseif cmd == "unloopjump" then
        toggleJumpLoop(nil)
        return true
        
    elseif cmd == "infjump" then
        toggleInfJump(true)
        return true
        
    elseif cmd == "uninfjump" then
        toggleInfJump(false)
        return true
        
    elseif cmd == "goto" then
        if #args > 0 then
            local target = _G.RXT_FindPlayer(args[1])
            if target then
                teleportTo(target)
            end
        else
            _G.RXT_ShowPopup("Use: goto [nome]")
        end
        return true
        
    elseif cmd == "bring" then
        if #args > 0 then
            local target = _G.RXT_FindPlayer(args[1])
            if target then
                bringPlayer(target)
            end
        else
            _G.RXT_ShowPopup("Use: bring [nome]")
        end
        return true
        
    elseif cmd == "view" then
        if #args > 0 then
            local target = _G.RXT_FindPlayer(args[1])
            if target then
                toggleView(target)
            end
        else
            _G.RXT_ShowPopup("Use: view [nome]")
        end
        return true
        
    elseif cmd == "unview" then
        toggleView(nil)
        return true
        
    elseif cmd == "tptool" then
        toggleTPTool(true)
        return true
        
    elseif cmd == "untptool" then
        toggleTPTool(false)
        return true
        
    elseif cmd == "esp" then
        toggleESP(true)
        return true
        
    elseif cmd == "unesp" then
        toggleESP(false)
        return true
        
    elseif cmd == "walkfling" then
        toggleWalkfling(true)
        return true
        
    elseif cmd == "unwalkfling" then
        toggleWalkfling(false)
        return true
        
    elseif cmd == "float" then
        toggleFloat(true)
        return true
        
    elseif cmd == "unfloat" then
        toggleFloat(false)
        return true
    end
    
    return false
end

-- ============================================
-- RETORNAR TABELA DE COMANDOS
-- ============================================

local commandList = {
    {cmd = "cmds", desc = "Abre esta lista de comandos"},
    {cmd = "prefix [novo]", desc = "Muda o prefixo"},
    {cmd = "vprefix", desc = "Mostra o prefixo atual"},
    {cmd = "popup true", desc = "Ativa os popups"},
    {cmd = "popup false", desc = "Desativa os popups"},
    {cmd = "fly [velocidade]", desc = "Ativa o modo voo"},
    {cmd = "unfly", desc = "Desativa o modo voo"},
    {cmd = "noclip", desc = "Ativa o noclip"},
    {cmd = "clip", desc = "Desativa o noclip"},
    {cmd = "speed [numero]", desc = "Altera a velocidade"},
    {cmd = "jump [numero]", desc = "Altera o pulo"},
    {cmd = "loopspeed [numero]", desc = "Loop da velocidade"},
    {cmd = "unloopspeed", desc = "Desativa loop da velocidade"},
    {cmd = "loopjump [numero]", desc = "Loop do pulo"},
    {cmd = "unloopjump", desc = "Desativa loop do pulo"},
    {cmd = "infjump", desc = "Ativa pulo infinito"},
    {cmd = "uninfjump", desc = "Desativa pulo infinito"},
    {cmd = "goto [nome]", desc = "Teleporta ate o jogador"},
    {cmd = "bring [nome]", desc = "Puxa o jogador ate voce"},
    {cmd = "view [nome]", desc = "Observa o jogador"},
    {cmd = "unview", desc = "Para de observar"},
    {cmd = "tptool", desc = "Da uma tool de teleporte"},
    {cmd = "untptool", desc = "Remove a tool de teleporte"},
    {cmd = "esp", desc = "Ativa o ESP (wallhack)"},
    {cmd = "unesp", desc = "Desativa o ESP"},
    {cmd = "walkfling", desc = "Ativa walkfling"},
    {cmd = "unwalkfling", desc = "Desativa walkfling"},
    {cmd = "executor", desc = "Abre o executor"},
    {cmd = "rspy", desc = "Abre o SimpleSpy V3"},
    {cmd = "invisible", desc = "Fica invisível para outros jogadores"},
    {cmd = "visible", desc = "Fica visível novamente"},
    {cmd = "invfly [velocidade]", desc = "Invisível + Fly + Noclip no clone"},
    {cmd = "uninvfly", desc = "Desativa o Invfly"},
    {cmd = "rejoin", desc = "Reentra no servidor"},
    {cmd = "reset", desc = "Respawna o personagem"},
    {cmd = "float", desc = "Ativa o float (Q desce, E sobe)"},
    {cmd = "unfloat", desc = "Desativa o float"},
    {cmd = "sit", desc = "Senta o personagem"},
}

return commandList
