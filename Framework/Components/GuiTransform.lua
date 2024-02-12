local module = {}
module.__index = module
module.__derives = "Transform"

function module.new(self)
	local run = game:GetService("RunService")

    self.CFrame = nil
    self.Size = nil

    self.Size = UDim2.new(0, 100, 0, 100)
    self.Position = UDim2.new(0, 0, 0, 0)
    self.AnchorPoint = Vector2.new(0, 0)
    self.Rotation = 0

	return self
end

function module:CalculateRenderInfo()
    local parentCF, parentSize
    if self.Object.Parent then
        local parentTransform = self.Object.Parent:GetTransform()
        parentCF, parentSize = parentTransform.RenderCFrame, parentTransform.RenderSize --parentTransform:CalculateRenderInfo()
        if not (parentCF and parentSize) then return end
    else
        parentCF = CFrame.new(0, 0, 0)
        local w, h = love.graphics.getDimensions()
        parentSize = Vector2.new(w, h) -- screen size, but im too lazy to make it get the window size
    end

    local size = self.Size:Calculate(parentSize)
	local cf = (parentCF * (self.Position:Calculate(parentSize))) * CFrame.Angle(math.rad(self.Rotation)) * (size * (-self.AnchorPoint))

    self.RenderCFrame = cf
    self.RenderSize = size

    return cf, size
end

Class.RegisterComponent("GuiTransform", module)

return module