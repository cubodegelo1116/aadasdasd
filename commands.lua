-- ============================================
-- COMMANDS.LUA - RXT ADMIN v1.0
-- ============================================
-- Este arquivo contém toda a lógica dos comandos
-- Facilita a criação e modificação de novos comandos

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local ScreenGui = _G.RXT_ScreenGui
local Config = _G.RXT_Config

-- ============================================
-- FUNÇÕES AUXILIARES
-- ============================================

local function showPopup(text)
	if not Config.Popups then return end
	
	local popup = Instance.new("Frame")
	popup.Parent = ScreenGui.ScreenGui
	popup.Size = UDim2.new(0, 300, 0, 40)
	popup.Position = UDim2.new(0.5, -150, 0.15, 0)
	popup.BackgroundColor3 = Color3.fromRGB(227,227,227)
	popup.BorderColor3 = Color3.fromRGB(185, 185, 185)
	popup.BorderSizePixel = 3
	popup.BackgroundTransparency = 0
	popup.Visible = true
	popup.ZIndex = 10
	
	local label = Instance.new("TextLabel")
	label.Parent = popup
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(0, 0, 0)
	label.TextSize = 16
	label.Font = Enum.Font.SourceSansBold
	label.TextXAlignment = Enum.TextXAlignment.Center
	label.TextYAlignment = Enum.TextYAlignment.Center
	label.ZIndex = 11
	
	task.spawn(function()
		task.wait(2)
		popup:Destroy()
	end)
end

local function findPlayer(name)
	local found = {}
	local lowerName = string.lower(name)
	
	for _, plr in ipairs(game.Players:GetPlayers()) do
		local lowerPlayerName = string.lower(plr.Name)
		local lowerDisplayName = string.lower(plr.DisplayName)
		
		if lowerPlayerName == lowerName or lowerDisplayName == lowerName then
			return plr
		end
		
		if string.find(lowerPlayerName, lowerName, 1, true) or string.find(lowerDisplayName, lowerName, 1, true) then
			table.insert(found, plr)
		end
	end
	
	if #found == 1 then
		return found[1]
	elseif #found > 1 then
		local names = {}
		for _, p in ipairs(found) do
			table.insert(names, p.Name)
		end
		showPopup("Varios jogadores encontrados: " .. table.concat(names, ", "))
		return nil
	end
	
	return nil
end

local function getRoot(character)
	if not character then return nil end
	return character:FindFirstChild("HumanoidRootPart")
end

-- ============================================
-- VARIÁVEIS GLOBAIS DOS COMANDOS
-- ============================================

local flyActive = false
local flyData = {}
local flySpeed = 50
local noclipActive = false
local noclipConn = nil
local speedLoopActive = false
local speedLoopConn = nil
local speedLoopValue = nil
local jumpLoopActive = false
local jumpLoopConn = nil
local jumpLoopValue = nil
local infJumpActive = false
local infJumpData = nil
local viewActive = false
local viewConn = nil
local viewTarget = nil
local tpToolActive = false
local tpTool = nil
local tpToolConn = nil

local espActive = false
local espConnections = {}
local espHighlight = {}

local walkflingActive = false
local walkflingLoop = nil
local walkflingDiedConn = nil

local floatActive = false
local floatName = ""
local floatPart = nil
local floatValue = -3.1
local floatConnections = {}

local sitActive = false

-- ============================================
-- LISTA DE COMANDOS
-- ============================================

local commands = {
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
	{cmd = "rejoin", desc = "Reentra no servidor"},
	{cmd = "reset", desc = "Respawna o personagem"},
	{cmd = "float", desc = "Ativa o float (Q desce, E sobe)"},
	{cmd = "unfloat", desc = "Desativa o float"},
	{cmd = "sit", desc = "Senta o personagem"},
}

-- ============================================
-- IMPLEMENTAÇÃO DOS COMANDOS
-- ============================================

