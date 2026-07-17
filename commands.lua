-- ============================================
-- RXT ADMIN - COMANDOS
-- ============================================

-- ============================================
-- VARIÁVEIS GLOBAIS
-- ============================================

local rspyActive = false
local rspyConnections = {}
local rspyLogs = {}
local rspySelected = nil
local rspyToggle = false
local rspyClosed = false
local rspySideClosed = false
local rspyMaximized = false
local rspyLayoutOrderNum = 999999999
local rspyRemoteLogs = {}

local rspyFrame = _G.RXT_RSpyFrame
local rspyList = _G.RXT_RSpyList
local rspyArgs = _G.RXT_RSpyArgs
local rspyTextBox = _G.RXT_RSpyTextBox

-- ============================================
-- FUNÇÕES AUXILIARES DO SIMPLESPY
-- ============================================

local function rawtostring(obj)
    if type(obj) == "table" or typeof(obj) == "userdata" then
        local rawmeta = getrawmetatable(obj)
        local cached = rawmeta and rawget(rawmeta, "__tostring")
        if cached then
            local wasReadonly = table.isfrozen and table.isfrozen(rawmeta)
            if wasReadonly then
                setreadonly(rawmeta, false)
            end
            rawset(rawmeta, "__tostring", nil)
            local str = tostring(obj)
            rawset(rawmeta, "__tostring", cached)
            if wasReadonly then
                setreadonly(rawmeta, true)
            end
            return str
        end
    end
    return tostring(obj)
end

local function getRemotePath(remote)
    if not remote then return "nil" end
    local path = ""
    local current = remote
    while current and current ~= game do
        if current.Name:match("^[%a_][%w_]*$") then
            path = "." .. current.Name .. path
        else
            path = ':FindFirstChild("' .. current.Name .. '")' .. path
        end
        current = current.Parent
    end
    if path == "" then
        return "game"
    end
    return "game" .. path
end

local function getPlayerFromInstance(instance)
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr.Character and (instance:IsDescendantOf(plr.Character) or instance == plr.Character) then
            return plr
        end
    end
    return nil
end

local function formatArgs(args)
    local str = ""
    for i, v in ipairs(args) do
        if i > 1 then str = str .. ", " end
        if type(v) == "string" then
            str = str .. '"' .. tostring(v) .. '"'
        elseif type(v) == "number" then
            str = str .. tostring(v)
        elseif type(v) == "boolean" then
            str = str .. tostring(v)
        elseif typeof(v) == "Instance" then
            str = str .. getRemotePath(v)
        else
            str = str .. tostring(v)
        end
    end
    return str
end

local function cleanLogs()
    local max = 300
    if #rspyRemoteLogs > max then
        for i = 100, #rspyRemoteLogs do
            local log = rspyRemoteLogs[i]
            if log and log[1] then
                pcall(function() log[1]:Disconnect() end)
            end
            if log and log[2] then
                pcall(function() log[2]:Destroy() end)
            end
        end
        local newLogs = {}
        for i = 1, 100 do
            table.insert(newLogs, rspyRemoteLogs[i])
        end
        rspyRemoteLogs = newLogs
    end
end

-- ============================================
-- RSPY UI (MESMO DESIGN)
-- ============================================

