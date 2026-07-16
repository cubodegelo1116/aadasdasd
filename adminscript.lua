-- FRVGMXNT GUI2LUA CONVERTER 1.2. Like pls!

-- ============================================
-- CONFIGURAÇÕES
-- ============================================

local Config = {
	Prefix = "/", -- Prefixo dos comandos
	Popups = true, -- true = mostra popups, false = não mostra
}

local ScreenGui = {
	ScreenGui = Instance.new("ScreenGui"),
	ComandtxtFrame = Instance.new("Frame"),
	CMDBOX = Instance.new("TextBox"),
	CmdsLIST = Instance.new("Frame"),
	Dragbar = Instance.new("Frame"),
	CloseButton = Instance.new("TextButton"),
	TextLabel = Instance.new("TextLabel"),
	ScrollingFrame = Instance.new("ScrollingFrame"),
}

ScreenGui.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ScreenGui.ResetOnSpawn = false

ScreenGui.ComandtxtFrame.Parent = ScreenGui.ScreenGui
ScreenGui.CMDBOX.Parent = ScreenGui.ComandtxtFrame
ScreenGui.CmdsLIST.Parent = ScreenGui.ScreenGui
ScreenGui.Dragbar.Parent = ScreenGui.CmdsLIST
ScreenGui.CloseButton.Parent = ScreenGui.Dragbar
ScreenGui.TextLabel.Parent = ScreenGui.Dragbar
ScreenGui.ScrollingFrame.Parent = ScreenGui.CmdsLIST

ScreenGui.ScreenGui.Name = "ScreenGui"
ScreenGui.ScreenGui.IgnoreGuiInset = false
ScreenGui.ScreenGui.DisplayOrder = 0

-- ============================================
-- CMDBOX - CANTO INFERIOR DIREITO
-- ============================================

ScreenGui.ComandtxtFrame.Name = "ComandtxtFrame"
ScreenGui.ComandtxtFrame.ZIndex = 1
ScreenGui.ComandtxtFrame.Position = UDim2.new(1, -230, 1, -40)
ScreenGui.ComandtxtFrame.Size = UDim2.new(0, 218, 0, 25)
ScreenGui.ComandtxtFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
ScreenGui.ComandtxtFrame.BackgroundTransparency = 1
ScreenGui.ComandtxtFrame.Visible = true
ScreenGui.ComandtxtFrame.AnchorPoint = Vector2.new(0, 0)
ScreenGui.ComandtxtFrame.ClipsDescendants = false
ScreenGui.ComandtxtFrame.BorderSizePixel = 0

ScreenGui.CMDBOX.Name = "CMDBOX"
ScreenGui.CMDBOX.ZIndex = 1
ScreenGui.CMDBOX.Position = UDim2.new(0, 0, 0, 0)
ScreenGui.CMDBOX.Size = UDim2.new(0, 218, 0, 25)
ScreenGui.CMDBOX.BackgroundColor3 = Color3.fromRGB(227,227,227)
ScreenGui.CMDBOX.BackgroundTransparency = 0
ScreenGui.CMDBOX.Text = ""
ScreenGui.CMDBOX.TextScaled = false
ScreenGui.CMDBOX.TextSize = 14
ScreenGui.CMDBOX.Font = Enum.Font.SourceSans
ScreenGui.CMDBOX.TextColor3 = Color3.fromRGB(0,0,0)
ScreenGui.CMDBOX.TextStrokeColor3 = Color3.fromRGB(0,0,0)
ScreenGui.CMDBOX.TextStrokeTransparency = 1
ScreenGui.CMDBOX.TextWrapped = false
ScreenGui.CMDBOX.TextXAlignment = Enum.TextXAlignment.Center
ScreenGui.CMDBOX.TextYAlignment = Enum.TextYAlignment.Center
ScreenGui.CMDBOX.TextTransparency = 0
ScreenGui.CMDBOX.ClearTextOnFocus = true
ScreenGui.CMDBOX.MultiLine = false
ScreenGui.CMDBOX.Visible = true
ScreenGui.CMDBOX.AnchorPoint = Vector2.new(0, 0)
ScreenGui.CMDBOX.ClipsDescendants = false
ScreenGui.CMDBOX.PlaceholderText = "digite 'cmds' para ver os comandos"
ScreenGui.CMDBOX.BorderColor3 = Color3.fromRGB(185,185,185)
ScreenGui.CMDBOX.BorderSizePixel = 3

