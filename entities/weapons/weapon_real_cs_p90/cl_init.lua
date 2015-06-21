include("shared.lua")

local redDot = surface.GetTextureID("scope/scope_reddot")
function SWEP:ViewModelDrawn(vm)
	if true then
		return
	end
	local ang = vm:GetAngles()
	ang:RotateAroundAxis(vm:GetForward(), 90)
	ang:RotateAroundAxis(vm:GetUp(), -80)

	cam.Start3D2D(vm:GetPos() + (vm:GetForward() * 13)  + (vm:GetUp() * -1) + (vm:GetRight() * 4), ang, 1)
		--draw.SimpleText("Test String", "DebugFixed", 1, 0, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
		surface.SetTexture(redDot)
		surface.DrawTexturedRect(0, 0, 100, 100)
		surface.SetDrawColor(0,0,0)
		surface.DrawRect(0, 0, 1, 1)
	cam.End3D2D()
end

function DrawHUD()
	MsgN("NO!")
	return
end


