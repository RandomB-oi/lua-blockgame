local module = {}
module.__index = module

local serial = 0
local function GenerateId()
    serial = serial + 1
    return serial
end

local Components = {}
module.RegisterComponent = function(name, component)
    Components[name] = component
end

module.All = {}

module.new = function(name, specificId)
    local self = setmetatable({}, module)

    self.Maid = Class.new("Maid")
    self.Name = name or "Object"
    self.Tags = {}
    self.Attributes = {}
    self.Children = {}
    self.AttributeChangedSignals = {}

	self._drawn = Class.new("Signal")
	self.Maid:GiveTask(self._drawn)

    self.ID = specificId or GenerateId()
    module.All[self.ID] = self
    self.Maid:GiveTask(function()
        module.All[self.ID] = nil
    end)

    return self
end

function module:Destroy()
    for i,v in pairs(self:GetTags()) do
        self:RemoveTag(v)
    end
    self.Maid:Destroy()
end

function module:GetAttributeChangedSignal(name)
    if self.AttributeChangedSignals[name] then
        return self.AttributeChangedSignals[name]
    end

    local newSignal = Class.new("Signal")
    self.AttributeChangedSignals[name] = newSignal

    return newSignal
end

function module:GetAttribute(name)
    return self.Attributes[name]
end

function module:SetAttribute(name, value)
    self.Attributes[name] = value
end

function module:GetAttributes()
    return self.Attributes
end

function module:HasTag(tag)
    return GetService("CollectionService"):HasTag(self, tag)
end

function module:AddTag(tag)
    return GetService("CollectionService"):AddTag(self, tag)
end

function module:RemoveTag(tag)
    return GetService("CollectionService"):RemoveTag(self, tag)
end

function module:GetTags()
    return GetService("CollectionService"):GetTags(self)
end

function module:GetComponent(name)
    return Class.GetComponent(self, name)
end

function module:GetTransform()
    return self:GetComponent("Transform") or self:GetComponent("GuiTransform")
end

function module:SetParent(newParent)
    if self.Parent then
        table.findRemove(self.Parent.Children, self)
    end
    self.Parent = newParent
    if newParent then
        table.insert(newParent.Children, newParent)
    end
end

Class.RegisterClass("Instance", module)

return module