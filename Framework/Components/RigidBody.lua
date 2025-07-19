local module = {}
module.__index = module
module.__derives = "Component"

module.Gravity = Vector2.new(0, 500)

function module.new(self)
    self.Object:AddTag("Collider")
    local selfCollider = self.Object:GetComponent("Collider")
    local selfTransform = self.Object:GetTransform()
    if selfTransform:IsA("GuiTransform") then
        return
    end
    
    self.Velocity = Vector2.new(0, 0)
    self.Friction = Vector2.new(0, 0)
    self.GravityEnabled = true
    self.Enabled = true

    local run = game:GetService("RunService")
    local lastUpdate = os.clock()
    local physicsFPS = 60

    self.Maid:GiveTask(run.Update:Connect(function(bigDT)
        local t = os.clock()
        local timeDiff = t - lastUpdate
        local updateAmount = timeDiff * physicsFPS
        lastUpdate = t
        if not self.Enabled then return end
        if not selfCollider then
            -- selfCollider = self.Object:GetComponent("Collider")
            return
        end
        
        local smoothing = math.clamp(updateAmount, 1, physicsFPS)
        local dt = bigDT/smoothing

        -- local smoothing = 1
        -- local dt = bigDT
        
        for i = 1, smoothing do
            if self.GravityEnabled then
                self.Velocity = self.Velocity + self.Gravity * dt
            end
            local canX = true
            local canY = true
            
            local addX = Vector2.new(self.Velocity.X * dt, 0)
            local addY = Vector2.new(0, self.Velocity.Y * dt)

            local xFriction = 0
            local yFriction = 0

            for object, component in pairs(Class.GetClass("Collider").Objects) do
                if object ~= self.Object then
                    if canX and selfCollider:CollidingWith(component, selfTransform.CFrame + addX) then
                        self.Velocity.X = 0
                        canX = false
                        yFriction = math.max(yFriction, component.Friction)
                    end

                    if canY and selfCollider:CollidingWith(component, selfTransform.CFrame + addY) then
                        self.Velocity.Y = 0
                        canY = false
                        xFriction = math.max(xFriction, component.Friction)
                    end
                end
            end

            self.Friction.X = xFriction
            self.Friction.Y = yFriction

            if canX then
                selfTransform.CFrame.X = selfTransform.CFrame.X + addX.X
                if not canY then
                    self.Velocity.X = self.Velocity.X - self.Velocity.X * ((xFriction + selfCollider.Friction)*0.5)
                end
            end
            if canY then
                selfTransform.CFrame.Y = selfTransform.CFrame.Y + addY.Y
                -- if not canX then
                --     self.Velocity.Y = self.Velocity.Y - self.Velocity.Y * ((yFriction + selfCollider.Friction)*0.5)
                -- end
            end
        end
    end))

	return self
end

Class.RegisterComponent("RigidBody", module)

return module