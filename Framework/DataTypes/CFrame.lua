local module = {}
module.__index = module

module.new = function(x,y, r)
    if type(x) == "table" then
        r = y
        x, y = x.X, x.Y
    end

    local self = setmetatable({}, module)
    self.X = x or 0
    self.Y = y or 0
    self.Position = Vector2.new(self.X, self.Y)
    self.R = r or 0

    return self
end

module.Angle = function(r)
    return module.new(0, 0, r)
end

-- makes it point its rightVector towards the point
module.LookAt = function(from, to)
    local diff = to - from

    return module.new(from.X, from.Y, math.atan2(diff.Y, diff.X))
end

function module:UpVector()
    local a = self.R
    return Vector2.new(math.sin(a), -math.cos(a))
end
function module:DownVector()
    local a = self.R
    return Vector2.new(-math.sin(a), math.cos(a))
end

function module:RightVector()
    local a = self.R + math.pi/2
    return Vector2.new(math.sin(a), -math.cos(a))
end
function module:LeftVector()
    local a = self.R + math.pi/2
    return Vector2.new(-math.sin(a), math.cos(a))
end

function module:Inverse()
    return -self
end
function module:__unm()
    return module.new(self.X*-1, -self.Y*-1, -self.R*-1)
end
function module:__add(other)
    return module.new(self.X + other.X, self.Y + other.Y, self.R)
end
function module:__sub(other)
    return module.new(self.X - other.X, self.Y - other.Y, self.R)
end

function module:__mul(other)
    local movedX = self:RightVector() * other.X
	local movedY = self:DownVector() * other.Y
	local r = self.R + (other.R or 0)

	return module.new(
		self.X + movedX.X + movedY.X,
		self.Y + movedX.Y + movedY.Y,
		r
	)
end

function module:Lerp(other, a)
    return module.new(
        math.lerp(self.X, other.X, a),
        math.lerp(self.Y, other.Y, a),
        math.lerp(self.R, other.R, a)
    )
end

Class.RegisterClass("CFrame", module)

return module