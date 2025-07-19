local module = {}
module.__index = module
module.__derives = "Component"

module.BlockSize = 50
module.RenderSize = 50

function module.new(self)
	local run = game:GetService("RunService")

    local collider = self.Object:GetComponent("Collider")
    if collider then
        collider.Size.X = module.BlockSize
        collider.Size.Y = module.BlockSize
    end

    self.X = 0
    self.Y = 0

    self.Maid:GiveTask(run.Update:Connect(function(dt)
        local transform = self.Object:GetTransform()

        transform.CFrame.X = self.X * self.BlockSize
        transform.CFrame.Y = self.Y * self.BlockSize
        transform.CFrame.R = 0

        transform.Size.X = self.RenderSize
        transform.Size.Y = self.RenderSize
    end))
	return self
end

Class.RegisterComponent("BlockComponent", module)

return module