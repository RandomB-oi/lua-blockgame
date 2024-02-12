local module = {}

module.Start = function()
    local uis = game:GetService("UserInputService")
    local run = game:GetService("RunService")

    game.Name = "Block Game"
    GameRegistry = require("Game.GameRegistry")

    local toolbarGui = Class.new("Instance")
    toolbarGui:AddTag("GuiTransform")
    toolbarGui:AddTag("BoxRenderer")
    local toolbarTransform = toolbarGui:GetTransform()
    toolbarTransform.Position = UDim2.new(0.5, 0, 1, -5)
    toolbarTransform.Size = UDim2.new(1,-10,0,75)
    toolbarTransform.AnchorPoint = Vector2.new(0.5, 1)

    local toolSlotSize = 75
    local padding = 5
    for i,v in pairs(GameRegistry) do
        local newSlot = Class.new("Instance")
        newSlot:AddTag("GuiTransform")
        newSlot:AddTag("ImageRenderer")
        local renderer = newSlot:GetComponent("ImageRenderer")
        renderer.Image = love.graphics.newImage("Game/Assets/itemSlot.png")
    end

    local gameWorld = Class.new("World")

    for x = 5, 10 do
        for y = 5, 10 do
            gameWorld:PlaceBlock(x, y, game:Construct(GameRegistry.planks))
        end
    end
end

return module