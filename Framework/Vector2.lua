local module = {}
module.__index = module

module.new = function(x,y)
    local self = setmetatable({}, module)
    self.X = x or 0
    self.Y = y or 0
    self.Magnitude = math.sqrt(self.X ^ 2 + self.Y ^ 2)
    self.Unit = setmetatable({X = self.X / self.Magnitude, Y = self.Y / self.Magnitude})

    return self
end

return module