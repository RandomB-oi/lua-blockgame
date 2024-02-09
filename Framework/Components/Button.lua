local module = {}
module.__index = module
module.__derives = "Component"

function module.new(self)
	local run = GetService("RunService")
	local uis = GetService("UserInputService")

    self.Activated = Class.new("Signal")
    self.Deactivated = Class.new("Signal")

	self.Maid:GiveTask(run.Update:Connect(function()
        local renderer = self.Object:GetComponent("Renderer")
        if not renderer then return end

        local hovering = self:IsHovering()
        renderer.Highlighted = hovering
        renderer.Clicked = uis:IsMouseButtonDown(Enum.UserInputType.MouseButton1)
	end))

    self.Maid:GiveTask(uis.GUIInputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if self:IsHovering() then
                uis.GameProcessed:Fire()
                self._clicked = true
                self.Activated:Fire()
            end
        end
    end))
    self.Maid:GiveTask(uis.GUIInputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if self._clicked then
                self._clicked = nil
                uis.GameProcessed:Fire()
                self.Deactivated:Fire()
            end
        end
    end))

	return self
end

function module:IsHovering()
    local transform = self.Object:GetTransform()
    local mx, my = love.mouse.getPosition()

    local cf, size = transform.RenderCFrame, transform.RenderSize
    cf = cf * (-size/2)

    return
        mx > cf.X and
        my > cf.Y and
        mx < cf.X + size.X and
        my < cf.Y + size.Y
end

Class.RegisterComponent("Button", module)

return module