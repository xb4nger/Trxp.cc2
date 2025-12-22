function utility:DraggingEnabled(frame,parent)
	parent=parent or frame
	local dragging=false
	local dragInput
	local startPos
	local startFramePos
	frame.InputBegan:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
			dragging=true
			startPos=input.Position
			startFramePos=parent.Position
			input.Changed:Connect(function()
				if input.UserInputState==Enum.UserInputState.End then
					dragging=false
				end
			end)
		end
	end)
	frame.InputChanged:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then
			dragInput=input
		end
	end)
	input.InputChanged:Connect(function(input)
		if input==dragInput and dragging then
			local delta=input.Position-startPos
			parent.Position=UDim2.new(
				startFramePos.X.Scale,
				startFramePos.X.Offset+delta.X,
				startFramePos.Y.Scale,
				startFramePos.Y.Offset+delta.Y
			)
		end
	end)
end
