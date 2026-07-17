-- ============================================
-- RXT ADMIN - MAIN
-- ============================================

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
-- CARREGAR COMANDOS
-- ============================================

local function loadCommands()
	local success, result = pcall(function()
		return game:HttpGet("https://raw.githubusercontent.com/cubodegelo1116/aadasdasd/refs/heads/main/commands.lua")
	end)
	
	if success and result then
		local fn, err = loadstring(result)
		if fn then
			local cmdTable = fn()
			if type(cmdTable) == "table" then
				_G.RXT_Commands = cmdTable
				print("✅ Comandos carregados: " .. #cmdTable)
				return true
			end
		end
	end
	return false
end

if not loadCommands() then
	_G.RXT_Commands = {
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
	print("⚠️ Usando comandos embutidos (fallback)")
end

-- ============================================
-- CONFIGURAÇÕES
-- ============================================

_G.RXT_Config = {
	Prefix = "/",
	Popups = true,
}

-- ============================================
-- CRIAR GUI
-- ============================================

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
-- EXPOR GUI PARA OS COMANDOS
-- ============================================

_G.RXT_GUI = ScreenGui
_G.RXT_Player = player
_G.RXT_PlayerGui = playerGui

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

_G.RXT_AutocompleteList = autocompleteList
_G.RXT_AutocompleteFrame = autocompleteFrame

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

_G.RXT_ExecutorFrame = executorFrame
_G.RXT_ExecutorTextBox = executorTextBox

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
-- CmdsLIST (COM ANIMAÇÃO DE SAÍDA - Y ATÉ 0)
-- ============================================

local CMDSLIST_ORIGINAL_POS = UDim2.new(0.311619729, 0, 0.246329531, 0)
local CMDSLIST_ORIGINAL_SIZE = UDim2.new(0, 382, 0, 299)
local isAnimating = false
local savedPosition = CMDSLIST_ORIGINAL_POS

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

function _G.RXT_AnimateCmdsList(show)
	if isAnimating then return end
	isAnimating = true
	
	local list = ScreenGui.CmdsLIST
	local currentPos = list.Position
	
	if show then
		list.Visible = true
		list.BackgroundTransparency = 1
		list.Size = UDim2.new(0, 0, 0, 0)
		list.Position = UDim2.new(currentPos.X.Scale, currentPos.X.Offset, currentPos.Y.Scale + 0.15, currentPos.Y.Offset)
		
		for i = 1, 20 do
			list.BackgroundTransparency = 1 - (i / 20)
			list.Size = UDim2.new(0, CMDSLIST_ORIGINAL_SIZE.X.Offset * (i / 20), 0, CMDSLIST_ORIGINAL_SIZE.Y.Offset * (i / 20))
			list.Position = UDim2.new(currentPos.X.Scale, currentPos.X.Offset, currentPos.Y.Scale + (0.15 * (1 - i / 20)), currentPos.Y.Offset)
			task.wait(0.015)
		end
		
		list.BackgroundTransparency = 0
		list.Size = CMDSLIST_ORIGINAL_SIZE
		list.Position = currentPos
	else
		for i = 1, 15 do
			local progress = i / 15
			list.BackgroundTransparency = progress
			local newHeight = CMDSLIST_ORIGINAL_SIZE.Y.Offset * (1 - progress)
			list.Size = UDim2.new(0, CMDSLIST_ORIGINAL_SIZE.X.Offset * (1 - progress * 0.3), 0, newHeight)
			list.Position = UDim2.new(currentPos.X.Scale, currentPos.X.Offset, currentPos.Y.Scale + (CMDSLIST_ORIGINAL_SIZE.Y.Offset * (progress * 0.5)), currentPos.Y.Offset)
			task.wait(0.015)
		end
		
		list.Visible = false
		list.BackgroundTransparency = 0
		list.Size = CMDSLIST_ORIGINAL_SIZE
		list.Position = currentPos
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

function _G.RXT_ShowPopup(text)
	if not _G.RXT_Config.Popups then return end
	
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

function _G.RXT_FindPlayer(name)
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
		_G.RXT_ShowPopup("Varios jogadores encontrados: " .. table.concat(names, ", "))
		return nil
	end
	
	return nil
end

function _G.RXT_GetRoot(character)
	if not character then return nil end
	return character:FindFirstChild("HumanoidRootPart")
end

-- ============================================
-- CRIAR BOTÕES DA CMDLIST
-- ============================================

local function createCommandButtons()
	local commands = _G.RXT_Commands or {}
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
			if _G.RXT_ExecuteCommand then
				_G.RXT_ExecuteCommand(cmdName, args)
			end
		end)
		
		yOffset = yOffset + buttonHeight + spacing
	end
	
	ScreenGui.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset + 10)
