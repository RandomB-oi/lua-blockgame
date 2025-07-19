local module = {}
module.__index = module
module.__derives = "Component"

local white, black
function module.Init()
	white = Color4.new(1,1,1,1)
	black = Color4.new(0,0,0,1)
end

function module.new(self)
    
	self.Color = Color4.new(1,1,1,1)

    self.Highlighted = false -- for applying color shading with buttons n shit
    self.Clicked = false

	return self
end

function module:ShouldRender()
    if true then return true end
    local transform = self.Object:GetTransform()

    local cameraTransform = game.Camera:GetTransform()

    local parentRenderer = self.Object.Parent and self.Object.Parent:GetComponent("Renderer")
    if parentRenderer and not parentRenderer:ShouldRender() then
        return false
    end

    if transform:IsA("GuiTransform") then
        return true
    end

    return 
    transform.CFrame.X > cameraTransform.CFrame.X and
    transform.CFrame.Y > cameraTransform.CFrame.Y and
    transform.CFrame.X < cameraTransform.CFrame.X + cameraTransform.Size.X and
    transform.CFrame.Y < cameraTransform.CFrame.Y + cameraTransform.Size.Y
end

function module:WaitForParentToRender()
    local parentRenderer = self.Object.Parent and self.Object.Parent:GetComponent("Renderer")
    if parentRenderer and parentRenderer:ShouldRender() then
        self.Object.Parent._drawn:Wait()
    end
end

function module:BindRendering(callback)
    local transform = self.Object:GetTransform()
    local run = game:GetService("RunService")

    if not self:ShouldRender() then return end

    if transform:IsA("GuiTransform") then
        self.Maid.Render = run.GUIDraw:Connect(callback)
    else
        self.Maid.Render = run.Draw:Connect(callback)
    end
end

function module:GetColor()
    if self.Clicked and self.Highlighted then
        return self.Color:Lerp(black, 0.2)
    elseif self.Highlighted then
        return self.Color:Lerp(white, 0.2)
    else
        return self.Color
    end
end

Class.RegisterClass("Renderer", module)

return module