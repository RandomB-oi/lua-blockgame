local module = {}
module.__index = module
module.__derives = "Instance"

module.new = function(self)
end

Class.RegisterClass("Service", module)

module.Init = function()
end

return module