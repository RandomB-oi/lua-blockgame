local module = {}
module.__index = module
module.__derives = "Component"

function module.new(self)
	local run = GetService("RunService")

    self.Size = UDim2.new(0, 100, 0, 100)
    self.Position = UDim2.new(0, 0, 0, 0)
    self.AnchorPoint = Vector2.new(0, 0)
    self.Rotation = 0

	self.Maid:GiveTask(run.Update:Connect(function()
        self:CalculateRenderInfo()
	end))

	return self
end

function module:CalculateRenderInfo()
    local parentPos, parentSize, parentRotation
    if self.Object.Parent then
        local parentTransform = self.Object.Parent:GetTransform()
        parentPos, parentSize, parentRotation = parentTransform:CalculateRenderInfo()
    else
        parentPos = Vector2.new(0, 0)
        parentSize = Vector2.new(800, 600) -- screen size, but im too lazy to make it get the window size
        parentRotation = 0
    end

    local size = self.Size:Calculate(parentSize)
	local position = parentPos + self.Position:Calculate(parentSize) - size * self.AnchorPoint-- + size/2
    local rot = parentRotation + self.Rotation

    self.RenderPosition = position
    self.RenderSize = size
    self.RenderRotation = rot

    return position, size, rot
end

Class.RegisterComponent("GuiTransform", module)

return module