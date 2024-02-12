local module = {}
module.__index = module
module.__derives = "Instance"


module.new = function(self)
    self.Services = {}

    self:AddService(Class.new("CollectionService", "CollectionService"))
    self:AddService(Class.new("RunService", "RunService"))
    self:AddService(Class.new("UserInputService", "UserInputService"))

    local lastTitle = nil
    local lastSize = nil
    self:GetService("RunService").Update:Connect(function()
        local title = self.Name
        if title ~= lastTitle then
            lastTitle = title
            love.window.setTitle(title)
        end

        if self.Camera then
            local size = self.Camera:GetTransform().Size
            if size ~= lastSize then
                lastSize = size
                love.window.setMode(size.X, size.Y)
            end
        end
    end)
end

function module:Construct(info)
    local object = Class.new(info[1])
    for i, tag in pairs(info[2]) do
        if type(tag) == "table" then
            
            object:AddTag(tag[1])
            local comp = object:GetComponent(tag[1])
            for prop, val in pairs(tag[2]) do
                comp[prop] = val
            end
        else
            object:AddTag(tag)
        end
    end
    return object
end

function module:GetService(name)
    return self.Services[name]
end

function module:AddService(service)
    self.Services[service.Name] = service
end

Class.RegisterClass("Game", module)

module.Init = function()
    game = Class.new("Game", "Untitled Game")
end

module.Start = function()
    game.Camera = Class.new("Camera")
end

return module