local module = {}
module.__index = module
module.__derives = "Instance"

module.new = function(self)
    self.Size = UDim2.new(0, 100, 0, 100)
    self.Position = UDim2.new(0, 0, 0, 0)
    self.AnchorPoint = Vector2.new(0, 0)
    self.Rotation = 0

    return self
end

function module:CalculateRenderInfo()
    local parentPos, parentSize, parentRotation
    if self.Parent then
        parentPos, parentSize, parentRotation = self.Parent:CalculateRenderInfo()
    else
        parentPos = Vector2.new(0, 0)
        parentSize = Vector2.new(800, 600) -- screen size, but im too lazy to make it get the window size
        parentRotation = 0
    end

    local size = self.Size:Calculate(parentSize)
	local position = parentPos + self.Position:Calculate(parentSize) - size * self.AnchorPoint
    local rot = parentRotation + self.Rotation

    return position, size, rot
end

Class.RegisterClass("GuiInstance", module)

return module