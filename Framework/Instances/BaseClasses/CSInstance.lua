local module = {}
module.__index = module
module.__derives = "Instance"

module.new = function(self)
    self.Size = Vector2.new(100, 100)
    self.CFrame = CFrame.new(0, 0, 0)

    return self
end

Class.RegisterClass("CSInstance", module)

return module