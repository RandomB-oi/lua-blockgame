local module = {}
module.__index = module
module.__derives = "Component"

function module.new(self)
	print("created a box renderer")
	return self
end

Class.RegisterComponent("BoxRenderer", module)

return module