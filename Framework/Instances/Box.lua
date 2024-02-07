local module = {}
module.__index = module
module.__derives = "CSInstance"

module.new = function(self)
    self:AddTag("BoxRenderer")
end

Class.RegisterClass("Box", module)

return module