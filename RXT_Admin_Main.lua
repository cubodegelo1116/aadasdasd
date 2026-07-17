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
-- CONFIGURAÇÕES GLOBAIS
-- ============================================

_G.RXT_Config = {
	Prefix = "/",
	Popups = true,
}

_G.RXT_ScreenGui = {
	ScreenGui = Instance.new("ScreenGui"),
	ComandtxtFrame = Instance.new("Frame"),
	CMDBOX = Instance.new("TextBox"),
	CmdsLIST = Instance.new("Frame"),
	Dragbar = Instance.new("Frame"),
	CloseButton = Instance.new("TextButton"),
	TextLabel = Instance.new("TextLabel"),
	ScrollingFrame = Instance.new("ScrollingFrame"),
}

_G.RXT_ScreenGui.ScreenGui.Parent = playerGui
_G.RXT_ScreenGui.ScreenGui.Name = "RXT_Admin_GUI"
_G.RXT_ScreenGui.ScreenGui.ResetOnSpawn = false

_G.RXT_ScreenGui.ComandtxtFrame.Parent = _G.RXT_ScreenGui.ScreenGui
_G.RXT_ScreenGui.CMDBOX.Parent = _G.RXT_ScreenGui.ComandtxtFrame
_G.RXT_ScreenGui.CmdsLIST.Parent = _G.RXT_ScreenGui.ScreenGui
_G.RXT_ScreenGui.Dragbar.Parent = _G.RXT_ScreenGui.CmdsLIST
_G.RXT_ScreenGui.CloseButton.Parent = _G.RXT_ScreenGui.Dragbar
_G.RXT_ScreenGui.TextLabel.Parent = _G.RXT_ScreenGui.Dragbar
_G.RXT_ScreenGui.ScrollingFrame.Parent = _G.RXT_ScreenGui.CmdsLIST

_G.RXT_ScreenGui.ScreenGui.IgnoreGuiInset = false
_G.RXT_ScreenGui.ScreenGui.DisplayOrder = 0

-- ============================================
-- CMDBOX
-- ============================================

_G.RXT_ScreenGui.ComandtxtFrame.Name = "ComandtxtFrame"
_G.RXT_ScreenGui.ComandtxtFrame.ZIndex = 1
_G.RXT_ScreenGui.ComandtxtFrame.Position = UDim2.new(1, -230, 1, -40)
_G.RXT_ScreenGui.ComandtxtFrame.Size = UDim2.new(0, 218, 0, 25)
_G.RXT_ScreenGui.ComandtxtFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
_G.RXT_ScreenGui.ComandtxtFrame.BackgroundTransparency = 1
_G.RXT_ScreenGui.ComandtxtFrame.Visible = true
_G.RXT_ScreenGui.ComandtxtFrame.AnchorPoint = Vector2.new(0, 0)
_G.RXT_ScreenGui.ComandtxtFrame.ClipsDescendants = false
_G.RXT_ScreenGui.ComandtxtFrame.BorderSizePixel = 0

_G.RXT_ScreenGui.CMDBOX.Name = "CMDBOX"
_G.RXT_ScreenGui.CMDBOX.ZIndex = 1
_G.RXT_ScreenGui.CMDBOX.Position = UDim2.new(0, 0, 0, 0)
_G.RXT_ScreenGui.CMDBOX.Size = UDim2.new(0, 218, 0, 25)
_G.RXT_ScreenGui.CMDBOX.BackgroundColor3 = Color3.fromRGB(227,227,227)
_G.RXT_ScreenGui.CMDBOX.BackgroundTransparency = 0
_G.RXT_ScreenGui.CMDBOX.Text = ""
_G.RXT_ScreenGui.CMDBOX.TextScaled = false
_G.RXT_ScreenGui.CMDBOX.TextSize = 14
_G.RXT_ScreenGui.CMDBOX.Font = Enum.Font.SourceSans
_G.RXT_ScreenGui.CMDBOX.TextColor3 = Color3.fromRGB(0,0,0)
_G.RXT_ScreenGui.CMDBOX.TextStrokeColor3 = Color3.fromRGB(0,0,0)
_G.RXT_ScreenGui.CMDBOX.TextStrokeTransparency = 1
_G.RXT_ScreenGui.CMDBOX.TextWrapped = false
_G.RXT_ScreenGui.CMDBOX.TextXAlignment = Enum.TextXAlignment.Center
_G.RXT_ScreenGui.CMDBOX.TextYAlignment = Enum.TextYAlignment.Center
_G.RXT_ScreenGui.CMDBOX.TextTransparency = 0
_G.RXT_ScreenGui.CMDBOX.ClearTextOnFocus = true
_G.RXT_ScreenGui.CMDBOX.MultiLine = false
_G.RXT_ScreenGui.CMDBOX.Visible = true
_G.RXT_ScreenGui.CMDBOX.AnchorPoint = Vector2.new(0, 0)
_G.RXT_ScreenGui.CMDBOX.ClipsDescendants = false
_G.RXT_ScreenGui.CMDBOX.PlaceholderText = "digite 'cmds' para ver os comandos"
_G.RXT_ScreenGui.CMDBOX.BorderColor3 = Color3.fromRGB(185,185,185)
_G.RXT_ScreenGui.CMDBOX.BorderSizePixel = 3

