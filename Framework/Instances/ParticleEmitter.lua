local module = {}
module.__index = module
module.__derives = "Instance"

module.All = {}

module.new = function(self)
    self.Enabled = true
    self.Rate = 20

    self:AddTag("Transform")

    -- particle properties 
    ---------------------------------------   
    self.ParticleSize = NumberSequence.new({{0,10}, {1,10}})
    self.Color = ColorSequence.new()

    self.LifeTime = NumberRange.new(1, 3)
    self.Speed = NumberRange.new(20, 100)
    self.EmissionAngleRange = NumberRange.new(0, 0)
    ---------------------------------------
    
    self.Particles = {}
    self.LastEmit = 0
	
    local run = GetService("RunService")
	self.Maid:GiveTask(run.Update:Connect(function(dt)
		self:StepParticles(dt)
	end))
	self.Maid:GiveTask(run.Draw:Connect(function()
		self:Draw()
	end))
	
	return self
end

function module:Emit(amount)
    local transform = self:GetTransform()
    local sizeRange = transform.RenderSize/2
    for i = 1, (amount or 1) do
        local newParticle = {
            Position = Vector2.new(transform.RenderCFrame.X, transform.RenderCFrame.Y) + Vector2.new(math.random(-sizeRange.X, sizeRange.X), math.random(-sizeRange.Y, sizeRange.Y)),
            ExpectedLifeTime = self.LifeTime:GetValue(),
            Speed = self.Speed:GetValue(),
            EmissionDirection = Vector2.FromAngle(math.rad(self.EmissionAngleRange:GetValue()));
            LifeTime = 0,
        }
        table.insert(self.Particles, newParticle)
    end
end

function module:StepParticles(dt)
    local t = os.clock()
    local timeDiff = t-self.LastEmit
    local emitRate = 1/self.Rate
    if self.Enabled and timeDiff > emitRate then
        self.LastEmit = t
        local amt = math.round(timeDiff/emitRate)
        self:Emit(amt)
    end
    for i = #self.Particles, 1, -1 do
        local particle = self.Particles[i]

        particle.LifeTime = particle.LifeTime + dt
        if particle.LifeTime >= particle.ExpectedLifeTime then
            table.remove(self.Particles, i)
        else
            particle.Position = particle.Position + particle.EmissionDirection*particle.Speed*dt
        end
    end
end

function module:Draw()
    for i, particle in ipairs(self.Particles) do
        local lifeTimeAlpha = particle.LifeTime/particle.ExpectedLifeTime

        local size = self.ParticleSize:GetValue(lifeTimeAlpha)
        local color = self.Color:GetValue(lifeTimeAlpha)
        color:Apply()

        love.graphics.rectangle("fill", particle.Position.X-size/2, particle.Position.Y-size/2, size, size)
    end
end

Class.RegisterClass("ParticleEmitter", module)

return module