end

createCommandButtons()

-- ============================================
-- AUTOCOMPLETE FUNCTION
-- ============================================

function _G.RXT_UpdateAutocomplete(input)
	for _, child in ipairs(autocompleteList:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
	
	if #input == 0 then
		autocompleteFrame.Visible = false
		return
	end
	
	local commands = _G.RXT_Commands or {}
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
			if _G.RXT_ExecuteCommand then
				_G.RXT_ExecuteCommand(cmdName, args)
			end
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
-- AUTOCOMPLETE - DETECTA DIGITAÇÃO
-- ============================================

ScreenGui.CMDBOX:GetPropertyChangedSignal("Text"):Connect(function()
	local text = ScreenGui.CMDBOX.Text
	_G.RXT_UpdateAutocomplete(text)
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
		
		if string.sub(cmd, 1, 1) == _G.RXT_Config.Prefix then
			cmd = string.sub(cmd, 2)
		end
		
		if _G.RXT_ExecuteCommand then
			_G.RXT_ExecuteCommand(cmd, args)
		end
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
	
	if string.sub(cmd, 1, 1) == _G.RXT_Config.Prefix then
		cmd = string.sub(cmd, 2)
		if _G.RXT_ExecuteCommand then
			_G.RXT_ExecuteCommand(cmd, args)
		end
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
			_G.RXT_ShowPopup("Erro no script: " .. err)
		else
			_G.RXT_ShowPopup("Script executado!")
		end
	end
end)

executorClear.MouseButton1Click:Connect(function()
	executorTextBox.Text = ""
end)

executorClose.MouseButton1Click:Connect(function()
	executorFrame.Visible = false
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
	_G.RXT_AnimateCmdsList(false)
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
		local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		ScreenGui.CmdsLIST.Position = newPos
		savedPosition = newPos
	end
end)

-- ============================================
-- LIMPAR TUDO QUANDO RESPAWNA
-- ============================================

player.CharacterAdded:Connect(function()
	if _G.RXT_State then
		local state = _G.RXT_State
		if state.flyActive then
			if _G.RXT_ExecuteCommand then
				_G.RXT_ExecuteCommand("unfly", {})
			end
		end
		if state.noclipActive then
			if _G.RXT_ExecuteCommand then
				_G.RXT_ExecuteCommand("clip", {})
			end
		end
		if state.infJumpActive then
			if _G.RXT_ExecuteCommand then
				_G.RXT_ExecuteCommand("uninfjump", {})
			end
		end
		if state.viewActive then
			if _G.RXT_ExecuteCommand then
				_G.RXT_ExecuteCommand("unview", {})
			end
		end
		if state.tpToolActive then
			if _G.RXT_ExecuteCommand then
				_G.RXT_ExecuteCommand("untptool", {})
			end
		end
		if state.espActive then
			if _G.RXT_ExecuteCommand then
				_G.RXT_ExecuteCommand("unesp", {})
			end
		end
		if state.walkflingActive then
			if _G.RXT_ExecuteCommand then
				_G.RXT_ExecuteCommand("unwalkfling", {})
			end
		end
		if state.floatActive then
			if _G.RXT_ExecuteCommand then
				_G.RXT_ExecuteCommand("unfloat", {})
			end
		end
	end
end)

print("✅ RXT ADMIN carregado!")
print("💡 Comandos carregados: " .. (#(_G.RXT_Commands or {}) or 0))
