-- ============================================
-- RXT ADMIN - INTERFACES
-- ============================================

local ScreenGui = _G.RXT_GUI
if not ScreenGui then
	warn("RXT: GUI não encontrada!")
	return
end

-- ============================================
-- EXECUTOR
-- ============================================

local executorFrame = Instance.new("Frame")
executorFrame.Name = "ExecutorFrame"
executorFrame.Parent = ScreenGui.ScreenGui
executorFrame.Size = UDim2.new(0, 382, 0, 299)
executorFrame.Position = UDim2.new(0.311619729, 0, 0.246329531, 0)
executorFrame.BackgroundColor3 = Color3.fromRGB(227,227,227)
executorFrame.BackgroundTransparency = 0
executorFrame.BorderColor3 = Color3.fromRGB(185,185,185)
executorFrame.BorderSizePixel = 3
executorFrame.Visible = false
executorFrame.ZIndex = 10
executorFrame.ClipsDescendants = false

local executorDragbar = Instance.new("Frame")
executorDragbar.Name = "DRAGBAR"
executorDragbar.Parent = executorFrame
executorDragbar.Size = UDim2.new(0, 382, 0, 29)
executorDragbar.Position = UDim2.new(0, 0, 0, 0)
executorDragbar.BackgroundColor3 = Color3.fromRGB(227,227,227)
executorDragbar.BackgroundTransparency = 0
executorDragbar.BorderColor3 = Color3.fromRGB(185,185,185)
executorDragbar.BorderSizePixel = 3
executorDragbar.ZIndex = 11

local executorClose = Instance.new("TextButton")
executorClose.Name = "CloseButton"
executorClose.Parent = executorDragbar
executorClose.Size = UDim2.new(0, 22, 0, 22)
executorClose.Position = UDim2.new(0.931999981, 0, 0.0799999982, 0)
executorClose.BackgroundColor3 = Color3.fromRGB(177,0,0)
executorClose.BackgroundTransparency = 0
executorClose.BorderSizePixel = 0
executorClose.Text = ""
executorClose.TextColor3 = Color3.fromRGB(0,0,0)
executorClose.TextSize = 14
executorClose.Font = Enum.Font.SourceSans
executorClose.ZIndex = 11

local executorTitle = Instance.new("TextLabel")
executorTitle.Name = "TextLabel"
executorTitle.Parent = executorDragbar
executorTitle.Size = UDim2.new(0, 115, 0, 29)
executorTitle.Position = UDim2.new(0.0185540486, 0, -0.068965517, 0)
executorTitle.BackgroundTransparency = 1
executorTitle.Text = "Executor"
executorTitle.TextColor3 = Color3.fromRGB(0,0,0)
executorTitle.TextSize = 30
executorTitle.Font = Enum.Font.SourceSans
executorTitle.TextXAlignment = Enum.TextXAlignment.Left
executorTitle.TextYAlignment = Enum.TextYAlignment.Center
executorTitle.ZIndex = 11

local executorTextBox = Instance.new("TextBox")
executorTextBox.Name = "TextBox"
executorTextBox.Parent = executorFrame
executorTextBox.Size = UDim2.new(0, 365, 0, 195)
executorTextBox.Position = UDim2.new(0.018324608, 0, 0.133779258, 0)
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
executorTextBox.ClearTextOnFocus = true
executorTextBox.MultiLine = true
executorTextBox.PlaceholderText = "Digite o script aqui..."
executorTextBox.ZIndex = 11

local executorExecute = Instance.new("TextButton")
executorExecute.Name = "ExecuteButton"
executorExecute.Parent = executorFrame
executorExecute.Size = UDim2.new(0, 159, 0, 47)
executorExecute.Position = UDim2.new(0.0183873996, 0, 0.819130361, 0)
executorExecute.BackgroundColor3 = Color3.fromRGB(227,227,227)
executorExecute.BackgroundTransparency = 0
executorExecute.BorderColor3 = Color3.fromRGB(185,185,185)
executorExecute.BorderSizePixel = 3
executorExecute.Text = "Execute"
executorExecute.TextColor3 = Color3.fromRGB(0,0,0)
executorExecute.TextSize = 46
executorExecute.Font = Enum.Font.SourceSans
executorExecute.ZIndex = 11

local executorClear = Instance.new("TextButton")
executorClear.Name = "Clearbutton"
executorClear.Parent = executorFrame
executorClear.Size = UDim2.new(0, 159, 0, 47)
executorClear.Position = UDim2.new(0.555036604, 0, 0.819130361, 0)
executorClear.BackgroundColor3 = Color3.fromRGB(227,227,227)
executorClear.BackgroundTransparency = 0
executorClear.BorderColor3 = Color3.fromRGB(185,185,185)
executorClear.BorderSizePixel = 3
executorClear.Text = "Clear"
executorClear.TextColor3 = Color3.fromRGB(0,0,0)
executorClear.TextSize = 46
executorClear.Font = Enum.Font.SourceSans
executorClear.ZIndex = 11

_G.RXT_ExecutorFrame = executorFrame
_G.RXT_ExecutorTextBox = executorTextBox

-- ============================================
-- EXECUTOR - DRAG
-- ============================================

local execDragging = false
local execDragStart, execStartPos

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

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if execDragging then
		local delta = input.Position - execDragStart
		executorFrame.Position = UDim2.new(execStartPos.X.Scale, execStartPos.X.Offset + delta.X, execStartPos.Y.Scale, execStartPos.Y.Offset + delta.Y)
	end
end)

executorClose.MouseButton1Click:Connect(function()
	executorFrame.Visible = false
end)

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

print("✅ Interfaces carregadas!")