-- ============================================
-- LISTA DE COMANDOS
-- ============================================

ScreenGui.CmdsLIST.Name = "CmdsLIST"
ScreenGui.CmdsLIST.ZIndex = 1
ScreenGui.CmdsLIST.Position = UDim2.new(0.311619729, 0, 0.246329531, 0)
ScreenGui.CmdsLIST.Size = UDim2.new(0, 382, 0, 299)
ScreenGui.CmdsLIST.BackgroundColor3 = Color3.fromRGB(227,227,227)
ScreenGui.CmdsLIST.BackgroundTransparency = 0
ScreenGui.CmdsLIST.Visible = false
ScreenGui.CmdsLIST.AnchorPoint = Vector2.new(0, 0)
ScreenGui.CmdsLIST.ClipsDescendants = false
ScreenGui.CmdsLIST.BorderColor3 = Color3.fromRGB(185,185,185)
ScreenGui.CmdsLIST.BorderSizePixel = 3

ScreenGui.Dragbar.Name = "Dragbar"
ScreenGui.Dragbar.ZIndex = 1
ScreenGui.Dragbar.Position = UDim2.new(-0, 0, -0, 0)
ScreenGui.Dragbar.Size = UDim2.new(0, 382, 0, 29)
ScreenGui.Dragbar.BackgroundColor3 = Color3.fromRGB(227,227,227)
ScreenGui.Dragbar.BackgroundTransparency = 0
ScreenGui.Dragbar.Visible = true
ScreenGui.Dragbar.AnchorPoint = Vector2.new(0, 0)
ScreenGui.Dragbar.ClipsDescendants = false
ScreenGui.Dragbar.BorderColor3 = Color3.fromRGB(185,185,185)
ScreenGui.Dragbar.BorderSizePixel = 3

ScreenGui.CloseButton.Name = "CloseButton"
ScreenGui.CloseButton.ZIndex = 1
ScreenGui.CloseButton.Position = UDim2.new(0.931999981, 0, 0.0799999982, 0)
ScreenGui.CloseButton.Size = UDim2.new(0, 22, 0, 22)
ScreenGui.CloseButton.BackgroundColor3 = Color3.fromRGB(177,0,0)
ScreenGui.CloseButton.BackgroundTransparency = 0
ScreenGui.CloseButton.Text = ""
ScreenGui.CloseButton.TextScaled = false
ScreenGui.CloseButton.TextSize = 14
ScreenGui.CloseButton.Font = Enum.Font.SourceSans
ScreenGui.CloseButton.TextColor3 = Color3.fromRGB(0,0,0)
ScreenGui.CloseButton.TextStrokeColor3 = Color3.fromRGB(0,0,0)
ScreenGui.CloseButton.TextStrokeTransparency = 1
ScreenGui.CloseButton.TextWrapped = false
ScreenGui.CloseButton.TextXAlignment = Enum.TextXAlignment.Center
ScreenGui.CloseButton.TextYAlignment = Enum.TextYAlignment.Center
ScreenGui.CloseButton.TextTransparency = 0
ScreenGui.CloseButton.Visible = true
ScreenGui.CloseButton.AnchorPoint = Vector2.new(0, 0)
ScreenGui.CloseButton.ClipsDescendants = false
ScreenGui.CloseButton.BorderSizePixel = 0

