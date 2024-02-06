local module = {}
module.__index = module
module.__derives = "Service"

module.new = function(self)
    self.GameProcessedSerial = 0
    self.GameProcessed = Class.new("Signal")

    self.GUIInputBegan = Class.new("Signal")
    self.GUIInputEnded = Class.new("Signal")

    self.InputBegan = Class.new("Signal")
    self.InputEnded = Class.new("Signal")

    self.PressedKeys = {}
    self.PressedButtons = {}

    self.GameProcessed:Connect(function()
        self.GameProcessedSerial = self.GameProcessedSerial + 1
    end)

    -- uses gui input began and regular input ended, because the gui one is called first and the normal one is called last
    self.GUIInputBegan:Connect(function(inputObject)
        if inputObject.KeyCode ~= Enum.KeyCode.Unknown then
            self.PressedKeys[inputObject.KeyCode] = true
        end
        if inputObject.UserInputType ~= Enum.UserInputType.Unknown then
            self.PressedButtons[inputObject.UserInputType] = true
        end
    end)
    self.InputEnded:Connect(function(inputObject)
        if inputObject.KeyCode ~= Enum.KeyCode.Unknown then
            self.PressedKeys[inputObject.KeyCode] = nil
        end
        if inputObject.UserInputType ~= Enum.UserInputType.Unknown then
            self.PressedButtons[inputObject.UserInputType] = nil
        end
    end)

    return self
end

function module:GetEnumsForInput(key, mouse, state)
    if mouse then
        if key == 1 then return Class.new("InputObject", Enum.UserInputType.MouseButton1, Enum.KeyCode.Unknown, state) end
        if key == 2 then return Class.new("InputObject", Enum.UserInputType.MouseButton2, Enum.KeyCode.Unknown, state) end
        if key == 3 then return Class.new("InputObject", Enum.UserInputType.MouseButton3, Enum.KeyCode.Unknown, state) end
        if key == 4 then return Class.new("InputObject", Enum.UserInputType.MouseButton4, Enum.KeyCode.Unknown, state) end
        if key == 5 then return Class.new("InputObject", Enum.UserInputType.MouseButton5, Enum.KeyCode.Unknown, state) end
    else
        for keyName, keyCode in pairs(Enum.KeyCode) do
            if keyCode.Value == key then
                return Class.new("InputObject", Enum.UserInputType.Keyboard, keyCode, state)
            end
        end
    end
    return Class.new("InputObject", Enum.UserInputType.Unknown, Enum.KeyCode.Unknown, state)
end

function module:SimulateInput(inputObject)
    if inputObject.UserInputState == Enum.UserInputState.Began then
        local preSerial = self.GameProcessedSerial
        self.GUIInputBegan:Fire(inputObject)
        self.InputBegan:Fire(inputObject, preSerial ~= self.GameProcessedSerial)
    elseif inputObject.UserInputState == Enum.UserInputState.Ended then
        local preSerial = self.GameProcessedSerial
        self.GUIInputEnded:Fire(inputObject)
        self.InputEnded:Fire(inputObject, preSerial ~= self.GameProcessedSerial)
    end
end

function module:IsKeyDown(key)
    return not not self.PressedKeys[key]
end

function module:IsMouseButtonDown(key)
    return not not self.PressedButtons[key]
end

module.Init = function()
    local function keyPressed(key, mouse)
        local uis = GetService("UserInputService")
        local inputObject = uis:GetEnumsForInput(key, mouse, Enum.UserInputState.Began)
        uis:SimulateInput(inputObject)
    end
    local function keyReleased(key, mouse)
        local uis = GetService("UserInputService")
        local inputObject = uis:GetEnumsForInput(key, mouse, Enum.UserInputState.Ended)
        uis:SimulateInput(inputObject)
    end
    love.keypressed = function(key)
        keyPressed(key, false)
    end
    love.keyreleased = function(key)
        keyReleased(key, false)
    end

    love.mousepressed = function(x,y, key)
        keyPressed(key, true)
    end
    love.mousereleased = function(x,y, key)
        -- keyReleased(key, true)
    end
end

Class.RegisterClass("UserInputService", module)

return module