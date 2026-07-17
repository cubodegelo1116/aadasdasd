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
-- CmdsLIST (COM ANIMAÇÃO CORRIGIDA)
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

local function animateCmdsList(show)
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
			list.BackgroundTransparency = i / 15
			list.Size = UDim2.new(0, CMDSLIST_ORIGINAL_SIZE.X.Offset * (1 - i / 15), 0, CMDSLIST_ORIGINAL_SIZE.Y.Offset * (1 - i / 15))
			list.Position = UDim2.new(currentPos.X.Scale, currentPos.X.Offset, currentPos.Y.Scale + (0.15 * (i / 15)), currentPos.Y.Offset)
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
-- CARREGA O ARQUIVO DE COMANDOS
-- ============================================

require(script.Parent:WaitForChild("commands"))