ScreenGui.TextLabel.Name = "TextLabel"
ScreenGui.TextLabel.ZIndex = 1
ScreenGui.TextLabel.Position = UDim2.new(0.0185540486, 0, -0.068965517, 0)
ScreenGui.TextLabel.Size = UDim2.new(0, 115, 0, 29)
ScreenGui.TextLabel.BackgroundColor3 = Color3.fromRGB(255,255,255)
ScreenGui.TextLabel.BackgroundTransparency = 1
ScreenGui.TextLabel.Text = "RXT ADMIN"
ScreenGui.TextLabel.TextScaled = false
ScreenGui.TextLabel.TextSize = 30
ScreenGui.TextLabel.Font = Enum.Font.SourceSans
ScreenGui.TextLabel.TextColor3 = Color3.fromRGB(0,0,0)
ScreenGui.TextLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0)
ScreenGui.TextLabel.TextStrokeTransparency = 1
ScreenGui.TextLabel.TextWrapped = false
ScreenGui.TextLabel.TextXAlignment = Enum.TextXAlignment.Left
ScreenGui.TextLabel.TextYAlignment = Enum.TextYAlignment.Center
ScreenGui.TextLabel.TextTransparency = 0
ScreenGui.TextLabel.Visible = true
ScreenGui.TextLabel.AnchorPoint = Vector2.new(0, 0)
ScreenGui.TextLabel.ClipsDescendants = false
ScreenGui.TextLabel.BorderColor3 = Color3.fromRGB(185,185,185)
ScreenGui.TextLabel.BorderSizePixel = 3

ScreenGui.ScrollingFrame.Name = "ScrollingFrame"
ScreenGui.ScrollingFrame.ZIndex = 1
ScreenGui.ScrollingFrame.Position = UDim2.new(0, 0, 0.0969899669, 0)
ScreenGui.ScrollingFrame.Size = UDim2.new(0, 381, 0, 270)
ScreenGui.ScrollingFrame.BackgroundColor3 = Color3.fromRGB(227,227,227)
ScreenGui.ScrollingFrame.BackgroundTransparency = 0
ScreenGui.ScrollingFrame.Visible = true
ScreenGui.ScrollingFrame.AnchorPoint = Vector2.new(0, 0)
ScreenGui.ScrollingFrame.ClipsDescendants = true
ScreenGui.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
ScreenGui.ScrollingFrame.ScrollBarThickness = 12
ScreenGui.ScrollingFrame.ScrollingEnabled = true
ScreenGui.ScrollingFrame.BorderColor3 = Color3.fromRGB(185,185,185)
ScreenGui.ScrollingFrame.BorderSizePixel = 3

-- ============================================
-- POPUP NOTIFICATION
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

-- ============================================
-- FUNÇÃO PARA ENCONTRAR JOGADOR
-- ============================================

local function findPlayer(name)
	local found = {}
	local lowerName = string.lower(name)
	
	for _, player in ipairs(game.Players:GetPlayers()) do
		local lowerPlayerName = string.lower(player.Name)
		local lowerDisplayName = string.lower(player.DisplayName)
		
		if lowerPlayerName == lowerName or lowerDisplayName == lowerName then
			return player
		end
		
		if string.find(lowerPlayerName, lowerName, 1, true) or string.find(lowerDisplayName, lowerName, 1, true) then
			table.insert(found, player)
		end
	end
	
	if #found == 1 then
		return found[1]
	elseif #found > 1 then
		return found
	end
	
	return nil
end

-- ============================================
-- CONFIG
-- ============================================

local prefix = Config.Prefix
local flyActive = false
local flyData = {}
local noclipActive = false
local noclipConn = nil

-- Speed e Jump
local speedLoopActive = false
local speedLoopConn = nil
local speedLoopValue = nil
local jumpLoopActive = false
local jumpLoopConn = nil
local jumpLoopValue = nil
local infJumpActive = false
local infJumpData = nil

-- View
local viewActive = false
local viewConn = nil
local viewTarget = nil

-- TP Tool
local tpToolActive = false
local tpTool = nil

-- ============================================
-- LISTA DE COMANDOS
-- ============================================

local commands = {
	{cmd = "cmds", desc = "Abre esta lista de comandos"},
	{cmd = "prefix [novo]", desc = "Muda o prefixo"},
	{cmd = "vprefix", desc = "Mostra o prefixo atual"},
	{cmd = "popup true", desc = "Ativa os popups"},
	{cmd = "popup false", desc = "Desativa os popups"},
	{cmd = "fly", desc = "Ativa o modo voo"},
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
	{cmd = "goto [nome]", desc = "Teleporta até o jogador"},
	{cmd = "bring [nome]", desc = "Puxa o jogador até você"},
	{cmd = "view [nome]", desc = "Observa o jogador"},
	{cmd = "unview", desc = "Para de observar"},
	{cmd = "tptool", desc = "Dá uma tool de teleporte"},
	{cmd = "untptool", desc = "Remove a tool de teleporte"},
}