local function rspyAddLog(name, remote, args, plr)
    local color = remote:IsA("RemoteEvent") and "[Event]" or "[Function]"
    
    local btn = Instance.new("TextButton")
    btn.Name = "RSpyLog"
    btn.Parent = rspyList
    btn.Size = UDim2.new(1, -4, 0, 20)
    btn.Position = UDim2.new(0, 2, 0, #rspyLogs * 22 + 2)
    btn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    btn.BackgroundTransparency = 0.3
    btn.BorderColor3 = Color3.fromRGB(185,185,185)
    btn.BorderSizePixel = 3
    btn.Text = name .. " " .. color
    btn.TextColor3 = Color3.fromRGB(0,0,0)
    btn.TextSize = 10
    btn.Font = Enum.Font.SourceSans
    btn.ZIndex = 11
    btn.AutoButtonColor = false
    btn.TextTruncate = Enum.TextTruncate.AtEnd
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundTransparency = 0
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundTransparency = 0.3
    end)
    
    local logData = {remote = remote, args = args, button = btn, name = name, plr = plr}
    table.insert(rspyLogs, logData)
    table.insert(rspyRemoteLogs, {nil, btn})
    
    btn.MouseButton1Click:Connect(function()
        rspySelected = logData
        local argsStr = formatArgs(args)
        local plrStr = plr and "Player: " .. plr.Name .. "\n" or ""
        rspyTextBox.Text = "Remote: " .. name .. "\n" .. plrStr .. "Args: " .. argsStr
    end)
    
    rspyList.CanvasSize = UDim2.new(0, 0, 0, #rspyLogs * 22 + 4)
    cleanLogs()
end

-- ============================================
-- RSPY HOOKS (SIMPLESPY CORE)
-- ============================================

local function hookRemote(remote)
    if rspyConnections[remote] then return end
    
    local name = remote:GetFullName()
    local conns = {}
    
    if remote:IsA("RemoteEvent") then
        local conn = remote.OnServerEvent:Connect(function(plr, ...)
            if not rspyActive then return end
            local args = {...}
            rspyAddLog(name, remote, args, plr)
        end)
        table.insert(conns, conn)
    end
    
    if remote:IsA("RemoteFunction") then
        local oldFunc = remote.OnServerInvoke
        remote.OnServerInvoke = function(plr, ...)
            if rspyActive then
                local args = {...}
                rspyAddLog(name, remote, args, plr)
            end
            if oldFunc then
                return oldFunc(plr, ...)
            end
            return nil
        end
        table.insert(conns, oldFunc)
    end
    
    if #conns > 0 then
        rspyConnections[remote] = conns
    end
end

local function scanRemotes(parent)
    for _, child in ipairs(parent:GetChildren()) do
        if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") or child:IsA("UnreliableRemoteEvent") then
            hookRemote(child)
        end
        if #child:GetChildren() > 0 then
            scanRemotes(child)
        end
    end
end

-- ============================================
-- BOTÕES DO RSPY (COPIADO DO SIMPLESPY)
-- ============================================

local function createRSpyButtons()
    -- Limpa botões antigos
    local buttonsFrame = rspyFrame:FindFirstChild("RSpyButtons")
    if buttonsFrame then
        buttonsFrame:Destroy()
    end
    
    buttonsFrame = Instance.new("Frame")
    buttonsFrame.Name = "RSpyButtons"
    buttonsFrame.Parent = rspyFrame
    buttonsFrame.Size = UDim2.new(0, 272, 0, 170)
    buttonsFrame.Position = UDim2.new(0.287617803, 0, 0.42, 0)
    buttonsFrame.BackgroundTransparency = 1
    buttonsFrame.ZIndex = 11
    
    local buttonNames = {
        {"Copy Code", "Copia o script gerado"},
        {"Copy Remote", "Copia o caminho do remote"},
        {"Run Code", "Executa o remote"},
        {"Excluir (i)", "Exclui este remote pelo ID"},
        {"Excluir (n)", "Exclui remotes com este nome"},
        {"Limpar Logs", "Limpa todos os logs"},
    }
    
    local yOffset = 0
    for _, btnData in ipairs(buttonNames) do
        local btn = Instance.new("TextButton")
        btn.Name = "RSpyBtn" .. btnData[1]
        btn.Parent = buttonsFrame
        btn.Size = UDim2.new(0.9, 0, 0, 22)
        btn.Position = UDim2.new(0.05, 0, 0, yOffset)
        btn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        btn.BackgroundTransparency = 0.3
        btn.BorderColor3 = Color3.fromRGB(185,185,185)
        btn.BorderSizePixel = 3
        btn.Text = btnData[1]
        btn.TextColor3 = Color3.fromRGB(0,0,0)
        btn.TextSize = 12
        btn.Font = Enum.Font.SourceSans
        btn.ZIndex = 11
        btn.AutoButtonColor = false
        
        btn.MouseEnter:Connect(function()
            btn.BackgroundTransparency = 0
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundTransparency = 0.3
        end)
        
        -- Funcionalidades dos botões
        if btnData[1] == "Copy Code" then
            btn.MouseButton1Click:Connect(function()
                if rspySelected then
                    local argsStr = formatArgs(rspySelected.args)
                    local code = "local remote = " .. getRemotePath(rspySelected.remote) .. "\n"
                    if rspySelected.remote:IsA("RemoteEvent") then
                        code = code .. "remote:FireServer(" .. argsStr .. ")"
                    else
                        code = code .. "remote:InvokeServer(" .. argsStr .. ")"
                    end
                    setclipboard and setclipboard(code)
                    _G.RXT_ShowPopup("Código copiado!")
                else
                    _G.RXT_ShowPopup("Selecione um remote primeiro!")
                end
            end)
        elseif btnData[1] == "Copy Remote" then
            btn.MouseButton1Click:Connect(function()
                if rspySelected then
                    setclipboard and setclipboard(getRemotePath(rspySelected.remote))
                    _G.RXT_ShowPopup("Remote copiado!")
                else
                    _G.RXT_ShowPopup("Selecione um remote primeiro!")
                end
            end)
        elseif btnData[1] == "Run Code" then
            btn.MouseButton1Click:Connect(function()
                if rspySelected then
                    local argsStr = formatArgs(rspySelected.args)
                    if rspySelected.remote:IsA("RemoteEvent") then
                        rspySelected.remote:FireServer(unpack(rspySelected.args))
                    else
                        rspySelected.remote:InvokeServer(unpack(rspySelected.args))
                    end
                    _G.RXT_ShowPopup("Remote executado!")
                else
                    _G.RXT_ShowPopup("Selecione um remote primeiro!")
                end
            end)
        elseif btnData[1] == "Excluir (i)" then
            btn.MouseButton1Click:Connect(function()
                if rspySelected then
                    -- Remove da lista
                    local remote = rspySelected.remote
                    for i, log in ipairs(rspyLogs) do
                        if log.remote == remote then
                            if log.button then log.button:Destroy() end
                            table.remove(rspyLogs, i)
                            break
                        end
                    end
                    -- Reorganiza posições
                    for i, log in ipairs(rspyLogs) do
                        if log.button then
                            log.button.Position = UDim2.new(0, 2, 0, (i-1) * 22 + 2)
                        end
                    end
                    rspyList.CanvasSize = UDim2.new(0, 0, 0, #rspyLogs * 22 + 4)
                    rspyTextBox.Text = ""
                    rspySelected = nil
                    _G.RXT_ShowPopup("Remote excluído!")
                else
                    _G.RXT_ShowPopup("Selecione um remote primeiro!")
                end
            end)
        elseif btnData[1] == "Excluir (n)" then
            btn.MouseButton1Click:Connect(function()
                if rspySelected then
                    local name = rspySelected.name
                    for i = #rspyLogs, 1, -1 do
                        if rspyLogs[i].name == name then
                            if rspyLogs[i].button then rspyLogs[i].button:Destroy() end
                            table.remove(rspyLogs, i)
                        end
                    end
                    for i, log in ipairs(rspyLogs) do
                        if log.button then
                            log.button.Position = UDim2.new(0, 2, 0, (i-1) * 22 + 2)
                        end
                    end
                    rspyList.CanvasSize = UDim2.new(0, 0, 0, #rspyLogs * 22 + 4)
                    rspyTextBox.Text = ""
                    rspySelected = nil
                    _G.RXT_ShowPopup("Remotes com nome '" .. name .. "' excluídos!")
                else
                    _G.RXT_ShowPopup("Selecione um remote primeiro!")
                end
            end)
        elseif btnData[1] == "Limpar Logs" then
            btn.MouseButton1Click:Connect(function()
                for _, child in ipairs(rspyList:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end
                rspyLogs = {}
                rspyRemoteLogs = {}
                rspyTextBox.Text = ""
                rspySelected = nil
                rspyList.CanvasSize = UDim2.new(0, 0, 0, 0)
                _G.RXT_ShowPopup("Logs limpos!")
            end)
        end
        
        yOffset = yOffset + 26
    end
end

-- ============================================
-- RSPY TOGGLE
-- ============================================

function _G.RXT_ToggleRSpy(enable)
    if enable and not rspyActive then
        rspyActive = true
        rspyFrame.Visible = true
        
        -- Limpa logs
        for _, child in ipairs(rspyList:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        rspyLogs = {}
        rspyRemoteLogs = {}
        rspyTextBox.Text = ""
        rspySelected = nil
        
        -- Cria botões
        createRSpyButtons()
        
        -- Escaneia remotes
        scanRemotes(game)
        
        -- Monitora novos remotes
        local descConn = game.DescendantAdded:Connect(function(desc)
            if rspyActive and (desc:IsA("RemoteEvent") or desc:IsA("RemoteFunction") or desc:IsA("UnreliableRemoteEvent")) then
                hookRemote(desc)
            end
        end)
        table.insert(rspyConnections, descConn)
        
        _G.RXT_ShowPopup("Remote Spy ativado!")
        
    elseif not enable and rspyActive then
        rspyActive = false
        rspyFrame.Visible = false
        
        -- Desconecta tudo
        for _, conns in pairs(rspyConnections) do
            if type(conns) == "table" then
                for _, conn in ipairs(conns) do
                    pcall(function() conn:Disconnect() end)
                end
            else
                pcall(function() conns:Disconnect() end)
            end
        end
        rspyConnections = {}
        
        _G.RXT_ShowPopup("Remote Spy desativado!")
    end
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
	
	-- ============================================
	-- COMANDOS DA MAIN
	-- ============================================
	
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
		if _G.RXT_ToggleRSpy then
			_G.RXT_ToggleRSpy(true)
		else
			_G.RXT_ShowPopup("Erro: Remote Spy não carregado!")
		end
		return true
		
	elseif cmd == "unrspy" then
		if _G.RXT_ToggleRSpy then
			_G.RXT_ToggleRSpy(false)
		end
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
	-- COMANDOS QUE PRECISAM DE ESTADO GLOBAL
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
	{cmd = "executor", desc = "Abre o executor de scripts"},
	{cmd = "rspy", desc = "Abre o Remote Spy"},
	{cmd = "unrspy", desc = "Fecha o Remote Spy"},
	{cmd = "rejoin", desc = "Reentra no servidor"},
	{cmd = "reset", desc = "Respawna o personagem"},
	{cmd = "float", desc = "Ativa o float (Q desce, E sobe)"},
	{cmd = "unfloat", desc = "Desativa o float"},
	{cmd = "sit", desc = "Senta o personagem"},
}

return commandList
