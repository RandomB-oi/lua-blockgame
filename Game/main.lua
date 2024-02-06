local module = {}

module.Start = function()
    local newBox = Class.new("Box")
    Class.GetComponent(newBox, "BoxRenderer").Color = Color4.new(1,1,1)
    newBox.CFrame = CFrame.new(50,50)
    newBox.Size = Vector2.new(50, 50)
    
    local upBox = Class.new("Box")
    Class.GetComponent(upBox, "BoxRenderer").Color = Color4.new(0,1,0)
    upBox.Size = Vector2.new(25, 25)
    
    local rightBox = Class.new("Box")
    Class.GetComponent(rightBox, "BoxRenderer").Color = Color4.new(1,0,0)
    rightBox.Size = Vector2.new(25, 25)
    
    local uis = GetService("UserInputService")
    local run = GetService("RunService")
    
    run.Update:Connect(function(dt)
        local mx,my = love.mouse.getPosition()
        -- newBox.CFrame = CFrame.new(mx, my, os.clock())
        if uis:IsKeyDown(Enum.KeyCode.A) then
            newBox.CFrame.X = newBox.CFrame.X - 100 * dt
        end
        if uis:IsKeyDown(Enum.KeyCode.D) then
            newBox.CFrame.X = newBox.CFrame.X + 100 * dt
        end
        
        if uis:IsKeyDown(Enum.KeyCode.W) then
            newBox.CFrame.Y = newBox.CFrame.Y - 100 * dt
        end
        if uis:IsKeyDown(Enum.KeyCode.S) then
            newBox.CFrame.Y = newBox.CFrame.Y + 100 * dt
        end

        newBox.CFrame = CFrame.LookAt(Vector2.new(newBox.CFrame.X, newBox.CFrame.Y), Vector2.new(mx, my))
        
        upBox.CFrame = newBox.CFrame * CFrame.new(0, 50)
        rightBox.CFrame = newBox.CFrame * CFrame.new(50, 0)
    end)
    
    -- uis.InputBegan:Connect(function(input, gp)
    --     if input.UserInputType == Enum.UserInputType.MouseButton1 then
    --     end
    --     if input.KeyCode == Enum.KeyCode.W then
    --     end
    -- end)
end

return module