-- ============================================
-- FUNÇÃO TP TOOL (SEM POPUPS)
-- ============================================

local function toggleTPTool(enable)
	local player = game.Players.LocalPlayer
	local backpack = player:FindFirstChild("Backpack")
	
	if enable and not tpToolActive then
		-- Remove tool antiga se existir
		if tpTool then
			tpTool:Destroy()
			tpTool = nil
		end
		
		-- Criar a tool
		local tool = Instance.new("Tool")
		tool.Name = "TP Tool"
		tool.RequiresHandle = false
		tool.CanBeDropped = false
		tool.ToolTip = "Clique em algum lugar para teleportar"
		tool.Parent = backpack
		
		-- Tool invisível (sem handle)
		tool.Handle = nil
		
		-- Não levanta o braço
		tool.Grip = CFrame.new(0, 0, 0)
		
		-- Função de clique (SEM POPUP)
		local function onActivated()
			local mouse = player:GetMouse()
			local target = mouse.Target
			local hit = mouse.Hit
			
			if target and hit then
				local position = hit.Position
				local character = player.Character
				local rootPart = character and character:FindFirstChild("HumanoidRootPart")
				
				if rootPart then
					rootPart.CFrame = CFrame.new(position.X, position.Y + 2, position.Z)
				end
			end
		end
		
		tool.Activated:Connect(onActivated)
		
		tpTool = tool
		tpToolActive = true
		
	elseif not enable and tpToolActive then
		if tpTool then
			tpTool:Destroy()
			tpTool = nil
		end
		tpToolActive = false
	end
end

-- ============================================
-- FUNÇÃO FLY
-- ============================================

local function toggleFly(enable)
	local player = game.Players.LocalPlayer
	local character = player.Character
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
		bv.Velocity = Vector3.new(0, 0.1, 0)
		
		humanoid.PlatformStand = true
		
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local spd = 50
		
		local function onKeyDown(key)
			if key == "w" then ctrl.f = 1 end
			if key == "s" then ctrl.b = -1 end
			if key == "a" then ctrl.l = -1 end
			if key == "d" then ctrl.r = 1 end
		end
		
		local function onKeyUp(key)
			if key == "w" then ctrl.f = 0 end
			if key == "s" then ctrl.b = 0 end
			if key == "a" then ctrl.l = 0 end
			if key == "d" then ctrl.r = 0 end
		end
		
		local connections = {}
		connections.KeyDown = game:GetService("UserInputService").InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Keyboard then
				local key = string.lower(input.KeyCode.Name)
				onKeyDown(key)
			end
		end)
		
		connections.KeyUp = game:GetService("UserInputService").InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Keyboard then
				local key = string.lower(input.KeyCode.Name)
				onKeyUp(key)
			end
		end)
		
		local renderConn
		renderConn = game:GetService("RunService").RenderStepped:Connect(function()
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
				local speed = (ctrl.f + ctrl.b)
				local strafe = (ctrl.r + ctrl.l)
				local forward = cam.CFrame.LookVector * (speed * spd)
				local right = cam.CFrame.RightVector * (strafe * spd)
				local up = Vector3.new(0, 0.1, 0)
				
				if ctrl.f == 0 and ctrl.b == 0 and ctrl.l == 0 and ctrl.r == 0 then
					bv.Velocity = Vector3.new(0, 0.1, 0)
				else
					bv.Velocity = forward + right + up
				end
				bg.CFrame = cam.CFrame
			end
		end)
		
		flyData = {
			bodyGyro = bg,
			bodyVelocity = bv,
			connections = connections,
			renderConn = renderConn,
			ctrl = ctrl,
			spd = spd
		}
		
		showPopup("Fly ativado")
		
	elseif not enable and flyActive then
		flyActive = false
		
		if flyData.bodyGyro then flyData.bodyGyro:Destroy() end
		if flyData.bodyVelocity then flyData.bodyVelocity:Destroy() end
		if flyData.connections then
			if flyData.connections.KeyDown then flyData.connections.KeyDown:Disconnect() end
			if flyData.connections.KeyUp then flyData.connections.KeyUp:Disconnect() end
		end
		if flyData.renderConn then flyData.renderConn:Disconnect() end
		
		if character and character:FindFirstChild("Humanoid") then
			character.Humanoid.PlatformStand = false
		end
		
		flyData = {}
		showPopup("Fly desativado")
	end
