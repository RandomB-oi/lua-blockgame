local module = {}
module.__index = module
module.__derives = "Component"

function module.new(self)
	local run = game:GetService("RunService")
	local uis = game:GetService("UserInputService")

    self.Object:AddTag("RigidBody")
    self.Object:AddTag("Collider")

    self.WalkSpeed = 150
    self.JumpPower = 250
    self.Acceleration = 25

    self.Maid:GiveTask(run.Update:Connect(function(dt)
        local transform = self.Object:GetTransform()
        local rigidBody = Class.GetComponent(self.Object, "RigidBody")
        
        local speedToApply = self.WalkSpeed
        
        if rigidBody.Friction.X == 0 then
            speedToApply = speedToApply / 10
        end

        local moveDir = 0

        if uis:IsKeyDown(Enum.KeyCode.A) then
            moveDir = -1
        elseif uis:IsKeyDown(Enum.KeyCode.D) then
            moveDir = 1
        end

        if moveDir ~= 0 then
            local min = 0
            local max = speedToApply * moveDir - rigidBody.Velocity.X
            rigidBody.Velocity.X = rigidBody.Velocity.X + math.clamp(speedToApply * moveDir * dt * self.Acceleration, math.min(min, max), math.max(min, max))
        end

        local cam = game.Camera
        local camTran = cam:GetTransform()
        camTran.CFrame = CFrame.new(-transform.CFrame.X + camTran.Size.X, -transform.CFrame.Y + camTran.Size.Y)
        -- camTran.CFrame = CFrame.new(transform.CFrame.X + camTran.Size.X, transform.CFrame.Y + camTran.Size.Y)
    end))
    self.Maid:GiveTask(uis.InputBegan:Connect(function(input, gp)
        local rigidBody = Class.GetComponent(self.Object, "RigidBody")
        if input.KeyCode == Enum.KeyCode.Space and math.abs(rigidBody.Velocity.Y) <= 0.1 then
            print("JUMP")
            rigidBody.Velocity = rigidBody.Velocity + Vector2.new(0, -self.JumpPower)
        end
    end))

	return self
end

Class.RegisterComponent("PlayerController", module)

return module