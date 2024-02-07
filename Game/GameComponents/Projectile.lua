local module = {}
module.__index = module
module.__derives = "Component"

function module.new(self)
	local run = GetService("RunService")

    local lifeTime = 0

    self.Maid:GiveTask(run.Update:Connect(function(dt)
        lifeTime = lifeTime + dt
        if lifeTime > 10 then
            self.Object:Destroy()
            return
        end
        self.Object.CFrame = self.Object.CFrame * CFrame.new(self.Object:GetAttribute("ProjectileSpeed") * dt, 0)
    end))
	return self
end

Class.RegisterComponent("Projectile", module)

return module