end

-- ============================================
-- FUNÇÃO NOCLIP
-- ============================================

local function toggleNoclip(enable)
	local player = game.Players.LocalPlayer
	local character = player.Character
	if not character then return end
	
	if enable and not noclipActive then
		noclipActive = true
		
		noclipConn = game:GetService("RunService").Stepped:Connect(function()
			if not noclipActive or not character or not character.Parent then
				toggleNoclip(false)
				return
			end
			
			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end)
		
		showPopup("Noclip ativado")
		
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
		
		showPopup("Noclip desativado")
	end
end

-- ============================================
-- FUNÇÕES SPEED E JUMP
-- ============================================

local function setSpeed(value)
	local player = game.Players.LocalPlayer
	local character = player.Character
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
	local player = game.Players.LocalPlayer
	local character = player.Character
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
-- FUNÇÕES LOOP
-- ============================================

local function toggleSpeedLoop(value)
	local player = game.Players.LocalPlayer
	
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
		local character = player.Character
		local humanoid = character and character:FindFirstChild("Humanoid")
		if humanoid and speedLoopActive then
			humanoid.WalkSpeed = speedLoopValue
		end
	end
	
	speedLoopConn = game:GetService("RunService").RenderStepped:Connect(applySpeedLoop)
	
	player.CharacterAdded:Connect(function()
		if speedLoopActive and speedLoopValue then
			task.wait(0.1)
			local character = player.Character
			local humanoid = character and character:FindFirstChild("Humanoid")
			if humanoid then
				humanoid.WalkSpeed = speedLoopValue
			end
		end
	end)
	
	applySpeedLoop()
	showPopup("Loop speed ativado: " .. value)
end

local function toggleJumpLoop(value)
	local player = game.Players.LocalPlayer
	
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
		local character = player.Character
		local humanoid = character and character:FindFirstChild("Humanoid")
		if humanoid and jumpLoopActive then
			humanoid.JumpPower = jumpLoopValue
		end
	end
	
	jumpLoopConn = game:GetService("RunService").RenderStepped:Connect(applyJumpLoop)
	
	player.CharacterAdded:Connect(function()
		if jumpLoopActive and jumpLoopValue then
			task.wait(0.1)
			local character = player.Character
			local humanoid = character and character:FindFirstChild("Humanoid")
			if humanoid then
				humanoid.JumpPower = jumpLoopValue
			end
		end
	end)
	
	applyJumpLoop()
	showPopup("Loop jump ativado: " .. value)
end

-- ============================================
-- FUNÇÃO INFJUMP
-- ============================================

local function toggleInfJump(enable)
	local player = game.Players.LocalPlayer
	local character = player.Character
	local humanoid = character and character:FindFirstChild("Humanoid")
	if not humanoid then return end
	
	if enable and not infJumpActive then
		infJumpActive = true
		
		local conn
		conn = game:GetService("UserInputService").JumpRequest:Connect(function()
			if infJumpActive then
				local char = player.Character
				local hum = char and char:FindFirstChild("Humanoid")
				if hum then
					hum:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end
		end)
		
		infJumpData = conn
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
-- FUNÇÕES GOTO, BRING E VIEW
-- ============================================

local function teleportTo(target)
	local player = game.Players.LocalPlayer
	local character = player.Character
	local rootPart = character and character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return end
	
	local targetChar = target.Character
	local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
	if not targetRoot then
		showPopup("Jogador sem personagem")
		return
	end
	
	rootPart.CFrame = targetRoot.CFrame + Vector3.new(0, 2, 0)
	showPopup("Teleportado para " .. target.Name)
