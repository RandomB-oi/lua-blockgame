local Module = {}
local Classes = {}
local Components = {}

local RequiredModules = {}
local AlreadyRequiredModules = {}

local function BindComponents()
    local CollectionService = GetService("CollectionService")
	for name, component in pairs(Components) do
		local function newObject(object)
			if component.Objects[object] then return end

			local newComponent = Module.new(name, object)
			component.Objects[object] = newComponent
		end

		CollectionService:GetInstanceRemovedSignal(name):Connect(function(object)
			local objectComponent = component.Objects[object]

			if objectComponent then
				component.Objects[object] = nil
				objectComponent:Destroy()
			end
		end)
		CollectionService:GetInstanceAddedSignal(name):Connect(newObject)
		for _, object in pairs(CollectionService:GetTagged(name)) do
			coroutine.wrap(newObject)(object)
		end
	end
end

local function InitGame()
	for _, v in pairs(RequiredModules) do
		local has = rawget(v, "Init")
		if has then
			has()
		end
	end
	BindComponents()
end
local function StartGame()
	for _, v in pairs(RequiredModules) do
		local has = rawget(v, "Start")
		if has then
			has()
		end
	end
end

Module.GetClass = function(name)
	return Classes[name]
end

Module.RegisterClass = function(name, class)
	Classes[name] = class
end

Module.RegisterComponent = function(name, component)
	Module.RegisterClass(name, component)
	
	Components[name] = component
	component.Objects = {}
end

local setmetatableModules = {}
Module.new = function(name, ...)
	local order = {name}
	local parentClassName = name

	while true do
		local parentClass = Module.GetClass(parentClassName)
		parentClass.Name = parentClassName
		local derives = rawget(parentClass, "__derives")
		if derives then
			if not setmetatableModules[parentClassName] then
				setmetatableModules[parentClassName] = true
				local deriveClass = Module.GetClass(derives)
				parentClass.Base = deriveClass
				setmetatable(parentClass, deriveClass)
			end
			parentClassName = derives
			table.insert(order, parentClassName)
		else
			table.remove(order, #order) -- because this is parentClass
			break
		end
	end

	local object = Module.GetClass(parentClassName).new(...)
	for i = #order, 1, -1 do
		local subClass = Module.GetClass(order[i])
		setmetatable(object, subClass)
		local newMethod = rawget(subClass, "new")
		if newMethod then
			object = newMethod(object) or object
		end
	end
	return object
end

Module.IsA = function(class, className)
	if class.Name == className then return true end
    local derives = rawget(class, "__derives")
	if derives then
		return Module.IsA(Module.GetClass(derives), className)
	end
end

Module.LoadDirectory = function(directory, descendants)
    local directories = {}
    
    for i, fileName in pairs(love.filesystem.getDirectoryItems(directory)) do
        local isDirectory do
            if love.filesystem.getInfo then
                isDirectory = love.filesystem.getInfo(directory.."/"..fileName).type == "directory"
            else
                isDirectory = love.filesystem.isDirectory(directory.."/"..fileName)
            end
        end

        if isDirectory then
            if descendants then
                table.insert(directories, {name = fileName, directory = directory.."/"..fileName})
            end
        elseif fileName:find(".lua") then
			if not table.find(AlreadyRequiredModules, fileName) then
                table.insert(AlreadyRequiredModules, fileName)

                local objectName = string.split(fileName, ".")[1]
                local fileDir = directory.."/"..objectName

                local required = require(fileDir)
                table.insert(RequiredModules, required)
                rawset(required,"_fileName", objectName)
            end
        end
    end
    
    if descendants then
        for _ , info in ipairs(directories) do
            Module.LoadDirectory(info.directory, descendants)
        end
    end
end

Module.Begin = function()
	InitGame()
	StartGame()
end

Module.GetComponent = function(object, componentName, _iterated)
	local class = Module.GetClass(componentName)
	if not (class and class.Objects) then return end

	local _iterated = _iterated or {}

	if not class.Objects[object] then
		for _, tag in pairs(object:GetTags()) do
			if not table.find(_iterated, tag) then
                table.insert(_iterated, tag)
                
                local foundClass = Module.GetClass(tag)
                if foundClass and Module.IsA(foundClass, componentName) then
                    return Module.GetComponent(object, tag, _iterated)
                end
            end
		end
	end

	return class.Objects[object]
end

return Module