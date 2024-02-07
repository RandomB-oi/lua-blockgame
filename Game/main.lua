local module = {}

module.Start = function()
    -- local newBox = Class.new("Box")
    -- Class.GetComponent(newBox, "BoxRenderer").Color = Color4.new(1,1,1)
    -- newBox.CFrame = CFrame.new(50,50)
    -- newBox.Size = Vector2.new(50, 50)
    
    -- local upBox = Class.new("Box")
    -- Class.GetComponent(upBox, "BoxRenderer").Color = Color4.new(0,1,0)
    -- upBox.Size = Vector2.new(25, 25)
    
    -- local rightBox = Class.new("Box")
    -- Class.GetComponent(rightBox, "BoxRenderer").Color = Color4.new(1,0,0)
    -- rightBox.Size = Vector2.new(25, 25)
    
    local uis = GetService("UserInputService")
    local run = GetService("RunService")
    
    -- run.Update:Connect(function(dt)
    --     local mx,my = love.mouse.getPosition()
    --     -- newBox.CFrame = CFrame.new(mx, my, os.clock())
    --     if uis:IsKeyDown(Enum.KeyCode.A) then
    --         newBox.CFrame.X = newBox.CFrame.X - 100 * dt
    --     end
    --     if uis:IsKeyDown(Enum.KeyCode.D) then
    --         newBox.CFrame.X = newBox.CFrame.X + 100 * dt
    --     end
        
    --     if uis:IsKeyDown(Enum.KeyCode.W) then
    --         newBox.CFrame.Y = newBox.CFrame.Y - 100 * dt
    --     end
    --     if uis:IsKeyDown(Enum.KeyCode.S) then
    --         newBox.CFrame.Y = newBox.CFrame.Y + 100 * dt
    --     end

    --     newBox.CFrame = CFrame.LookAt(Vector2.new(newBox.CFrame.X, newBox.CFrame.Y), Vector2.new(mx, my))
        
    --     upBox.CFrame = newBox.CFrame * CFrame.new(0, 50)
    --     rightBox.CFrame = newBox.CFrame * CFrame.new(50, 0)
    -- end)
    

    local box = Class.new("GuiInstance")
    box:AddTag("GuiRenderer")
    box.Position = UDim2.new(0, 6, 0, 6)
    box.Size = UDim2.new(.5, -6, 1, -12)
    box.AnchorPoint = Vector2.new(0, 0)

    local topBar = Class.new("GuiInstance")
    topBar:AddTag("GuiRenderer")
    local rendererComponent = Class.GetComponent(topBar, "GuiRenderer")
    rendererComponent.Color = Color4.new(1,0,0,0.5)
    topBar.Position = UDim2.new(0.5, 0, 0, 6)
    topBar.Size = UDim2.new(1, -12, 0.2, -6)
    topBar.AnchorPoint = Vector2.new(0.5, 0)

    box.Parent = topBar
    -- box:SetParent(topBar)

    uis.InputBegan:Connect(function(input, gp)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then

            local mx,my = love.mouse.getPosition()

            for i = 1, 10 do
                local new = Class.new("Box")
                new.Size = Vector2.new(20, 10)
                new:SetAttribute("ProjectileSpeed", 100)
                new:AddTag("Projectile")
                new:AddTag("BoxRenderer")
                -- new.CFrame = CFrame.new(0, 0, 0)
                new.CFrame = CFrame.LookAt(Vector2.new(400, 300), Vector2.new(mx, my)) * CFrame.new(0, -100 + i * 20, 0)
            end
        end
        if input.KeyCode == Enum.KeyCode.W then
        end
    end)
end

return module