end

local function bringPlayer(target)
	local player = game.Players.LocalPlayer
	local character = player.Character
	local rootPart = character and character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return end
	
	local targetChar = target.Character
	local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
	if not targetRoot then
		showPopup("Jogador sem personagem")
		return
	end
	
	targetRoot.CFrame = rootPart.CFrame + Vector3.new(0, 2, 0)
	showPopup(target.Name .. " trazido até você")
end

local function toggleView(target)
	local player = game.Players.LocalPlayer
	local camera = workspace.CurrentCamera
	
	if viewActive then
		if viewConn then
			viewConn:Disconnect()
			viewConn = nil
		end
		viewActive = false
		viewTarget = nil
		camera.CameraSubject = player.Character
		showPopup("View desativado")
		return
	end
	
	if not target then
		showPopup("Use: view [nome]")
		return
	end
	
	local targetChar = target.Character
	local targetHead = targetChar and targetChar:FindFirstChild("Head")
	if not targetHead then
		showPopup("Jogador sem personagem")
		return
	end
	
	viewActive = true
	viewTarget = target
	camera.CameraSubject = targetHead
	
	viewConn = game:GetService("RunService").RenderStepped:Connect(function()
		if not viewActive or not viewTarget or not viewTarget.Parent then
			toggleView(nil)
			return
		end
		
		local char = viewTarget.Character
		local head = char and char:FindFirstChild("Head")
		if head then
			camera.CameraSubject = head
		end
	end)
	
	showPopup("Observando " .. target.Name)
end

-- ============================================
-- CRIAR BOTÕES
-- ============================================

local function createCommandButtons()
	local yOffset = 5
	local buttonHeight = 25
	local spacing = 3
	
	for i, cmdData in ipairs(commands) do
		local cmdButton = Instance.new("TextButton")
		cmdButton.Parent = ScreenGui.ScrollingFrame
		cmdButton.Size = UDim2.new(0.95, 0, 0, buttonHeight)
		cmdButton.Position = UDim2.new(0.025, 0, 0, yOffset)
		cmdButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
		cmdButton.BackgroundTransparency = 0.5
		cmdButton.BorderSizePixel = 0
		cmdButton.Text = cmdData.cmd .. " - " .. cmdData.desc
		cmdButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		cmdButton.TextSize = 13
		cmdButton.TextXAlignment = Enum.TextXAlignment.Left
		cmdButton.TextYAlignment = Enum.TextYAlignment.Center
		cmdButton.Font = Enum.Font.SourceSans
		cmdButton.BorderColor3 = Color3.fromRGB(185,185,185)
		cmdButton.BorderSizePixel = 3
		
		cmdButton.MouseButton1Click:Connect(function()
			ScreenGui.CMDBOX.Text = cmdData.cmd
			ScreenGui.CmdsLIST.Visible = false
			task.wait(0.1)
			ScreenGui.CMDBOX:CaptureFocus()
		end)
		
		yOffset = yOffset + buttonHeight + spacing
	end
	
	ScreenGui.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset + 10)
end

createCommandButtons()

-- ============================================
-- FUNÇÃO DOS COMANDOS
-- ============================================