local function toggleExecutor(enable)
	local executorFrame = ScreenGui.ScreenGui:FindFirstChild("ExecutorFrame")
	if executorFrame then
		executorFrame.Visible = enable
		if enable then
			task.wait(0.1)
			local textBox = executorFrame:FindFirstChild("ExecutorTextBox")
			if textBox then
				textBox:CaptureFocus()
			end
		end
	end
end

local function rejoinServer()
	game:GetService("TeleportService"):Teleport(game.PlaceId, player)
end

local function resetCharacter()
	local char = player.Character
	if char then
		char:BreakJoints()
		showPopup("Resetado!")
	end
end

local function toggleSit()
	local char = player.Character
	local humanoid = char and char:FindFirstChild("Humanoid")
	if not humanoid then return end
	
	sitActive = not sitActive
	humanoid.Sit = sitActive
	showPopup(sitActive and "Sentado" or "Levantado")
end

-- ============================================
-- NOCLIP
-- ============================================

local function toggleNoclip(enable, noNotify)
	local plr = game.Players.LocalPlayer
	local character = plr.Character
	if not character then return end
	
	if enable and not noclipActive then
		noclipActive = true
		
		noclipConn = game:GetService("RunService").Stepped:Connect(function()
			if not noclipActive or not character or not character.Parent then
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
			showPopup("Noclip ativado")
		end
		
	elseif not enable and noclipActive then
		noclipActive = false
		
		if noclipConn then
			noclipConn:Disconnect()
			noclipConn = nil
		end
		
		if character then
			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = true
				end
			end
		end
		
		if not noNotify then
			showPopup("Noclip desativado")
		end
	end
end

-- ============================================
-- WALKFLING
-- ============================================

local function toggleWalkfling(enable)
	local plr = game.Players.LocalPlayer
	local character = plr.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	
	if enable and not walkflingActive then
		if walkflingActive then
			toggleWalkfling(false)
		end
		
		walkflingActive = true
		
		toggleNoclip(true, true)
		
		if humanoid then
			walkflingDiedConn = humanoid.Died:Connect(function()
				toggleWalkfling(false)
			end)
		end
		
		walkflingLoop = game:GetService("RunService").Heartbeat:Connect(function()
			local character = plr.Character
			local root = getRoot(character)
			local vel, movel = nil, 0.1
			
			while not (character and character.Parent and root and root.Parent) do
				game:GetService("RunService").Heartbeat:Wait()
				character = plr.Character
				root = getRoot(character)
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
		
		showPopup("Walkfling ativado")
		
	elseif not enable and walkflingActive then
		walkflingActive = false
		
		if walkflingLoop then
			walkflingLoop:Disconnect()
			walkflingLoop = nil
		end
		
		if walkflingDiedConn then
			walkflingDiedConn:Disconnect()
			walkflingDiedConn = nil
		end
		
		toggleNoclip(false, true)
		
		showPopup("Walkfling desativado")
	end
end

-- ============================================
-- FLOAT
-- ============================================

local function toggleFloat(enable)
	local char = player.Character
	local humanoid = char and char:FindFirstChild("Humanoid")
	
	if enable and not floatActive then
		floatActive = true
		floatName = tostring(math.random(100000, 999999))
		
		if char and not char:FindFirstChild(floatName) then
			task.spawn(function()
				local Float = Instance.new("Part")
				Float.Name = floatName
				Float.Parent = char
				Float.Transparency = 1
				Float.Size = Vector3.new(2, 0.2, 1.5)
				Float.Anchored = true
				floatValue = -3.1
				
				local rootPart = char:FindFirstChild("HumanoidRootPart")
				if rootPart then
					Float.CFrame = rootPart.CFrame * CFrame.new(0, floatValue, 0)
				end
				
				floatPart = Float
				
				showPopup("Float ativado (Q desce, E sobe)")
				
				local function FloatPadLoop()
					if char:FindFirstChild(floatName) and char:FindFirstChild("HumanoidRootPart") then
						local root = char:FindFirstChild("HumanoidRootPart")
						Float.CFrame = root.CFrame * CFrame.new(0, floatValue, 0)
					else
						if floatConnections.FloatingFunc then floatConnections.FloatingFunc:Disconnect() end
						if floatConnections.qUp then floatConnections.qUp:Disconnect() end
						if floatConnections.eUp then floatConnections.eUp:Disconnect() end
						if floatConnections.qDown then floatConnections.qDown:Disconnect() end
						if floatConnections.eDown then floatConnections.eDown:Disconnect() end
						if floatConnections.floatDied then floatConnections.floatDied:Disconnect() end
						Float:Destroy()
						floatActive = false
					end
				end
				
				floatConnections.qUp = game:GetService("UserInputService").InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Keyboard then
						local key = string.lower(input.KeyCode.Name)
						if key == "q" then
							floatValue = floatValue + 0.5
						end
					end
				end)
				
				floatConnections.eUp = game:GetService("UserInputService").InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Keyboard then
						local key = string.lower(input.KeyCode.Name)
						if key == "e" then
							floatValue = floatValue - 1.5
						end
					end
				end)
				
				floatConnections.qDown = game:GetService("UserInputService").InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Keyboard then
						local key = string.lower(input.KeyCode.Name)
						if key == "q" then
							floatValue = floatValue - 0.5
						end
					end
				end)
				
				floatConnections.eDown = game:GetService("UserInputService").InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Keyboard then
						local key = string.lower(input.KeyCode.Name)
						if key == "e" then
							floatValue = floatValue + 1.5
						end
					end
				end)
				
				if humanoid then
					floatConnections.floatDied = humanoid.Died:Connect(function()
						if floatConnections.FloatingFunc then floatConnections.FloatingFunc:Disconnect() end
						if floatConnections.qUp then floatConnections.qUp:Disconnect() end
						if floatConnections.eUp then floatConnections.eUp:Disconnect() end
						if floatConnections.qDown then floatConnections.qDown:Disconnect() end
						if floatConnections.eDown then floatConnections.eDown:Disconnect() end
						if floatConnections.floatDied then floatConnections.floatDied:Disconnect() end
						Float:Destroy()
						floatActive = false
					end)
				end
				
				floatConnections.FloatingFunc = game:GetService("RunService").Heartbeat:Connect(FloatPadLoop)
			end)
		end
		
	elseif not enable and floatActive then
		floatActive = false
		
		local char = player.Character
		if char and char:FindFirstChild(floatName) then
			char:FindFirstChild(floatName):Destroy()
		end
		
		if floatConnections.FloatingFunc then floatConnections.FloatingFunc:Disconnect() end
		if floatConnections.qUp then floatConnections.qUp:Disconnect() end
		if floatConnections.eUp then floatConnections.eUp:Disconnect() end
		if floatConnections.qDown then floatConnections.qDown:Disconnect() end
		if floatConnections.eDown then floatConnections.eDown:Disconnect() end
		if floatConnections.floatDied then floatConnections.floatDied:Disconnect() end
		floatConnections = {}
		
		showPopup("Float desativado")
	end