-- ============================================
-- AUTOCOMPLETE
-- ============================================

local autocompleteFrame = Instance.new("Frame")
autocompleteFrame.Name = "AutocompleteFrame"
autocompleteFrame.Parent = _G.RXT_ScreenGui.ScreenGui
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
executorFrame.Parent = _G.RXT_ScreenGui.ScreenGui
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
	local cmbbox = _G.RXT_ScreenGui.CMDBOX
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

_G.RXT_ScreenGui.CmdsLIST.Name = "CmdsLIST"
_G.RXT_ScreenGui.CmdsLIST.ZIndex = 1
_G.RXT_ScreenGui.CmdsLIST.Position = CMDSLIST_ORIGINAL_POS
_G.RXT_ScreenGui.CmdsLIST.Size = CMDSLIST_ORIGINAL_SIZE
_G.RXT_ScreenGui.CmdsLIST.BackgroundColor3 = Color3.fromRGB(227,227,227)
_G.RXT_ScreenGui.CmdsLIST.BackgroundTransparency = 0
_G.RXT_ScreenGui.CmdsLIST.Visible = false
_G.RXT_ScreenGui.CmdsLIST.AnchorPoint = Vector2.new(0, 0)
_G.RXT_ScreenGui.CmdsLIST.ClipsDescendants = false
_G.RXT_ScreenGui.CmdsLIST.BorderColor3 = Color3.fromRGB(185,185,185)
_G.RXT_ScreenGui.CmdsLIST.BorderSizePixel = 3

_G.RXT_ScreenGui.Dragbar.Name = "Dragbar"
_G.RXT_ScreenGui.Dragbar.ZIndex = 1
_G.RXT_ScreenGui.Dragbar.Position = UDim2.new(-0, 0, -0, 0)
_G.RXT_ScreenGui.Dragbar.Size = UDim2.new(0, 382, 0, 29)
_G.RXT_ScreenGui.Dragbar.BackgroundColor3 = Color3.fromRGB(227,227,227)
_G.RXT_ScreenGui.Dragbar.BackgroundTransparency = 0
_G.RXT_ScreenGui.Dragbar.Visible = true
_G.RXT_ScreenGui.Dragbar.AnchorPoint = Vector2.new(0, 0)
_G.RXT_ScreenGui.Dragbar.ClipsDescendants = false
_G.RXT_ScreenGui.Dragbar.BorderColor3 = Color3.fromRGB(185,185,185)
_G.RXT_ScreenGui.Dragbar.BorderSizePixel = 3

_G.RXT_ScreenGui.CloseButton.Name = "CloseButton"
_G.RXT_ScreenGui.CloseButton.ZIndex = 1
_G.RXT_ScreenGui.CloseButton.Position = UDim2.new(0.931999981, 0, 0.0799999982, 0)
_G.RXT_ScreenGui.CloseButton.Size = UDim2.new(0, 22, 0, 22)
_G.RXT_ScreenGui.CloseButton.BackgroundColor3 = Color3.fromRGB(177,0,0)
_G.RXT_ScreenGui.CloseButton.BackgroundTransparency = 0
_G.RXT_ScreenGui.CloseButton.Text = ""
_G.RXT_ScreenGui.CloseButton.TextScaled = false
_G.RXT_ScreenGui.CloseButton.TextSize = 14
_G.RXT_ScreenGui.CloseButton.Font = Enum.Font.SourceSans
_G.RXT_ScreenGui.CloseButton.TextColor3 = Color3.fromRGB(0,0,0)
_G.RXT_ScreenGui.CloseButton.TextStrokeColor3 = Color3.fromRGB(0,0,0)
_G.RXT_ScreenGui.CloseButton.TextStrokeTransparency = 1
_G.RXT_ScreenGui.CloseButton.TextWrapped = false
_G.RXT_ScreenGui.CloseButton.TextXAlignment = Enum.TextXAlignment.Center
_G.RXT_ScreenGui.CloseButton.TextYAlignment = Enum.TextYAlignment.Center
_G.RXT_ScreenGui.CloseButton.TextTransparency = 0
_G.RXT_ScreenGui.CloseButton.Visible = true
_G.RXT_ScreenGui.CloseButton.AnchorPoint = Vector2.new(0, 0)
_G.RXT_ScreenGui.CloseButton.ClipsDescendants = false
_G.RXT_ScreenGui.CloseButton.BorderSizePixel = 0