local function executeCommand(cmd, args)
	if cmd == "cmds" then
		ScreenGui.CmdsLIST.Visible = not ScreenGui.CmdsLIST.Visible
		return true
		
	elseif cmd == "prefix" then
		if #args > 0 then
			prefix = args[1]
			showPopup("Prefixo alterado para: " .. prefix)
		else
			showPopup("Use: prefix [novo prefixo]")
		end
		return true
		
	elseif cmd == "vprefix" then
		showPopup("Prefixo atual: " .. prefix)
		return true
		
	elseif cmd == "popup" then
		if #args > 0 then
			if args[1] == "true" then
				Config.Popups = true
				showPopup("Popups ativados")
			elseif args[1] == "false" then
				Config.Popups = false
			else
				showPopup("Use: popup true ou popup false")
			end
		else
			showPopup("Use: popup true ou popup false")
		end
		return true
		
	elseif cmd == "fly" then
		toggleFly(true)
		return true
		
	elseif cmd == "unfly" then
		toggleFly(false)
		return true
		
	elseif cmd == "noclip" then
		toggleNoclip(true)
		return true
		
	elseif cmd == "clip" then
		toggleNoclip(false)
		return true
		
	elseif cmd == "speed" then
		if #args > 0 then
			local value = tonumber(args[1])
			if value then
				setSpeed(value)
			else
				showPopup("Use: speed [numero]")
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
				showPopup("Use: jump [numero]")
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
				showPopup("Use: loopspeed [numero]")
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
				showPopup("Use: loopjump [numero]")
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
			local target = findPlayer(args[1])
			if type(target) == "table" then
				showPopup("Vários jogadores encontrados: " .. table.concat(target, ", "))
			elseif target then
				teleportTo(target)
			else
				showPopup("Jogador não encontrado")
			end
		else
			showPopup("Use: goto [nome]")
		end
		return true
		
	elseif cmd == "bring" then
		if #args > 0 then
			local target = findPlayer(args[1])
			if type(target) == "table" then
				showPopup("Vários jogadores encontrados: " .. table.concat(target, ", "))
			elseif target then
				bringPlayer(target)
			else
				showPopup("Jogador não encontrado")
			end
		else
			showPopup("Use: bring [nome]")
		end
		return true
		
	elseif cmd == "view" then
		if #args > 0 then
			local target = findPlayer(args[1])
			if type(target) == "table" then
				showPopup("Vários jogadores encontrados: " .. table.concat(target, ", "))
			elseif target then
				toggleView(target)
			else
				showPopup("Jogador não encontrado")
			end
		else
			showPopup("Use: view [nome]")
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
	end
	
	return false
end

-- ============================================
-- PROCESSAR COMANDO VIA CMDBOX
-- ============================================

ScreenGui.CMDBOX.FocusLost:Connect(function(enterPressed)
	if enterPressed and ScreenGui.CMDBOX.Text ~= "" then
		local fullCommand = ScreenGui.CMDBOX.Text
		local parts = {}
		for part in string.gmatch(fullCommand, "%S+") do
			table.insert(parts, part)
		end
		
		local cmd = parts[1] or ""
		local args = {}
		for i = 2, #parts do
			table.insert(args, parts[i])
		end
		
		if string.sub(cmd, 1, 1) == prefix then
			cmd = string.sub(cmd, 2)
		end
		
		executeCommand(cmd, args)
		ScreenGui.CMDBOX.Text = "" -- APAGA INSTANTANEAMENTE
	end
end)

-- ============================================
-- PROCESSAR COMANDO VIA CHAT
-- ============================================

game:GetService("Players").LocalPlayer.Chatted:Connect(function(message)
	local parts = {}
	for part in string.gmatch(message, "%S+") do
		table.insert(parts, part)
	end
	
	local cmd = parts[1] or ""
	local args = {}
	for i = 2, #parts do
		table.insert(args, parts[i])
	end
	
	if string.sub(cmd, 1, 1) == prefix then
		cmd = string.sub(cmd, 2)
		executeCommand(cmd, args)
	end
end)

-- ============================================
-- FECHAR GUI
-- ============================================

ScreenGui.CloseButton.MouseButton1Click:Connect(function()
	ScreenGui.CmdsLIST.Visible = false
end)

-- ============================================
-- DRAG
-- ============================================

local dragging = false
local dragInput, dragStart, startPos

ScreenGui.Dragbar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = ScreenGui.CmdsLIST.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

ScreenGui.Dragbar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		ScreenGui.CmdsLIST.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- ============================================
-- LIMPAR FLY E NOCLIP QUANDO RESPAWNA
-- ============================================

game.Players.LocalPlayer.CharacterAdded:Connect(function()
	if flyActive then
		toggleFly(false)
	end
	if noclipActive then
		toggleNoclip(false)
	end
	if infJumpActive then
		toggleInfJump(false)
	end
	if viewActive then
		toggleView(nil)
	end
end)
