local module = {}
module.__index = module

function module.new()
    local self = setmetatable({}, module)
    self.Chunks = {}

    return self
end

function module:PlaceBlock(x,y, block)
    local cx,cy, bx,by = self:GetChunkCoords(x,y)
    local chunk = self:GetChunk(cx,cy, true)
    chunk:SetBlock(bx,by, block)
end

function module:PixelsToCoords(x,y)
    local blockSize = Class.GetClass("BlockComponent").BlockSize
    return math.round(x/blockSize), math.round(y/blockSize)
end

function module:GetChunkCoords(x,y)
    local chunkSize = Class.GetClass("Chunk").ChunkSize
    local cx,cy = math.floor(x/chunkSize), math.floor(y/chunkSize)
    local bx,by = x % chunkSize, y % chunkSize
    return cx,cy, bx,by
end

function module:GetChunk(x,y, shouldGenerate)
    if shouldGenerate and not self:GetChunk(x,y) then
        local newChunk = Class.new("Chunk")
        newChunk.X = x
        newChunk.Y = y
        self.Chunks[x] = self.Chunks[x] or {}
        self.Chunks[x][y] = newChunk
    end

    return self.Chunks[x] and self.Chunks[x][y]
end

function module:SetChunks(x,y, newChunk)
    local currentBlock = self:GetBlock(x,y)
    if currentBlock then
        currentBlock:Destroy()
    end
    self.Blocks[x] = self.Blocks[x] or {}
    self.Blocks[x][y] = newChunk
end

Class.RegisterComponent("World", module)

return module