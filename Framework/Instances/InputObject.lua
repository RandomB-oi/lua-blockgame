local module = {}
module.__index = module

module.new = function(inputType, keyCode, state)
    return setmetatable({
        UserInputType = inputType,
        KeyCode = keyCode,
        UserInputState = state,
    }, module)
end

Class.RegisterClass("InputObject", module)

return module