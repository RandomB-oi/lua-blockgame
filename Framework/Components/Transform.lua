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
        parentSize = Vector2.new(1, 1)
    end

    local cf = parentCF * self.CFrame
    local size = self.Size

    self.RenderCFrame = cf
    self.RenderSize = size

    return self.RenderCFrame, self.RenderSize
end

function module:GetRelativePosition(point)
    return (-self.RenderCFrame) * point --- Vector2.new(self.RenderCFrame.X/2, self.RenderCFrame.Y/2)
end

Class.RegisterComponent("Transform", module)

return module