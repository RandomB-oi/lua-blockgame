local module = {}
module.__index = module
module.__derives = "Component"

function module.new(self)
	local run = GetService("RunService")

    self.CFrame = CFrame.new(0, 0, 0)
    self.Size = Vector2.new(1, 1)

    self.Maid:GiveTask(run.Update:Connect(function()
        self:CalculateRenderInfo()
	end))

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
        parentSize = Vector2.new(100, 100)
    end

    local cf = parentCF * self.CFrame
    local size = parentSize * self.Size

    self.RenderCFrame = cf
    self.RenderSize = size

    return self.RenderCFrame, self.RenderSize
end

function module:GetRelativePosition(point)
    return -self.RenderCFrame * point
end

Class.RegisterComponent("Transform", module)

return module