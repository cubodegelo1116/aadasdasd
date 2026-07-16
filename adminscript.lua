-- FRVGMXNT GUI2LUA CONVERTER 1.2. Like pls!

-- ============================================
-- ANTI DUPLICATE
-- ============================================

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

for _, gui in ipairs(playerGui:GetChildren()) do
	if gui.Name == "RXT_Admin_GUI" then
		gui:Destroy()
	end
end

-- ============================================
-- CONFIGURAÇÕES
-- ============================================

local Config = {
	Prefix = "/",
	Popups = true,
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

ScreenGui.ScreenGui.Parent = playerGui
ScreenGui.ScreenGui.Name = "RXT_Admin_GUI"
ScreenGui.ScreenGui.ResetOnSpawn = false

ScreenGui.ComandtxtFrame.Parent = ScreenGui.ScreenGui
ScreenGui.CMDBOX.Parent = ScreenGui.ComandtxtFrame
ScreenGui.CmdsLIST.Parent = ScreenGui.ScreenGui
ScreenGui.Dragbar.Parent = ScreenGui.CmdsLIST
ScreenGui.CloseButton.Parent = ScreenGui.Dragbar
ScreenGui.TextLabel.Parent = ScreenGui.Dragbar
ScreenGui.ScrollingFrame.Parent = ScreenGui.CmdsLIST

ScreenGui.ScreenGui.IgnoreGuiInset = false
ScreenGui.ScreenGui.DisplayOrder = 0

-- ============================================
-- CMDBOX
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
-- AUTOCOMPLETE
-- ============================================

local autocompleteFrame = Instance.new("Frame")
autocompleteFrame.Name = "AutocompleteFrame"
autocompleteFrame.Parent = ScreenGui.ScreenGui
autocompleteFrame.Size = UDim2.new(0, 218, 0, 0)
autocompleteFrame.Position = UDim2.new(1, -230, 1, -65)
autocompleteFrame.BackgroundColor3 = Color3.fromRGB(227,227,227)
autocompleteFrame.BackgroundTransparency = 0
autocompleteFrame.BorderColor3 = Color3.fromRGB(185,185,185)
autocompleteFrame.BorderSizePixel = 3
autocompleteFrame.Visible = false
autocompleteFrame.ZIndex = 10
autocompleteFrame.ClipsDescendants = true

local autocompleteList = Instance.new("ScrollingFrame")
autocompleteList.Name = "AutocompleteList"
autocompleteList.Parent = autocompleteFrame
autocompleteList.Size = UDim2.new(1, 0, 1, 0)
autocompleteList.BackgroundColor3 = Color3.fromRGB(227,227,227)
autocompleteList.BackgroundTransparency = 0
autocompleteList.BorderSizePixel = 0
autocompleteList.ScrollBarThickness = 4
autocompleteList.CanvasSize = UDim2.new(0, 0, 0, 0)

-- ============================================
-- EXECUTOR
-- ============================================

local executorFrame = Instance.new("Frame")
executorFrame.Name = "ExecutorFrame"
executorFrame.Parent = ScreenGui.ScreenGui
executorFrame.Size = UDim2.new(0, 400, 0, 250)
executorFrame.Position = UDim2.new(0.5, -200, 0.3, 0)
executorFrame.BackgroundColor3 = Color3.fromRGB(227,227,227)
executorFrame.BackgroundTransparency = 0
executorFrame.BorderColor3 = Color3.fromRGB(185,185,185)
executorFrame.BorderSizePixel = 3
executorFrame.Visible = false
executorFrame.ZIndex = 10
executorFrame.ClipsDescendants = false

local executorDragbar = Instance.new("Frame")
executorDragbar.Name = "ExecutorDragbar"
executorDragbar.Parent = executorFrame
executorDragbar.Size = UDim2.new(1, 0, 0, 29)
executorDragbar.Position = UDim2.new(0, 0, 0, 0)
executorDragbar.BackgroundColor3 = Color3.fromRGB(227,227,227)
executorDragbar.BackgroundTransparency = 0
executorDragbar.BorderColor3 = Color3.fromRGB(185,185,185)
executorDragbar.BorderSizePixel = 3
executorDragbar.ZIndex = 11

local executorTitle = Instance.new("TextLabel")
executorTitle.Name = "ExecutorTitle"
executorTitle.Parent = executorDragbar
executorTitle.Size = UDim2.new(1, -40, 1, 0)
executorTitle.Position = UDim2.new(0, 10, 0, 0)
executorTitle.BackgroundTransparency = 1
executorTitle.Text = "RXT EXECUTOR"
executorTitle.TextColor3 = Color3.fromRGB(0,0,0)
executorTitle.TextSize = 18
executorTitle.Font = Enum.Font.SourceSansBold
executorTitle.TextXAlignment = Enum.TextXAlignment.Left
executorTitle.TextYAlignment = Enum.TextYAlignment.Center
executorTitle.ZIndex = 11

local executorClose = Instance.new("TextButton")
executorClose.Name = "ExecutorClose"
executorClose.Parent = executorDragbar
executorClose.Size = UDim2.new(0, 30, 0, 30)
executorClose.Position = UDim2.new(1, -30, 0, 0)
executorClose.BackgroundColor3 = Color3.fromRGB(177,0,0)
executorClose.BackgroundTransparency = 0
executorClose.BorderSizePixel = 0
executorClose.Text = ""
executorClose.TextColor3 = Color3.fromRGB(255,255,255)
executorClose.TextSize = 18
executorClose.Font = Enum.Font.SourceSansBold
executorClose.ZIndex = 11

local executorTextBox = Instance.new("TextBox")
executorTextBox.Name = "ExecutorTextBox"
executorTextBox.Parent = executorFrame
executorTextBox.Size = UDim2.new(0.95, 0, 0.65, 0)
executorTextBox.Position = UDim2.new(0.025, 0, 0.12, 0)
executorTextBox.BackgroundColor3 = Color3.fromRGB(255,255,255)
executorTextBox.BackgroundTransparency = 0
executorTextBox.BorderColor3 = Color3.fromRGB(185,185,185)
executorTextBox.BorderSizePixel = 3
executorTextBox.Text = ""
executorTextBox.TextColor3 = Color3.fromRGB(0,0,0)
executorTextBox.TextSize = 14
executorTextBox.Font = Enum.Font.SourceSans
executorTextBox.TextXAlignment = Enum.TextXAlignment.Left
executorTextBox.TextYAlignment = Enum.TextYAlignment.Top
executorTextBox.ClearTextOnFocus = false
executorTextBox.MultiLine = true
executorTextBox.PlaceholderText = "Digite o script aqui..."
executorTextBox.ZIndex = 11

local executorExecute = Instance.new("TextButton")
executorExecute.Name = "ExecutorExecute"
executorExecute.Parent = executorFrame
executorExecute.Size = UDim2.new(0.45, -5, 0, 30)
executorExecute.Position = UDim2.new(0.025, 0, 0.82, 0)
executorExecute.BackgroundColor3 = Color3.fromRGB(227,227,227)
executorExecute.BackgroundTransparency = 0
executorExecute.BorderColor3 = Color3.fromRGB(185,185,185)
executorExecute.BorderSizePixel = 3
executorExecute.Text = "EXECUTAR"
executorExecute.TextColor3 = Color3.fromRGB(0,0,0)
executorExecute.TextSize = 14
executorExecute.Font = Enum.Font.SourceSansBold
executorExecute.ZIndex = 11

local executorClear = Instance.new("TextButton")
executorClear.Name = "ExecutorClear"
executorClear.Parent = executorFrame
executorClear.Size = UDim2.new(0.45, -5, 0, 30)
executorClear.Position = UDim2.new(0.525, 0, 0.82, 0)
executorClear.BackgroundColor3 = Color3.fromRGB(227,227,227)
executorClear.BackgroundTransparency = 0
executorClear.BorderColor3 = Color3.fromRGB(185,185,185)
executorClear.BorderSizePixel = 3
executorClear.Text = "LIMPAR"
executorClear.TextColor3 = Color3.fromRGB(0,0,0)
executorClear.TextSize = 14
executorClear.Font = Enum.Font.SourceSansBold
executorClear.ZIndex = 11

-- ============================================
-- ANIMAÇÃO DA CMDBOX
-- ============================================

task.spawn(function()
	local cmbbox = ScreenGui.CMDBOX
	cmbbox.BackgroundTransparency = 1
	cmbbox.TextTransparency = 1
	cmbbox.Size = UDim2.new(0, 0, 0, 25)
	
	local text = "> RXT ADMIN v1.0"
	for i = 1, #text do
		cmbbox.PlaceholderText = string.sub(text, 1, i)
		task.wait(0.03)
	end
	task.wait(0.3)
	
	cmbbox.PlaceholderText = "digite 'cmds' para ver os comandos"
	
	for i = 1, 15 do
		cmbbox.BackgroundTransparency = 1 - (i / 15)
		cmbbox.TextTransparency = 1 - (i / 15)
		cmbbox.Size = UDim2.new(0, 218 * (i / 15), 0, 25)
		task.wait(0.02)
	end
	
	cmbbox.BackgroundTransparency = 0
	cmbbox.TextTransparency = 0
	cmbbox.Size = UDim2.new(0, 218, 0, 25)
end)

-- ============================================
-- CmdsLIST
-- ============================================

local CMDSLIST_ORIGINAL_POS = UDim2.new(0.311619729, 0, 0.246329531, 0)
local CMDSLIST_ORIGINAL_SIZE = UDim2.new(0, 382, 0, 299)
local isAnimating = false

ScreenGui.CmdsLIST.Name = "CmdsLIST"
ScreenGui.CmdsLIST.ZIndex = 1
ScreenGui.CmdsLIST.Position = CMDSLIST_ORIGINAL_POS
ScreenGui.CmdsLIST.Size = CMDSLIST_ORIGINAL_SIZE
ScreenGui.CmdsLIST.BackgroundColor3 = Color3.fromRGB(227,227,227)
ScreenGui.CmdsLIST.BackgroundTransparency = 0
ScreenGui.CmdsLIST.Visible = false
ScreenGui.CmdsLIST.AnchorPoint = Vector2.new(0, 0)
ScreenGui.CmdsLIST.ClipsDescendants = false
ScreenGui.CmdsLIST.BorderColor3 = Color3.fromRGB(185,185,185)
ScreenGui.CmdsLIST.BorderSizePixel = 3

local function animateCmdsList(show)
	if isAnimating then return end
	isAnimating = true
	
	local list = ScreenGui.CmdsLIST
	
	if show then
		list.Visible = true
		list.BackgroundTransparency = 1
		list.Size = UDim2.new(0, 0, 0, 0)
		list.Position = UDim2.new(CMDSLIST_ORIGINAL_POS.X.Scale, CMDSLIST_ORIGINAL_POS.X.Offset, CMDSLIST_ORIGINAL_POS.Y.Scale + 0.15, CMDSLIST_ORIGINAL_POS.Y.Offset)
		
		for i = 1, 20 do
			list.BackgroundTransparency = 1 - (i / 20)
			list.Size = UDim2.new(0, CMDSLIST_ORIGINAL_SIZE.X.Offset * (i / 20), 0, CMDSLIST_ORIGINAL_SIZE.Y.Offset * (i / 20))
			list.Position = UDim2.new(CMDSLIST_ORIGINAL_POS.X.Scale, CMDSLIST_ORIGINAL_POS.X.Offset, CMDSLIST_ORIGINAL_POS.Y.Scale + (0.15 * (1 - i / 20)), CMDSLIST_ORIGINAL_POS.Y.Offset)
			task.wait(0.015)
		end
		
		list.BackgroundTransparency = 0
		list.Size = CMDSLIST_ORIGINAL_SIZE
		list.Position = CMDSLIST_ORIGINAL_POS
	else
		for i = 1, 15 do
			list.BackgroundTransparency = i / 15
			list.Size = UDim2.new(0, CMDSLIST_ORIGINAL_SIZE.X.Offset * (1 - i / 15), 0, CMDSLIST_ORIGINAL_SIZE.Y.Offset * (1 - i / 15))
			list.Position = UDim2.new(CMDSLIST_ORIGINAL_POS.X.Scale, CMDSLIST_ORIGINAL_POS.X.Offset, CMDSLIST_ORIGINAL_POS.Y.Scale + (0.15 * (i / 15)), CMDSLIST_ORIGINAL_POS.Y.Offset)
			task.wait(0.015)
		end
		list.Visible = false
		list.BackgroundTransparency = 0
		list.Size = CMDSLIST_ORIGINAL_SIZE
		list.Position = CMDSLIST_ORIGINAL_POS
	end
	
	isAnimating = false
end

ScreenGui.CmdsLIST.Visible = false

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
-- VARIÁVEIS GLOBAIS
-- ============================================

local prefix = Config.Prefix
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

-- Walkfling (NOVO)
local walkflingActive = false
local walkflingLoop = nil
local walkflingDiedConn = nil

-- Float
local floatActive = false
local floatName = ""
local floatPart = nil
local floatValue = -3.1
local floatConnections = {}

-- Sit
local sitActive = false

-- ============================================
-- COMANDOS
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
-- FUNÇÕES DOS COMANDOS
-- ============================================

local function toggleExecutor(enable)
	executorFrame.Visible = enable
	if enable then
		task.wait(0.1)
		executorTextBox:CaptureFocus()
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
-- NOCLIP (COM NONOTIFY)
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
-- WALKFLING (NOVO)
-- ============================================

local function toggleWalkfling(enable)
	local plr = game.Players.LocalPlayer
	local character = plr.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	
	if enable and not walkflingActive then
		-- Primeiro desativa walkfling se estiver ativo
		if walkflingActive then
			toggleWalkfling(false)
		end
		
		walkflingActive = true
		
		-- Ativa noclip sem notificação
		toggleNoclip(true, true)
		
		-- Conexão de morte
		if humanoid then
			walkflingDiedConn = humanoid.Died:Connect(function()
				toggleWalkfling(false)
			end)
		end
		
		-- Loop principal
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
		
		-- Desativa noclip sem notificação
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
					end				end)
				
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
-- LOOP
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
			local character = plr.Character
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
			local character = plr.Character
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
-- INFJUMP
-- ============================================

