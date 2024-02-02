local module = {}
module.__index = module
module.__derives = "Service"

module.new = function(self)
    self.InstanceAddedSignals = {}
    self.InstanceRemovedSignals = {}

    self.TaggedInstances = {}

    return self
end

function module:RegisterTag(tagName)
    if not self.TaggedInstances[tagName] then
        self.TaggedInstances[tagName] = {}
        
        local addedSignal = Class.new("Signal")
        self.InstanceAddedSignals[tagName] = addedSignal

        local removedSignal = Class.new("Signal")
        self.InstanceRemovedSignals[tagName] = removedSignal
    end
end

function module:GetInstanceAddedSignal(tagName)
    self:RegisterTag(tagName)

    return self.InstanceAddedSignals[tagName]
end

function module:GetInstanceRemovedSignal(tagName)
    self:RegisterTag(tagName)

    return self.InstanceRemovedSignals[tagName]
end

function module:GetTagged(tagName)
    self:RegisterTag(tagName)

    return self.TaggedInstances[tagName]
end

function module:HasTag(object, tag)
    self:RegisterTag(tag)
    
    return not not table.find(object.Tags, tag)
end

function module:AddTag(object, tag)
    self:RegisterTag(tag)
    
    if self:HasTag(object, tag) then return end

    table.insert(object.Tags, tag)
    table.insert(self.TaggedInstances[tag], object)

    self.InstanceAddedSignals[tag]:Fire(object)
end

function module:RemoveTag(object, tag)
    self:RegisterTag(tag)
    if not self:HasTag(object, tag) then return end
    
    table.findRemove(object.Tags, tag)
    table.findRemove(self.TaggedInstances[tag], object)
    
    self.InstanceRemovedSignals[tag]:Fire(object)
end

Class.RegisterClass("CollectionService", module)

return module