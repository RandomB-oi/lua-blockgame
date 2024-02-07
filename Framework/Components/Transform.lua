local module = {}
module.__index = module
module.__derives = "Component"

function module.new(self)
	local run = GetService("RunService")

    self.CFrame = CFrame.new(0, 0, 0)
    self.Size = Vector2.new(100, 100)

    self.Maid:GiveTask(run.Update:Connect(function()
        self:CalculateRenderInfo()
	end))

	return self
end

function module:CalculateRenderInfo()
    self.RenderPosition = Vector2.new(self.CFrame.X, self.CFrame.Y)
    self.RenderSize = self.Size
    self.RenderRotation = self.CFrame.R

    return self.RenderPosition, self.RenderSize, self.RenderRotation
end

Class.RegisterComponent("Transform", module)

return module