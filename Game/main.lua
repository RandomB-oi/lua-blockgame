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
    

    local box = Class.new("Instance")
    -- box:AddTag("GuiTransform")
    -- box:AddTag("BoxRenderer")
    -- local boxTransform = box:GetTransform()
    -- boxTransform.Position = UDim2.new(0, 6, 0, 6)
    -- boxTransform.Size = UDim2.new(.5, -9, 1, -12)
    -- boxTransform.AnchorPoint = Vector2.new(0, 0)

    -- local box2 = Class.new("Instance")
    -- box2:AddTag("GuiTransform")
    -- box2:AddTag("BoxRenderer")
    -- local box2Transform = box2:GetTransform()
    -- box2Transform.Position = UDim2.new(1, -6, 0, 6)
    -- box2Transform.Size = UDim2.new(.5, -9, 1, -12)
    -- box2Transform.AnchorPoint = Vector2.new(1, 0)

    -- local topBar = Class.new("Instance")
    -- topBar:AddTag("GuiTransform")
    -- topBar:AddTag("BoxRenderer")

    -- local rendererComponent = Class.GetComponent(topBar, "BoxRenderer")
    -- rendererComponent.Color = Color4.new(1,0,0,0.5)

    -- local topbarTransform = topBar:GetTransform()
    -- topbarTransform.Position = UDim2.new(0.5, 0, 0.5, 0)
    -- topbarTransform.Size = UDim2.new(.4, -12, 0.2, 0)
    -- topbarTransform.AnchorPoint = Vector2.new(0.5, 0)
    -- topbarTransform.Rotation = 45

    -- box:SetParent(topBar)
    -- box2:SetParent(topBar)

    local part = Class.new("Instance")
    part:AddTag("Transform")
    part:AddTag("BoxRenderer")
    part:AddTag("Button")
    part:GetComponent("BoxRenderer").Color = Color4.new(1,1,1,0.5)
    local partTransform = part:GetTransform()
    partTransform.CFrame = CFrame.new(400, 300)
    partTransform.Size = Vector2.new(150, 100)

    local part2 = Class.new("Instance")
    part2:AddTag("Transform")
    part2:AddTag("BoxRenderer")
    part2:GetComponent("BoxRenderer").Color = Color4.new(1,1,1,0.5)
    part2:SetParent(part)

    local part2Transform = part2:GetTransform()
    part2Transform.CFrame = CFrame.new(25, 25)
    part2Transform.Size = Vector2.new(20, 20)
    

    -- local emitter = Class.new("ParticleEmitter")
    -- local emitterTransform = emitter:GetTransform()

    run.Draw:Connect(function()
        local mx,my = love.mouse.getPosition()

        local relativePos = partTransform.CFrame * partTransform:GetRelativePosition(Vector2.new(mx,my))
        love.graphics.setColor(255,255,255,150)
        love.graphics.circle("fill", relativePos.X, relativePos.Y, 10)
        
        love.graphics.circle("fill", mx, my, 3)
        -- emitterTransform.CFrame = CFrame.new(mx, my)
    end)

    uis.InputBegan:Connect(function(input, gp)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then

            local mx,my = love.mouse.getPosition()

            local new = Class.new("Instance")
            new:AddTag("Transform")
            local transform = new:GetComponent("Transform")
            transform.Size = Vector2.new(20, 10)
            transform.CFrame = CFrame.LookAt(Vector2.new(400, 300), Vector2.new(mx, my))

            new:SetAttribute("ProjectileSpeed", 100)
            new:AddTag("Projectile")
            new:AddTag("BoxRenderer")
            -- new.CFrame = CFrame.new(0, 0, 0)
        end
        if input.KeyCode == Enum.KeyCode.W then
        end
    end)
end

return module