end

-- ============================================
-- FLY
-- ============================================

local function toggleFly(enable)
	local plr = game.Players.LocalPlayer
	local character = plr.Character
	if not character then return end
	
	local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
	local humanoid = character:FindFirstChild("Humanoid")
	if not torso or not humanoid then return end
	
	if enable and not flyActive then
		flyActive = true
		
		local bg = Instance.new("BodyGyro", torso)
		local bv = Instance.new("BodyVelocity", torso)
		
		bg.P = 9e4
		bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.CFrame = torso.CFrame
		
		bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
		bv.Velocity = Vector3.new(0, 0, 0)
		
		humanoid.PlatformStand = true
		
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local spd = flySpeed
		
		local renderConn = game:GetService("RunService").RenderStepped:Connect(function()
			if not flyActive or not character or not character.Parent then
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
		
		flyData = {
			bodyGyro = bg,
			bodyVelocity = bv,
			renderConn = renderConn,
			keyDown = keyDown,
			keyUp = keyUp,
			ctrl = ctrl,
			spd = spd
		}
		
		showPopup("Fly ativado (velocidade: " .. spd .. ")")
		
	elseif not enable and flyActive then
		flyActive = false
		
		if flyData.bodyGyro then flyData.bodyGyro:Destroy() end
		if flyData.bodyVelocity then flyData.bodyVelocity:Destroy() end
		if flyData.renderConn then flyData.renderConn:Disconnect() end
		if flyData.keyDown then flyData.keyDown:Disconnect() end
		if flyData.keyUp then flyData.keyUp:Disconnect() end
		
		if character and character:FindFirstChild("Humanoid") then
			character.Humanoid.PlatformStand = false
		end
		
		flyData = {}
		showPopup("Fly desativado")
	end
end

-- ============================================
-- SPEED E JUMP
-- ============================================

local function setSpeed(value)
	local plr = game.Players.LocalPlayer
	local character = plr.Character
	local humanoid = character and character:FindFirstChild("Humanoid")
	if not humanoid then return end
	
	if value then
		humanoid.WalkSpeed = value
		showPopup("Velocidade: " .. value)
	else
		humanoid.WalkSpeed = 16
		showPopup("Velocidade normal")
	end
end

local function setJump(value)
	local plr = game.Players.LocalPlayer
	local character = plr.Character
	local humanoid = character and character:FindFirstChild("Humanoid")
	if not humanoid then return end
	
	if value then
		humanoid.JumpPower = value
		showPopup("Pulo: " .. value)
	else
		humanoid.JumpPower = 50
		showPopup("Pulo normal")
	end
end

-- ============================================
-- LOOP SPEED
-- ============================================

local function toggleSpeedLoop(value)
	local plr = game.Players.LocalPlayer
	
	if speedLoopActive then
		if speedLoopConn then
			speedLoopConn:Disconnect()
			speedLoopConn = nil
		end
		speedLoopActive = false
		speedLoopValue = nil
		showPopup("Loop speed desativado")
		return
	end
	
	if not value then
		showPopup("Use: loopspeed [numero]")
		return
	end
	
	speedLoopActive = true
	speedLoopValue = value
	
	local function applySpeedLoop()
		local character = plr.Character
		local humanoid = character and character:FindFirstChild("Humanoid")
		if humanoid and speedLoopActive then
			humanoid.WalkSpeed = speedLoopValue
		end
	end
	
	speedLoopConn = game:GetService("RunService").RenderStepped:Connect(applySpeedLoop)
	
	plr.CharacterAdded:Connect(function()
		if speedLoopActive and speedLoopValue then
			task.wait(0.1)
			setSpeed(speedLoopValue)
		end
	end)
	
	showPopup("Loop speed ativado: " .. value)
end

-- ============================================
-- LOOP JUMP
-- ============================================

local function toggleJumpLoop(value)
	local plr = game.Players.LocalPlayer
	
	if jumpLoopActive then
		if jumpLoopConn then
			jumpLoopConn:Disconnect()
			jumpLoopConn = nil
		end
		jumpLoopActive = false
		jumpLoopValue = nil
		showPopup("Loop jump desativado")
		return
	end
	
	if not value then
		showPopup("Use: loopjump [numero]")
		return
	end
	
	jumpLoopActive = true
	jumpLoopValue = value
	
	local function applyJumpLoop()
		local character = plr.Character
		local humanoid = character and character:FindFirstChild("Humanoid")
		if humanoid and jumpLoopActive then
			humanoid.JumpPower = jumpLoopValue
		end
	end
	
	jumpLoopConn = game:GetService("RunService").RenderStepped:Connect(applyJumpLoop)
	
	plr.CharacterAdded:Connect(function()
		if jumpLoopActive and jumpLoopValue then
			task.wait(0.1)
			setJump(jumpLoopValue)
		end
	end)
	
	showPopup("Loop jump ativado: " .. value)
end

-- ============================================
-- INFINITE JUMP
-- ============================================

local function toggleInfJump(enable)
	local plr = game.Players.LocalPlayer
	local character = plr.Character
	local humanoid = character and character:FindFirstChild("Humanoid")
	
	if enable and not infJumpActive then
		infJumpActive = true
		
		local inputService = game:GetService("UserInputService")
		
		infJumpData = inputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then return end
			
			if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Space then
				local humanoid = plr.Character and plr.Character:FindFirstChild("Humanoid")
				if humanoid then
					humanoid:Jump()
				end
			end
		end)
		
		showPopup("Pulo infinito ativado")
		
	elseif not enable and infJumpActive then
		infJumpActive = false
		
		if infJumpData then
			infJumpData:Disconnect()
			infJumpData = nil
		end
		
		showPopup("Pulo infinito desativado")
	end
