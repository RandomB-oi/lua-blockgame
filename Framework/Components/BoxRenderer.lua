local module = {}
module.__index = module
module.__derives = "Renderer"

local red = Color4.new(1,0,0,1)
local green = Color4.new(0,1,0,1)

function module.new(self)
	self:BindRendering(function()
		local transform = self.Object:GetTransform()
		if not transform then return end

		self:WaitForParentToRender()

		local cf, size = transform.RenderCFrame, transform.RenderSize
		if transform:IsA("GuiTransform") then -- guis start from the top left
			cf = cf * (size/2)
		end

		love.graphics.drawRectangle(cf, size, self:GetColor())
		-- love.graphics.drawRectangle(cf * CFrame.new(0, -(size.Y/2 + 10)), Vector2.new(10, 10), red)
		-- love.graphics.drawRectangle(cf * CFrame.new(size.X/2 + 10, 0), Vector2.new(10, 10), green)

		self.Object._drawn:Fire()
	end)

	return self
end

Class.RegisterComponent("BoxRenderer", module)

return module