local function toggleInfJump(enable)
	local plr = game.Players.LocalPlayer
	local character = plr.Character
	local humanoid = character and character:FindFirstChild("Humanoid")
	if not humanoid then return end
	
	if enable and not infJumpActive then
		infJumpActive = true
		
		local conn
		conn = game:GetService("UserInputService").JumpRequest:Connect(function()
			if infJumpActive then
				local char = plr.Character
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
-- GOTO, BRING, VIEW
-- ============================================

local function teleportTo(target)
	local plr = game.Players.LocalPlayer
	local character = plr.Character
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
	local plr = game.Players.LocalPlayer
	local character = plr.Character
	local rootPart = character and character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return end
	
	local targetChar = target.Character
	local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
	if not targetRoot then
		showPopup("Jogador sem personagem")
		return
	end
	
	targetRoot.CFrame = rootPart.CFrame + Vector3.new(0, 2, 0)
	showPopup(target.Name .. " trazido ate voce")
end

local function toggleView(target)
	local plr = game.Players.LocalPlayer
	local camera = workspace.CurrentCamera
	
	if viewActive then
		if viewConn then
			viewConn:Disconnect()
			viewConn = nil
		end
		viewActive = false
		viewTarget = nil
		camera.CameraSubject = plr.Character
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
-- ESP
-- ============================================

local function toggleESP(enable)
	local plr = game.Players.LocalPlayer
	
	if enable and not espActive then
		espActive = true
		
		for _, p in ipairs(game.Players:GetPlayers()) do
			if p ~= plr then
				local highlight = Instance.new("Highlight")
				highlight.Name = "ESP_Highlight"
				highlight.Parent = p.Character or p
				highlight.FillColor = Color3.fromRGB(255, 0, 0)
				highlight.FillTransparency = 0.5
				highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
				highlight.OutlineTransparency = 0
				highlight.Adornee = p.Character
				table.insert(espHighlight, highlight)
			end
		end
		
		local function onPlayerAdded(p)
			if p ~= plr then
				local highlight = Instance.new("Highlight")
				highlight.Name = "ESP_Highlight"
				highlight.Parent = p.Character or p
				highlight.FillColor = Color3.fromRGB(255, 0, 0)
				highlight.FillTransparency = 0.5
				highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
				highlight.OutlineTransparency = 0
				highlight.Adornee = p.Character
				table.insert(espHighlight, highlight)
			end
		end
		
		local function onPlayerRemoving(p)
			for i, highlight in ipairs(espHighlight) do
				if highlight and (highlight.Parent == p.Character or highlight.Adornee == p.Character) then
					highlight:Destroy()
					table.remove(espHighlight, i)
					break
				end
			end
		end
		
		local function onCharacterAdded(character)
			local p = game.Players:GetPlayerFromCharacter(character)
			if p and p ~= plr then
				for i, highlight in ipairs(espHighlight) do
					if highlight.Adornee == character then
						highlight:Destroy()
						table.remove(espHighlight, i)
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
				table.insert(espHighlight, highlight)
			end
		end
		
		espConnections.PlayerAdded = game.Players.PlayerAdded:Connect(onPlayerAdded)
		espConnections.PlayerRemoving = game.Players.PlayerRemoving:Connect(onPlayerRemoving)
		espConnections.CharacterAdded = game.Players.PlayerAdded:Connect(function(p)
			p.CharacterAdded:Connect(onCharacterAdded)
		end)
		
		showPopup("ESP ativado")
		
	elseif not enable and espActive then
		espActive = false
		
		for _, highlight in ipairs(espHighlight) do
			highlight:Destroy()
		end
		espHighlight = {}
		
		for _, conn in pairs(espConnections) do
			conn:Disconnect()
		end
		espConnections = {}
		
		showPopup("ESP desativado")
	end
end

-- ============================================
-- TP TOOL
-- ============================================

local function toggleTPTool(enable)
	local plr = game.Players.LocalPlayer
	local backpack = plr:FindFirstChild("Backpack")
	
	if enable and not tpToolActive then
		if tpTool then
			tpTool:Destroy()
			tpTool = nil
		end
		if tpToolConn then
			tpToolConn:Disconnect()
			tpToolConn = nil
		end
		
		local tool = Instance.new("Tool")
		tool.Name = "TP Tool"
		tool.RequiresHandle = false
		tool.CanBeDropped = false
		tool.ToolTip = "Clique em algum lugar para teleportar"
		tool.Parent = backpack
		tool.Grip = CFrame.new(0, 0, 0)
		
		local mouse = plr:GetMouse()
		local currentConn = nil
		
		local function onMouseClick()
			local character = plr.Character
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
		
		if plr.Character and plr.Character:FindFirstChild(tool.Name) then
			currentConn = mouse.Button1Down:Connect(onMouseClick)
		end
		
		tpToolConn = currentConn
		tpTool = tool
		tpToolActive = true
		
	elseif not enable and tpToolActive then
		if tpTool then
			tpTool:Destroy()
			tpTool = nil
		end
		if tpToolConn then
			tpToolConn:Disconnect()
			tpToolConn = nil
		end
		tpToolActive = false
	end
end

-- ============================================
-- EXECUTAR COMANDO
-- ============================================

local function executeCommand(cmd, args)
	if cmd == "cmds" then
		animateCmdsList(not ScreenGui.CmdsLIST.Visible)
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
		if #args > 0 then
			local speed = tonumber(args[1])
			if speed and speed > 0 then
				flySpeed = speed
			end
		end
		toggleFly(true)
		return true
		
	elseif cmd == "unfly" then
		toggleFly(false)
		return true
		
	elseif cmd == "noclip" then
		toggleNoclip(true, false)
		return true
		
	elseif cmd == "clip" then
		toggleNoclip(false, false)
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
			if target then
				teleportTo(target)
			end
		else
			showPopup("Use: goto [nome]")
		end
		return true
		
	elseif cmd == "bring" then
		if #args > 0 then
			local target = findPlayer(args[1])
			if target then
				bringPlayer(target)
			end
		else
			showPopup("Use: bring [nome]")
		end
		return true
		
	elseif cmd == "view" then
		if #args > 0 then
			local target = findPlayer(args[1])
			if target then
				toggleView(target)
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
		
	elseif cmd == "executor" then
		toggleExecutor(not executorFrame.Visible)
		return true
		
	elseif cmd == "rejoin" then
		rejoinServer()
		return true
		
	elseif cmd == "reset" then
		resetCharacter()
		return true
		
	elseif cmd == "float" then
		toggleFloat(true)
		return true
		
	elseif cmd == "unfloat" then
		toggleFloat(false)
		return true
		
	elseif cmd == "sit" then
		toggleSit()
		return true
	end
	
	return false
end

-- ============================================
-- AUTOCOMPLETE FUNCTION
-- ============================================

local function updateAutocomplete(input)
	for _, child in ipairs(autocompleteList:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
	
	if #input == 0 then
		autocompleteFrame.Visible = false
		return
	end
	
	local matches = {}
	local lowerInput = string.lower(input)
	
	for _, cmd in ipairs(commands) do
		local cmdName = string.split(cmd.cmd, " ")[1]
		if string.sub(string.lower(cmdName), 1, #lowerInput) == lowerInput then
			table.insert(matches, cmd)
		end
	end
	
	if #matches == 0 then
		autocompleteFrame.Visible = false
		return
	end
	
	autocompleteFrame.Visible = true
	
	local yOffset = 2
	local buttonHeight = 20
	
	for _, match in ipairs(matches) do
		local btn = Instance.new("TextButton")
		btn.Parent = autocompleteList
		btn.Size = UDim2.new(1, -4, 0, buttonHeight)
		btn.Position = UDim2.new(0, 2, 0, yOffset)
		btn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
		btn.BackgroundTransparency = 0.3
		btn.BorderSizePixel = 0
		btn.Text = match.cmd .. " - " .. match.desc
		btn.TextColor3 = Color3.fromRGB(0, 0, 0)
		btn.TextSize = 12
		btn.TextXAlignment = Enum.TextXAlignment.Left
		btn.Font = Enum.Font.SourceSans
		btn.ZIndex = 11
		
		btn.MouseEnter:Connect(function()
			btn.BackgroundTransparency = 0
		end)
		btn.MouseLeave:Connect(function()
			btn.BackgroundTransparency = 0.3
		end)
		
		btn.MouseButton1Click:Connect(function()
			local cmdName = string.split(match.cmd, " ")[1]
			local args = {}
			local parts = {}
			for part in string.gmatch(match.cmd, "%S+") do
				table.insert(parts, part)
			end
			for i = 2, #parts do
				table.insert(args, parts[i])
			end
			executeCommand(cmdName, args)
			autocompleteFrame.Visible = false
			ScreenGui.CMDBOX.Text = ""
		end)
		
		yOffset = yOffset + buttonHeight + 2
	end
	
	autocompleteList.CanvasSize = UDim2.new(0, 0, 0, yOffset + 4)
	local newHeight = math.min(yOffset + 4, 100)
	autocompleteFrame.Size = UDim2.new(0, 218, 0, newHeight)
	autocompleteFrame.Position = UDim2.new(1, -230, 1, -40 - newHeight - 5)
end

-- ============================================
-- CRIAR BOTÕES DA CMDLIST
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
			local cmdName = string.split(cmdData.cmd, " ")[1]
			local args = {}
			local parts = {}
			for part in string.gmatch(cmdData.cmd, "%S+") do
				table.insert(parts, part)
			end
			for i = 2, #parts do
				table.insert(args, parts[i])
			end
			executeCommand(cmdName, args)
		end)
		
		yOffset = yOffset + buttonHeight + spacing
	end
	
	ScreenGui.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset + 10)
end

createCommandButtons()

-- ============================================
-- AUTOCOMPLETE - DETECTA DIGITAÇÃO
-- ============================================

ScreenGui.CMDBOX:GetPropertyChangedSignal("Text"):Connect(function()
	local text = ScreenGui.CMDBOX.Text
	updateAutocomplete(text)
end)

ScreenGui.CMDBOX.FocusLost:Connect(function()
	task.wait(0.2)
	if not ScreenGui.CMDBOX:IsFocused() then
		autocompleteFrame.Visible = false
	end
end)

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
		ScreenGui.CMDBOX.Text = ""
		autocompleteFrame.Visible = false
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
-- EXECUTOR - BOTÕES
-- ============================================

executorExecute.MouseButton1Click:Connect(function()
	local scriptText = executorTextBox.Text
	if scriptText and scriptText ~= "" then
		local success, err = pcall(function()
			loadstring(scriptText)()
		end)
		if not success then
			showPopup("Erro no script: " .. err)
		else
			showPopup("Script executado!")
		end
	end
end)

executorClear.MouseButton1Click:Connect(function()
	executorTextBox.Text = ""
end)

executorClose.MouseButton1Click:Connect(function()
	toggleExecutor(false)
end)

-- ============================================
-- EXECUTOR - DRAG
-- ============================================

local execDragging = false
local execDragInput, execDragStart, execStartPos

executorDragbar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		execDragging = true
		execDragStart = input.Position
		execStartPos = executorFrame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				execDragging = false
			end
		end)
	end
end)

executorDragbar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		execDragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == execDragInput and execDragging then
		local delta = input.Position - execDragStart
		executorFrame.Position = UDim2.new(execStartPos.X.Scale, execStartPos.X.Offset + delta.X, execStartPos.Y.Scale, execStartPos.Y.Offset + delta.Y)
	end
end)

-- ============================================
-- FECHAR GUI
-- ============================================

ScreenGui.CloseButton.MouseButton1Click:Connect(function()
	animateCmdsList(false)
end)

-- ============================================
-- DRAG DA CMDLIST
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
-- LIMPAR TUDO QUANDO RESPAWNA
-- ============================================

game.Players.LocalPlayer.CharacterAdded:Connect(function()
	if flyActive then
		toggleFly(false)
	end
	if noclipActive then
		toggleNoclip(false, true)
	end
	if infJumpActive then
		toggleInfJump(false)
	end
	if viewActive then
		toggleView(nil)
	end
	if tpToolActive then
		toggleTPTool(false)
	end
	if espActive then
		toggleESP(false)
	end
	if walkflingActive then
		toggleWalkfling(false)
	end
	if floatActive then
		toggleFloat(false)
	end
end)