end

-- ============================================
-- TELEPORT
-- ============================================

local function teleportToPlayer(playerName)
	local targetPlayer = findPlayer(playerName)
	if not targetPlayer or not targetPlayer.Character then
		showPopup("Jogador não encontrado!")
		return
	end
	
	local root = getRoot(player.Character)
	local targetRoot = getRoot(targetPlayer.Character)
	
	if root and targetRoot then
		root.CFrame = targetRoot.CFrame + targetRoot.CFrame.LookVector * 5
		showPopup("Teleportado para " .. targetPlayer.Name)
	end
end

local function bringPlayer(playerName)
	local targetPlayer = findPlayer(playerName)
	if not targetPlayer or not targetPlayer.Character then
		showPopup("Jogador não encontrado!")
		return
	end
	
	local root = getRoot(player.Character)
	local targetRoot = getRoot(targetPlayer.Character)
	
	if root and targetRoot then
		targetRoot.CFrame = root.CFrame + root.CFrame.LookVector * 5
		showPopup("Trouxe " .. targetPlayer.Name)
	end
end

-- ============================================
-- EXECUTAR COMANDOS
-- ============================================

local function executeCommand(input)
	local prefix = Config.Prefix
	
	if not string.sub(input, 1, #prefix) == prefix then
		return
	end
	
	local cmd = string.sub(input, #prefix + 1)
	local args = {}
	
	for word in cmd:gmatch("%S+") do
		table.insert(args, word)
	end
	
	if #args == 0 then return end
	
	local command = string.lower(args[1])
	
	if command == "cmds" then
		-- Mostrar comandos na interface
		local scrolling = ScreenGui.ScrollingFrame
		if scrolling then
			for _, child in ipairs(scrolling:GetChildren()) do
				child:Destroy()
			end
			
			local yOffset = 0
			for _, cmd in ipairs(commands) do
				local label = Instance.new("TextLabel")
				label.Parent = scrolling
				label.Size = UDim2.new(1, -10, 0, 30)
				label.Position = UDim2.new(0, 5, 0, yOffset)
				label.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
				label.BackgroundTransparency = 0
				label.BorderSizePixel = 0
				label.Text = prefix .. cmd.cmd .. " - " .. cmd.desc
				label.TextColor3 = Color3.fromRGB(0, 0, 0)
				label.TextSize = 12
				label.Font = Enum.Font.SourceSans
				label.TextXAlignment = Enum.TextXAlignment.Left
				label.TextWrapped = true
				
				yOffset = yOffset + 35
			end
			
			scrolling.CanvasSize = UDim2.new(0, 0, 0, yOffset)
		end
		
	elseif command == "prefix" then
		if args[2] then
			Config.Prefix = args[2]
			prefix = Config.Prefix
			showPopup("Prefixo alterado para: " .. prefix)
		end
		
	elseif command == "vprefix" then
		showPopup("Prefixo atual: " .. Config.Prefix)
		
	elseif command == "popup" then
		if args[2] then
			if args[2] == "true" then
				Config.Popups = true
				showPopup("Popups ativados")
			elseif args[2] == "false" then
				Config.Popups = false
				print("Popups desativados")
			end
		end
		
	elseif command == "fly" then
		flySpeed = tonumber(args[2]) or 50
		toggleFly(true)
		
	elseif command == "unfly" then
		toggleFly(false)
		
	elseif command == "noclip" then
		toggleNoclip(true)
		
	elseif command == "clip" then
		toggleNoclip(false)
		
	elseif command == "speed" then
		setSpeed(tonumber(args[2]))
		
	elseif command == "jump" then
		setJump(tonumber(args[2]))
		
	elseif command == "loopspeed" then
		toggleSpeedLoop(tonumber(args[2]))
		
	elseif command == "unloopspeed" then
		if speedLoopConn then
			speedLoopConn:Disconnect()
			speedLoopConn = nil
		end
		speedLoopActive = false
		showPopup("Loop speed desativado")
		
	elseif command == "loopjump" then
		toggleJumpLoop(tonumber(args[2]))
		
	elseif command == "unloopjump" then
		if jumpLoopConn then
			jumpLoopConn:Disconnect()
			jumpLoopConn = nil
		end
		jumpLoopActive = false
		showPopup("Loop jump desativado")
		
	elseif command == "infjump" then
		toggleInfJump(true)
		
	elseif command == "uninfjump" then
		toggleInfJump(false)
		
	elseif command == "goto" then
		if args[2] then
			teleportToPlayer(args[2])
		end
		
	elseif command == "bring" then
		if args[2] then
			bringPlayer(args[2])
		end
		
	elseif command == "walkfling" then
		toggleWalkfling(true)
		
	elseif command == "unwalkfling" then
		toggleWalkfling(false)
		
	elseif command == "float" then
		toggleFloat(true)
		
	elseif command == "unfloat" then
		toggleFloat(false)
		
	elseif command == "executor" then
		toggleExecutor(true)
		
	elseif command == "rejoin" then
		rejoinServer()
		
	elseif command == "reset" then
		resetCharacter()
		
	elseif command == "sit" then
		toggleSit()
		
	else
		showPopup("Comando desconhecido!")
	end
end

-- ============================================
-- LISTENER DE COMANDOS
-- ============================================

local cmdBox = ScreenGui.CMDBOX
if cmdBox then
	cmdBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			local input = cmdBox.Text
			cmdBox.Text = ""
			executeCommand(input)
		end
	end)
end

-- ============================================
-- EXECUTOR DE SCRIPTS
-- ============================================

local executorFrame = ScreenGui.ScreenGui:FindFirstChild("ExecutorFrame")
if executorFrame then
	local executeBtn = executorFrame:FindFirstChild("ExecutorExecute")
	local clearBtn = executorFrame:FindFirstChild("ExecutorClear")
	local closeBtn = executorFrame:FindFirstChild("ExecutorClose")
	local textBox = executorFrame:FindFirstChild("ExecutorTextBox")
	
	if executeBtn then
		executeBtn.MouseButton1Click:Connect(function()
			if textBox and textBox.Text ~= "" then
				local success, err = pcall(function()
					loadstring(textBox.Text)()
				end)
				if success then
					showPopup("Script executado com sucesso!")
				else
					showPopup("Erro ao executar: " .. tostring(err))
				end
			end
		end)
	end
	
	if clearBtn then
		clearBtn.MouseButton1Click:Connect(function()
			if textBox then
				textBox.Text = ""
			end
		end)
	end
	
	if closeBtn then
		closeBtn.MouseButton1Click:Connect(function()
			toggleExecutor(false)
		end)
	end
end
