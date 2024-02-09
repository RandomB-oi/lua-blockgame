local module = {}
module.__index = module
module.__derives = "Component"

local white, black
function module.Init()
	white = Color4.new(1,1,1,1)
	black = Color4.new(0,0,0,1)
end

function module.new(self)
    
	self.Color = Color4.new(1,1,1,1)

    self.Highlighted = false -- for applying color shading with buttons n shit
    self.Clicked = false

	return self
end

function module:GetColor()
    if self.Clicked and self.Highlighted then
        return self.Color:Lerp(black, 0.2)
    elseif self.Highlighted then
        return self.Color:Lerp(white, 0.2)
    else
        return self.Color
    end
end

Class.RegisterClass("Renderer", module)

return module