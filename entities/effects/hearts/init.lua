EFFECT.MaxWidth = 500

local heart = surface.GetTextureID("effect/heart")
function EFFECT:Init(data)
	self:SetPos(data:GetStart())
	self.xDir = (math.random() * 2) - 1
	self.yDir = (math.random() * 2) - 1
	self.zDir = (math.random() * 2) - 1.2
	self.life = 10
	self.Popped = false
end

function EFFECT:Think()
	self.life = self.life - 0.1
	self:SetPos(self:GetPos() + Vector(self.xDir, self.yDir, self.zDir))
	if (self.life <= 0) then return false end
	return true
end

function EFFECT:Render()
	local ang = LocalPlayer():EyeAngles()
	ang:RotateAroundAxis(LocalPlayer():GetForward(), 270)
	ang:RotateAroundAxis(LocalPlayer():GetRight(), -180)
	ang:RotateAroundAxis(LocalPlayer():GetUp(), 90)
	ang = Angle(0, ang.y, ang.r)

	if (!self.Popping) then
	cam.Start3D2D(self:GetPos(), ang, 0.1)
		surface.SetDrawColor(Color(255, 0, 0))
		surface.SetTexture(heart)
		surface.DrawTexturedRect(-surface.GetTextureSize(heart)/2, -surface.GetTextureSize(heart), surface.GetTextureSize(heart), surface.GetTextureSize(heart))
	cam.End3D2D()
	end
end