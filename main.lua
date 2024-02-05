-- the entrypoint
local function load()
    table = require("Framework.Libraries.Table")
    string = require("Framework.Libraries.String")
    math = require("Framework.Libraries.Math")

    Class = require("Framework.Class")

    Maid = require("Framework.Maid")
    Signal = require("Framework.Signal")

    Vector2 = require("Framework.Vector2")
    CFrame = require("Framework.CFrame")
    Color4 = require("Framework.Color4")


    Class.LoadDirectory("Framework", true)
    Class.LoadDirectory("Game", true)

    Class.Begin()
    print("done loading")

    newBox = Class.new("Box")
    Class.GetComponent(newBox, "BoxRenderer").Color = Color4.new(1,1,1)
    newBox.CFrame = CFrame.new(50,50, math.pi/4)
    newBox.Size = Vector2.new(50, 50)

    upBox = Class.new("Box")
    Class.GetComponent(upBox, "BoxRenderer").Color = Color4.new(1,0,0)
    upBox.Size = Vector2.new(25, 25)

    rightBox = Class.new("Box")
    Class.GetComponent(rightBox, "BoxRenderer").Color = Color4.new(0,1,0)
    rightBox.Size = Vector2.new(25, 25)

end

local function update(dt)
    local run = GetService("RunService")
    run.Update:Fire(dt)

    local mx,my = love.mouse.getPosition()
    newBox.CFrame = CFrame.new(mx, my, os.clock())
    
    upBox.CFrame = newBox.CFrame * CFrame.new(0, 50)
    rightBox.CFrame = newBox.CFrame * CFrame.new(50, 0)
end

local function draw()
    local run = GetService("RunService")
    run.Draw:Fire()
end

love.load = load
love.update = update
love.draw = draw