local module = {}
module.__index = module
module.__derives = "Instance"

module.new = function(self)
    self:AddTag("Transform")
    local transform = self:GetTransform()
    transform.Size = Vector2.new(800, 600)
    transform.CFrame = CFrame.new(400, 300)
end

Class.RegisterClass("Camera", module)

module.Init = function()
end

return module