local module = {}
module.__index = module

module.new = function(x,y)
    local self = setmetatable({}, module)
    self.X = x or 0
    self.Y = y or 0

    return self
end

function module:Length()
    return math.sqrt(self.X ^ 2 + self.Y ^ 2)
end

function module:Unit()
    return self/self:Length()
end

function module:__add(other)
    return module.new(self.X + other.X, self.Y + other.Y)
end

function module:__sub(other)
    return module.new(self.X - other.X, self.Y - other.Y)
end

function module:__div(other)
    if type(self) == "number" then return other/self end

    if type(other) == "number" then
        return module.new(self.X / other, self.Y / other)
    end
    return module.new(self.X / other.X, self.Y / other.Y)
end

function module:__mul(other)
    if type(self) == "number" then return other/self end

    if type(other) == "number" then
        return module.new(self.X * other, self.Y * other)
    end
    return module.new(self.X * other.X, self.Y * other.Y)
end

Class.RegisterClass("Vector2", module)

return module