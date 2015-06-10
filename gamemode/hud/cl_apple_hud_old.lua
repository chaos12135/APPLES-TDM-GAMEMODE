-- client side apple
if SERVER then return end


hook.Add( "HUDShouldDraw", "hide hud", function( name )
	if name == "CHudHealth" or name == "CHudBattery" or name == "CHudAmmo" or name == "CHudSecondaryAmmo" then 
		return false 
	end	
end)

TimerClWepHud = 0
TimerClWepHud2 = 0
timer.Create("cl_weapon_hud_apple",0.001,0, function()
TimerClWepHud = TimerClWepHud +1
TimerClWepHud2 = TimerClWepHud2 +1
if TimerClWepHud == 15 then
TimerClWepHud = 0
end
if TimerClWepHud2 == 10 then
TimerClWepHud2 = 0
end
	---- MsgN(TimerClWepHud)
end)

function APPLE_HUD_GR_E()
-- Grenade Ammo Box
if LocalPlayer():GetActiveWeapon() == NULL then return end	
	for k, v in pairs(LocalPlayer():GetWeapons()) do
		if v:GetPrimaryAmmoType() == 10 then
			if LocalPlayer():GetActiveWeapon():GetClass() == "weapon_frag" then
				if LocalPlayer():GetAmmoCount(v:GetPrimaryAmmoType()) >= 6 then
					for i=1,6 do
						surface.SetDrawColor(255,255,255,255)
						surface.SetMaterial( Material( "materials/apple_hud/grenade.png", "noclamp" ) )
						surface.DrawTexturedRect( (ScrW() - 37 - i*47),(ScrH()- 100),32,32)
						surface.SetTexture(0)
					end
				else
					for i=1,LocalPlayer():GetAmmoCount(v:GetPrimaryAmmoType()) do
						surface.SetDrawColor(255,255,255,255)
						surface.SetMaterial( Material( "materials/apple_hud/grenade.png", "noclamp" ) )
						surface.DrawTexturedRect( (ScrW() - 37 - i*47),(ScrH()- 100),32,32)
						surface.SetTexture(0)
					end
				end
			end
			if v:Clip1()+LocalPlayer():GetAmmoCount(v:GetPrimaryAmmoType()) != 0 || v:Clip1()+LocalPlayer():GetAmmoCount(v:GetPrimaryAmmoType()) != -1 then
				if v:Clip1()+LocalPlayer():GetAmmoCount(v:GetPrimaryAmmoType()) >= 6 then
					for i=1,6 do
						surface.SetDrawColor(255,255,255,255)
						surface.SetMaterial( Material( "materials/apple_hud/grenade.png", "noclamp" ) )
						surface.DrawTexturedRect( (ScrW() - 37 - i*47),(ScrH()- 100),32,32)
						surface.SetTexture(0)
					end
				else
					for i=1,v:Clip1()+LocalPlayer():GetAmmoCount(v:GetPrimaryAmmoType()) do
						surface.SetDrawColor(255,255,255,255)
						surface.SetMaterial( Material( "materials/apple_hud/grenade.png", "noclamp" ) )
						surface.DrawTexturedRect( (ScrW() - 37 - i*47),(ScrH()- 100),32,32)
						surface.SetTexture(0)
					end
				end
			end
		end
	end
end
hook.Add("HUDPaint", "APPLE_HUD_GR_E", APPLE_HUD_GR_E)


function APPLE_HUD_H_A_E()
-- Armor
surface.SetDrawColor(255,255,255,255)
surface.SetMaterial( Material( "materials/apple_hud/armor.png", "noclamp" ) )
surface.DrawTexturedRect( 25,(ScrH()- 99),32,32)
surface.SetTexture(0)
draw.RoundedBoxEx( 0, 67, ScrH() - 100, (LocalPlayer():Armor())*3+6, 35, Color(0,0,0,225), false, true, false, false )
draw.RoundedBoxEx( 0, 70, ScrH() - 97, (LocalPlayer():Armor())*3, 30, COLOR_AQUA, false, true, false, false )
draw.SimpleText( LocalPlayer():Armor(), "MenuLarge2", 75,ScrH() - 93, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )

