local module = {}
module.__index = module
module.__derives = "Instance"

module.Services = {}

module.new = function(self)
    module.Services[self.Name] = self
end

module.GetService = function(name, name2)
    return module.Services[name2 or name] -- can call with : or .
end

Class.RegisterClass("Service", module)

return module