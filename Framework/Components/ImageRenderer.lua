local module = {}
module.__index = module
module.__derives = "Renderer"

local function DrawRectangle(cf, size, color)
	local width = size.X
	local height = size.Y
	local x = cf.X
	local y = cf.Y
	local r = cf.R
	
	love.graphics.push()
	love.graphics.translate(x, y)
	love.graphics.rotate(r)
	color:Apply()
	love.graphics.rectangle("fill", -width/2, -height/2, width, height)
	love.graphics.pop()
end

function module.new(self)
	local run = game:GetService("RunService")

	self.Maid:GiveTask(run.Draw:Connect(function()
		local transform = self.Object:GetTransform()
		if not transform then return end

		self:WaitForParentToRender()

		local cf, size = transform.RenderCFrame, transform.RenderSize
		if transform:IsA("GuiTransform") then -- guis start from the top left
			cf = cf * (size/2)
		end

        self:GetColor():Apply()
        love.graphics.cleanDrawImage(self.Image, cf, size)
		-- DrawRectangle(cf, size, self:GetColor())

		self.Object._drawn:Fire()
	end))

	return self
end

Class.RegisterComponent("ImageRenderer", module)

return module