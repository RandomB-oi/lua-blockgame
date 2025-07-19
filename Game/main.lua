local module = {}

module.Start = function()
    local uis = game:GetService("UserInputService")
    local run = game:GetService("RunService")

    game.Name = "Block Game"
    GameRegistry = require("Game.GameRegistry")

    -- local toolbarGui = Class.new("Instance")
    -- toolbarGui:AddTag("GuiTransform")
    -- -- toolbarGui:AddTag("Transform")
    -- toolbarGui:AddTag("BoxRenderer")
    -- toolbarGui:GetComponent("Renderer").Color.A = 0
    -- local toolbarTransform = toolbarGui:GetTransform()
    -- toolbarTransform.Position = UDim2.new(0.5, 0, 1, -5)
    -- toolbarTransform.Size = UDim2.new(1,-10,0,75)
    -- toolbarTransform.AnchorPoint = Vector2.new(0.5, 1)

    -- do
    --     local toolSlotSize = 75
    --     local toolSlotPadding = 5
    --     local itemDisplaySize = 50
    --     local totalToolSize = toolSlotSize + toolSlotPadding

    --     local totalSlots = 0
    --     for i,v in pairs(GameRegistry) do
    --         totalSlots = totalSlots + 1
    --     end
    --     local index = 0
    --     for name, value in pairs(GameRegistry) do
    --         index = index + 1

    --         local newSlot = Class.new("Instance")
    --         newSlot:AddTag("GuiTransform")
    --         newSlot:AddTag("ImageRenderer")
    --         local renderer = newSlot:GetComponent("ImageRenderer")
    --         renderer.Image = love.graphics.newImage("Game/Assets/itemSlot.png")

    --         local transform = newSlot:GetTransform()
    --         local offset = ((totalSlots-1) * totalToolSize/2) - ((index-1) * totalToolSize)
    --         transform.Position = UDim2.new(0.5, offset, 1, 0)
    --         transform.Size = UDim2.new(0, toolSlotSize, 0, toolSlotSize)
    --         transform.AnchorPoint = Vector2.new(0.5, 1)
    --         newSlot:SetParent(toolbarGui)

    --         -- local displayItem = game:Construct(value)
    --         -- local blockComp = displayItem:GetComponent("BlockComponent")
    --         -- if blockComp then
    --         --     displayItem:RemoveTag(blockComp.Name)
    --         -- end
    --         -- displayItem:GetTransform().Size = Vector2.new(itemDisplaySize, itemDisplaySize)
    --         -- displayItem:GetTransform().CFrame = Vector2.new(toolSlotSize/2, toolSlotSize/2)
    --         -- displayItem:SetParent(newSlot)
    --     end
    -- end

    local gameWorld = Class.new("World")
    local player = game:Construct(GameRegistry.player)
    local blockSize = Vector2.new(1,1) * Class.GetClass("BlockComponent").BlockSize
    player:GetTransform().Size = blockSize
    local collider = Class.GetComponent(player, "Collider")
    collider.Friction = 0
    collider.Size = blockSize

    gameWorld:PlaceBlock(0, 4, game:Construct(GameRegistry.planks))
    gameWorld:PlaceBlock(70, 4, game:Construct(GameRegistry.planks))
    for x = 0, 70 do
        for y = 5, 6 do
            gameWorld:PlaceBlock(x, y, game:Construct(GameRegistry.planks))
        end
    end
end

return module