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

    return
end

function module:HasTag(object, tag)
    self:RegisterTag(tag)
    
    return object.Tags[tag]
end

function module:AddTag(object, tag)
    self:RegisterTag(tag)
    
    if self:HasTag(object, tag) then return end

    object.Tags[tag] = true
    self.TaggedInstances[tag][object] = true

    self.InstanceAddedSignals:Fire(object)
end

function module:RemoveTag(object, tag)
    self:RegisterTag(tag)
    if not self:HasTag(object, tag) then return end
    
    object.Tags[tag] = nil
    self.TaggedInstances[tag][object] = nil
    
    self.InstanceRemovedSignals:Fire(object)
end

Class.RegisterClass("CollectionService", module)

return module