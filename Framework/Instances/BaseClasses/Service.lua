local module = {}
module.__index = module
module.__derives = "Instance"

module.Services = {}

module.new = function(self)
    module.Services[self.Name] = self
end

GetService = function(name)
    return module.Services[name]
end
module.GetService = GetService

Class.RegisterClass("Service", module)

module.Init = function()
    Class.new("CollectionService", "CollectionService")
    Class.new("RunService", "RunService")
    Class.new("UserInputService", "UserInputService")
end

return module