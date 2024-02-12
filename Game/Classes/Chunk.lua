local module = {}
module.__index = module

module.ChunkSize = 16

function module.new(x,y)
    local self = setmetatable({}, module)
    self.Blocks = {}

    self.X = x
    self.Y = y
    
    return self
end

function module:GetBlock(x,y)
    return self.Blocks[x] and self.Blocks[x][y]
end

function module:SetBlock(x,y, newBlock)
    local currentBlock = self:GetBlock(x,y)
    if currentBlock then
        currentBlock:Destroy()
        self.Blocks[x][y] = nil
    end

    if newBlock then
        self.Blocks[x] = self.Blocks[x] or {}
        self.Blocks[x][y] = newBlock
        local blockComp = newBlock:GetComponent("BlockComponent")
        blockComp.X = (self.X * self.ChunkSize) + x
        blockComp.Y = (self.Y * self.ChunkSize) + y
    end
end

Class.RegisterComponent("Chunk", module)

return module