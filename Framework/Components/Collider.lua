local module = {}
module.__index = module
module.__derives = "Component"

function module.new(self) -- AABB, NO ROTATION
    self.Size = Vector2.new(100, 100)
    self.Offset = CFrame.new(0, 0)
    self.Friction = 0.5
    -- self.CollisionLayer = Enum.CollisionLayer.Default
    self.Enabled = true

    -- self.Maid.DebugDraw = game:GetService("RunService").Draw:Connect(function(dt)
    --     if not self.Enabled then return end
    --     love.graphics.drawRectangle(self:GetCF(), self.Size, Color4.new(1,0,0, 1), "line")
    -- end)

	return self
end

function module:GetCF(simCF)
    if not simCF then
        simCF = self.Object:GetTransform().CFrame
    end

    -- if not simCF then
    --     return CFrame.new(0, 0, 0)
    -- end

    return simCF * self.Offset
end

function module:CollidingWith(other, simCF)
    -- if self.CollisionLayer ~= other.CollisionLayer then return end
    if not (self.Enabled and other.Enabled) then return end

    local pos1, size1 = self:GetCF(simCF):ToVector2(), self.Size
    local pos2, size2 = other:GetCF():ToVector2(), other.Size


    local minRange = (size1+size2)/2

    local posDiff = pos1 - pos2
    posDiff.X = math.abs(posDiff.X)
    posDiff.Y = math.abs(posDiff.Y)

    return posDiff.X < minRange.X and posDiff.Y < minRange.Y
end

Class.RegisterComponent("Collider", module)

return module