_G.RXT_ScreenGui.TextLabel.Name = "TextLabel"
_G.RXT_ScreenGui.TextLabel.ZIndex = 1
_G.RXT_ScreenGui.TextLabel.Position = UDim2.new(0.0185540486, 0, -0.068965517, 0)
_G.RXT_ScreenGui.TextLabel.Size = UDim2.new(0, 115, 0, 29)
_G.RXT_ScreenGui.TextLabel.BackgroundColor3 = Color3.fromRGB(255,255,255)
_G.RXT_ScreenGui.TextLabel.BackgroundTransparency = 1
_G.RXT_ScreenGui.TextLabel.Text = "RXT ADMIN"
_G.RXT_ScreenGui.TextLabel.TextScaled = false
_G.RXT_ScreenGui.TextLabel.TextSize = 30
_G.RXT_ScreenGui.TextLabel.Font = Enum.Font.SourceSans
_G.RXT_ScreenGui.TextLabel.TextColor3 = Color3.fromRGB(0,0,0)
_G.RXT_ScreenGui.TextLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0)
_G.RXT_ScreenGui.TextLabel.TextStrokeTransparency = 1
_G.RXT_ScreenGui.TextLabel.TextWrapped = false
_G.RXT_ScreenGui.TextLabel.TextXAlignment = Enum.TextXAlignment.Left
_G.RXT_ScreenGui.TextLabel.TextYAlignment = Enum.TextYAlignment.Center
_G.RXT_ScreenGui.TextLabel.TextTransparency = 0
_G.RXT_ScreenGui.TextLabel.Visible = true
_G.RXT_ScreenGui.TextLabel.AnchorPoint = Vector2.new(0, 0)
_G.RXT_ScreenGui.TextLabel.ClipsDescendants = false
_G.RXT_ScreenGui.TextLabel.BorderColor3 = Color3.fromRGB(185,185,185)
_G.RXT_ScreenGui.TextLabel.BorderSizePixel = 3

_G.RXT_ScreenGui.ScrollingFrame.Name = "ScrollingFrame"
_G.RXT_ScreenGui.ScrollingFrame.ZIndex = 1
_G.RXT_ScreenGui.ScrollingFrame.Position = UDim2.new(0, 0, 0.0969899669, 0)
_G.RXT_ScreenGui.ScrollingFrame.Size = UDim2.new(0, 381, 0, 270)
_G.RXT_ScreenGui.ScrollingFrame.BackgroundColor3 = Color3.fromRGB(227,227,227)
_G.RXT_ScreenGui.ScrollingFrame.BackgroundTransparency = 0
_G.RXT_ScreenGui.ScrollingFrame.Visible = true
_G.RXT_ScreenGui.ScrollingFrame.AnchorPoint = Vector2.new(0, 0)
_G.RXT_ScreenGui.ScrollingFrame.ClipsDescendants = true
_G.RXT_ScreenGui.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
_G.RXT_ScreenGui.ScrollingFrame.ScrollBarThickness = 12
_G.RXT_ScreenGui.ScrollingFrame.ScrollingEnabled = true
_G.RXT_ScreenGui.ScrollingFrame.BorderColor3 = Color3.fromRGB(185,185,185)
_G.RXT_ScreenGui.ScrollingFrame.BorderSizePixel = 3

-- ============================================
-- CARREGA O ARQUIVO DE COMANDOS VIA HttpGet
-- ============================================

loadstring(game:HttpGet("https://raw.githubusercontent.com/cubodegelo1116/aadasdasd/main/commands.lua"))()
