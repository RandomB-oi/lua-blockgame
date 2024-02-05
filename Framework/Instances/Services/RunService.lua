local module = {}
module.__index = module
module.__derives = "Service"

module.new = function(self)
    self.Update = Class.new("Signal")
    self.Draw = Class.new("Signal")
    return self
end


Class.RegisterClass("RunService", module)

return module