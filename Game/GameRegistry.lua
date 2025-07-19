return {
    player = {"Instance", {"Transform", "Collider", "RigidBody", "PlayerController", {"ImageRenderer", {Image = love.graphics.newImage("Game/Assets/planks.png")}}}},

    planks = {"Instance", {"Transform", "Collider", "BlockComponent", {"ImageRenderer", {Image = love.graphics.newImage("Game/Assets/planks.png")}}}},
    dirt = {"Instance", {"Transform", "Collider", "BlockComponent", {"ImageRenderer", {Image = love.graphics.newImage("Game/Assets/dirt.png")}}}},
    grass = {"Instance", {"Transform", "Collider", "BlockComponent", {"ImageRenderer", {Image = love.graphics.newImage("Game/Assets/grass.png")}}}},
    leaves = {"Instance", {"Transform", "Collider", "BlockComponent", {"ImageRenderer", {Image = love.graphics.newImage("Game/Assets/leaves.png")}}}},
    stone = {"Instance", {"Transform", "Collider", "BlockComponent", {"ImageRenderer", {Image = love.graphics.newImage("Game/Assets/stone.png")}}}},
    torch = {"Instance", {"Transform", "Collider", "BlockComponent", {"ImageRenderer", {Image = love.graphics.newImage("Game/Assets/torch.png")}}}},
}