-- Health
surface.SetDrawColor(255,255,255,255)
surface.SetMaterial( Material( "materials/apple_hud/health.png", "noclamp" ) )
surface.DrawTexturedRect( 25,(ScrH()- 60),32,32)
surface.SetTexture(0)
draw.RoundedBoxEx( 0, 67, ScrH() - 60, 100*3+6, 35, Color(0,0,0,225), false, true, false, false )
draw.RoundedBoxEx( 0, 70, ScrH() - 57, 300*(LocalPlayer():Health()/100), 30, Color((-2.55*(LocalPlayer():Health()))+255,255*(LocalPlayer():Health()/100),0,255), false, true, false, false )
draw.SimpleText( LocalPlayer():Health(), "MenuLarge2", 75,ScrH() - 53, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
end
hook.Add("HUDPaint", "APPLE_HUD_H_A_E", APPLE_HUD_H_A_E)


function APPLE_HUD_AM_E()
if LocalPlayer():GetActiveWeapon() != NULL then
	RequestActiveWeaponName = LocalPlayer():GetActiveWeapon():GetClass()
	for _, x in pairs(weapons.GetList()) do
		if LocalPlayer():GetActiveWeapon():GetClass() == x.ClassName then
	--	-- MsgN(x.ClipSize)
			if x.Primary.ClipSize != nil then
				DefaultClipSize = x.Primary.ClipSize
			else
				DefaultClipSize = x.Primary.DefaultClip
			end
		end
	end
	if RequestActiveWeaponName == "weapon_physcannon" then
	elseif RequestActiveWeaponName == "weapon_physgun" then
	elseif RequestActiveWeaponName == "gmod_tool" then
	elseif RequestActiveWeaponName == "weapon_slam" then
	elseif RequestActiveWeaponName == "weapon_bugbait" then
	elseif RequestActiveWeaponName == "weapon_stunstick" then
	elseif RequestActiveWeaponName == "weapon_crowbar" then
	elseif RequestActiveWeaponName == "weapon_fists" then
	elseif RequestActiveWeaponName == "weapon_medkit" then
		local DefaultClipSize = 100
		draw.RoundedBoxEx( 0, ScrW() - 334, ScrH() - 60, 300, 35, Color(0,0,0,255), false, true, false, false )
		if (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) <= 0.50 && (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) > 0.25 then
			draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255*(TimerClWepHud/15)), false, true, false, false )
		elseif (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) <= 0.25 && (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) < 0.50 then
			draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255*(TimerClWepHud2/15)), false, true, false, false )
		else
			draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255), false, true, false, false )
		end
		draw.SimpleText( LocalPlayer():GetActiveWeapon():Clip1().." %", "MenuLarge2", ScrW() - 140,ScrH() - 55, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	--	draw.SimpleText( LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "MenuLarge2", ScrW() - 85,ScrH() - 55, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	elseif RequestActiveWeaponName == "weapon_pistol" then
		local DefaultClipSize = 18
		draw.RoundedBoxEx( 0, ScrW() - 334, ScrH() - 60, 300, 35, Color(0,0,0,255), false, true, false, false )
		if (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) <= 0.50 && (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) > 0.25 then
			draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255*(TimerClWepHud/15)), false, true, false, false )
		elseif (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) <= 0.25 && (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) < 0.50 then
			draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255*(TimerClWepHud2/15)), false, true, false, false )
		else
			draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255), false, true, false, false )
		end
		draw.SimpleText( LocalPlayer():GetActiveWeapon():Clip1().." /", "MenuLarge2", ScrW() - 140,ScrH() - 55, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
		draw.SimpleText( LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "MenuLarge2", ScrW() - 85,ScrH() - 55, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	elseif RequestActiveWeaponName == "weapon_357" then 
		local DefaultClipSize = 6
		draw.RoundedBoxEx( 0, ScrW() - 334, ScrH() - 60, 300, 35, Color(0,0,0,255), false, true, false, false )
		if (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) <= 0.50 && (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) > 0.25 then
			draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255*(TimerClWepHud/15)), false, true, false, false )
		elseif (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) <= 0.25 && (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) < 0.50 then
			draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255*(TimerClWepHud2/15)), false, true, false, false )
		else
			draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255), false, true, false, false )
		end
		draw.SimpleText( LocalPlayer():GetActiveWeapon():Clip1().." /", "MenuLarge2", ScrW() - 140,ScrH() - 55, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
		draw.SimpleText( LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "MenuLarge2", ScrW() - 85,ScrH() - 55, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	elseif RequestActiveWeaponName == "weapon_smg1" then
		local DefaultClipSize = 45
		draw.RoundedBoxEx( 0, ScrW() - 334, ScrH() - 60, 300, 35, Color(0,0,0,255), false, true, false, false )
		if (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) <= 0.50 && (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) > 0.25 then
			draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255*(TimerClWepHud/15)), false, true, false, false )
		elseif (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) <= 0.25 && (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) < 0.50 then
			draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255*(TimerClWepHud2/15)), false, true, false, false )
		else
			draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255), false, true, false, false )
		end
		draw.SimpleText( LocalPlayer():GetActiveWeapon():Clip1().." /", "MenuLarge2", ScrW() - 140,ScrH() - 55, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
		draw.SimpleText( LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "MenuLarge2", ScrW() - 85,ScrH() - 55, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	elseif RequestActiveWeaponName == "weapon_ar2" then
		local DefaultClipSize = 30
		draw.RoundedBoxEx( 0, ScrW() - 334, ScrH() - 60, 300, 35, Color(0,0,0,255), false, true, false, false )
		if (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) <= 0.50 && (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) > 0.25 then
			draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255*(TimerClWepHud/15)), false, true, false, false )
		elseif (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) <= 0.25 && (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) < 0.50 then
			draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255*(TimerClWepHud2/15)), false, true, false, false )
		else
			draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255), false, true, false, false )
		end
		draw.SimpleText( LocalPlayer():GetActiveWeapon():Clip1().." /", "MenuLarge2", ScrW() - 140,ScrH() - 55, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
		draw.SimpleText( LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "MenuLarge2", ScrW() - 85,ScrH() - 55, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	elseif RequestActiveWeaponName == "weapon_crossbow" then
		draw.RoundedBoxEx( 0, ScrW() - 334, ScrH() - 60, 300, 35, Color(0,0,0,255), false, true, false, false )
		draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/1), 30, Color(100,100,100,255), false, true, false, false )
		draw.SimpleText( LocalPlayer():GetActiveWeapon():Clip1().." /", "MenuLarge2", ScrW() - 140,ScrH() - 55, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
		draw.SimpleText( LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "MenuLarge2", ScrW() - 85,ScrH() - 55, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	elseif RequestActiveWeaponName == "weapon_frag" then
	elseif RequestActiveWeaponName == "weapon_rpg" then
		draw.RoundedBoxEx( 0, ScrW() - 334, ScrH() - 60, 300, 35, Color(0,0,0,255), false, true, false, false )
		if LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) >= 1 then
			draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(1/1), 30, Color(100,100,100,255), false, true, false, false )
		end
		draw.SimpleText( LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "MenuLarge2", ScrW() - 85,ScrH() - 55, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	elseif RequestActiveWeaponName == "weapon_shotgun" then
		local DefaultClipSize = 6
		draw.RoundedBoxEx( 0, ScrW() - 334, ScrH() - 60, 300, 35, Color(0,0,0,255), false, true, false, false )
		if (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) <= 0.50 && (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) > 0.25 then
			draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255*(TimerClWepHud/15)), false, true, false, false )
		elseif (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) <= 0.25 && (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) < 0.50 then
			draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255*(TimerClWepHud2/15)), false, true, false, false )
		else
			draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255), false, true, false, false )
		end
		draw.SimpleText( LocalPlayer():GetActiveWeapon():Clip1().." /", "MenuLarge2", ScrW() - 140,ScrH() - 55, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
		draw.SimpleText( LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "MenuLarge2", ScrW() - 85,ScrH() - 55, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	elseif LocalPlayer():GetActiveWeapon():Clip1() == -1 then
	else
	if DefaultClipSize == nil then return end
		if LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType() != 10 then
			draw.RoundedBoxEx( 0, ScrW() - 334, ScrH() - 60, 300, 35, Color(0,0,0,255), false, true, false, false )
			if (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) <= 0.50 && (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) > 0.25 then
				draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255*(TimerClWepHud/15)), false, true, false, false )
			elseif (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) <= 0.25 && (LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize) < 0.50 then
				draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255*(TimerClWepHud2/15)), false, true, false, false )
			else
				draw.RoundedBoxEx( 0, ScrW() - 331, ScrH() - 57, 294*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize), 30, Color(100,100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),100*(LocalPlayer():GetActiveWeapon():Clip1()/DefaultClipSize),255), false, true, false, false )
			end
			draw.SimpleText( LocalPlayer():GetActiveWeapon():Clip1().." /", "MenuLarge2", ScrW() - 140,ScrH() - 55, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
			draw.SimpleText( LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()), "MenuLarge2", ScrW() - 85,ScrH() - 55, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
		end
	end
end
end
hook.Add("HUDPaint", "APPLE_HUD_AM_E", APPLE_HUD_AM_E)