-- This HUD is very messy and picky. Try
-- not to edit it as it may break core functions
-- of the game.

HAAB = 0
PlayerPointsD = 0

CLIENTHUD_RankName = "RANK_IS_LOADING"
CLIENTHUD_RankNumber = "1337"
CLIENTHUD_RankMaterial = "apple_ranks/test.png"

--RewardSCreenT = 260
--RewardScreen = 0
--RewardScreenM = "materials/apple_hud/rank/test.png"
--RewardScreenN = "RANK_NAME_HERE"

pl = nil

timer.Create( "HealthAndArmourBlinding", .05, 0, function()
if HAAB == 250 then 
	HAAB = 0
end
	HAAB = HAAB + 10
end)

function HUD_GET_POINTS(data)
PlayerPointsD = data:ReadShort()
end
usermessage.Hook("HUD_GET_POINTS", HUD_GET_POINTS)




function PlayerIsSpawnSafeA(data)
	local NewTarget = data:ReadEntity()
	local IDV = data:ReadShort()
	NewTarget:SetPData("PlayerIsSpawnSafe",IDV)
end
usermessage.Hook("PlayerIsSpawnSafeA", PlayerIsSpawnSafeA)



function ICanSeeYou()
	local ply = LocalPlayer()
	
	for id, target in pairs(player.GetAll()) do

		if target:Alive() && target != ply then
		
			local targetPos = target:GetPos() + Vector(0,0,80)
		--	local targetDistance = math.floor((ply:GetPos():Distance( targetPos ))/40)
			local targetScreenpos = targetPos:ToScreen()
			
			if target:GetPData("PlayerIsSpawnSafe") == nil || target:GetPData("PlayerIsSpawnSafe") == NULL then
				net.Start( "PlayerIsSpawnSafeFix" )
				net.SendToServer( ply )
			end

			if tonumber(target:GetPData("PlayerIsSpawnSafe")) == 1 then
			
				local tr = util.TraceLine( util.GetPlayerTrace( LocalPlayer() ) )
				if IsValid( tr.Entity ) then
					surface.SetTextColor(200,25,25,255)
					surface.SetFont("default")
					surface.SetTextPos( tonumber( targetScreenpos.x - 45 ), tonumber( targetScreenpos.y ) )
					surface.DrawText("SPAWN PROTECTED")
				end
				
			end
		end

	end

end
hook.Add("HUDPaint", "DrawCoolScript", ICanSeeYou)


/*
timer.Create( "RewardSCreenT", .005, 0, function()
if RewardSCreenT == 0 then 
	RewardSCreenT = 260
end
	RewardSCreenT = RewardSCreenT - 1
end)

timer.Stop("RewardSCreenT")


function TDMRoundedBoxHook2Ck(data)
RewardScreenM = data:ReadString()
RewardScreenN = data:ReadString()
RewardScreen = data:ReadShort()
end
usermessage.Hook("TDMRoundedBoxHud2Ck", TDMRoundedBoxHook2Ck)


function TDMRoundedBoxHook2Ck5(data)
RewardScreenM5 = data:ReadString()
RewardScreenN5 = data:ReadString()
RewardScreen5 = data:ReadShort()
end
usermessage.Hook("TDMRoundedBoxHud2Ck5", TDMRoundedBoxHook2Ck5)

function TDMRoundedBoxHud2CkSS(data)
surface.PlaySound( "apptdm/levelup.mp3" )
end
usermessage.Hook("TDMRoundedBoxHud2CkSS", TDMRoundedBoxHud2CkSS)

function TDMRoundedBoxHud2CkS(data)
surface.PlaySound( "apptdm/rankup.mp3" )
end
usermessage.Hook("TDMRoundedBoxHud2CkS", TDMRoundedBoxHud2CkS)


function TDMRoundedBoxHook2()
	if RewardScreen == 1 then
	timer.Start("RewardSCreenT")
		draw.RoundedBoxEx( 0, 10, ScrH() - 760, 450, 125, Color( 0, 0, 0, RewardSCreenT - 35 ), false, true, false, false )
		surface.SetDrawColor(255,255,255,RewardSCreenT)
		surface.SetMaterial( Material( RewardScreenM, "noclamp" ) )
		surface.DrawTexturedRect( 30,(ScrH()- 750),100,100)
		surface.SetTexture(0)
		draw.SimpleText( "Congratulations, you've been promoted", "MenuLarge2", 150,ScrH() -750, Color(255,255,255,RewardSCreenT), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
		draw.SimpleText( RewardScreenN, "TDM_Ammo_Primary", 200,ScrH() -720, Color(255,255,255,RewardSCreenT), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	timer.Simple(12, function()
		RewardSCreenT = 0
		timer.Stop("RewardSCreenT")
	end)
	end
end
hook.Add("HUDPaint", "TDMRoundedBoxHud2", TDMRoundedBoxHook2)


function TDMRoundedBoxHook3()
	if RewardScreen5 == 1 then
	timer.Start("RewardSCreenT")
		draw.RoundedBoxEx( 0, 10, ScrH() - 760, 450, 125, Color( 0, 0, 0, RewardSCreenT - 35 ), false, true, false, false )
		surface.SetDrawColor(255,255,255,RewardSCreenT)
		surface.SetMaterial( Material( RewardScreenM5, "noclamp" ) )
		surface.DrawTexturedRect( 30,(ScrH()- 750),100,100)
		surface.SetTexture(0)
		draw.SimpleText( "You completed challenge:", "MenuLarge2", 150,ScrH() -750, Color(255,255,255,RewardSCreenT), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
		draw.SimpleText( RewardScreenN5.."!", "TDM_Ammo_Primary", 200,ScrH() -720, Color(255,255,255,RewardSCreenT), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	timer.Simple(12, function()
		RewardSCreenT = 0
		timer.Stop("RewardSCreenT")
	end)
	end
end
hook.Add("HUDPaint", "TDMRoundedBoxHook3", TDMRoundedBoxHook3)
*/
 
function FetchRankandNum(data)
	CLIENTHUD_RankName = data:ReadString()
	CLIENTHUD_RankNumber = data:ReadString()
	CLIENTHUD_RankMaterial = data:ReadString()
	local ply = data:ReadEntity()
	--data:ReadEntity():SetPData("AppleTDMRankName", RankName)
	ply:SetPData("AppleTDMRankName", RankName)
	ply:SetPData("AppleTDMRankNumber", RankNumber)
	ply:SetPData("AppleTDMRankMaterial", RankMaterial)
end
usermessage.Hook("FetchRankandNum", FetchRankandNum)
 

function TDMRoundedBoxHud2()
 	draw.RoundedBoxEx( 0, 10, 10, 200, 120, Color( 110,106,90,195 ), false, true, false, false )
	draw.SimpleText( "Rank: "..CLIENTHUD_RankName, "MenuLarge2", 20, 16, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	draw.SimpleText( "Level: "..CLIENTHUD_RankNumber, "MenuLarge2", 20, 30, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	surface.SetDrawColor(255,255,255,255)
	surface.SetMaterial( Material( CLIENTHUD_RankMaterial) )
	surface.DrawTexturedRect( 90,35,75,75)
	surface.SetTexture(0)
end
hook.Add("HUDPaint", "TDMRoundedBoxHud2", TDMRoundedBoxHud2)
 
 
function TDMRoundedBoxHook()
	draw.RoundedBoxEx( 0, 120, ScrH() - 85, 200, 80, Color( 110,106,90,195 ), false, true, false, false )

	draw.SimpleText( "Your Score:", "MenuLarge2", 130,ScrH() -85, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	draw.SimpleText( LocalPlayer():Frags()*10, "MenuLarge2", 230,ScrH() -85, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )

	draw.SimpleText( "Your Team:", "MenuLarge2", 130, ScrH() -65, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	if string.len(team.GetName(LocalPlayer():Team())) >= 9 then
		draw.SimpleText( string.Left(team.GetName(LocalPlayer():Team()),6).."..", "MenuLarge2", 230,ScrH() -65,team.GetColor(LocalPlayer():Team()) , TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	else
		draw.SimpleText( team.GetName(LocalPlayer():Team()), "MenuLarge2", 230,ScrH() -65,team.GetColor(LocalPlayer():Team()) , TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	end
	--draw.SimpleText( team.GetName(LocalPlayer():Team()), "MenuLarge2", 230,ScrH() -65,COLOR_WHITE , TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )

	draw.SimpleText( "Team Score:", "MenuLarge2", 130, ScrH() -45, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	draw.SimpleText( team.GetScore(LocalPlayer():Team()), "MenuLarge2", 230,ScrH() -45, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )

	draw.SimpleText( "Your Points:", "MenuLarge2", 130, ScrH() -25, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	draw.SimpleText( PlayerPointsD, "MenuLarge2", 230,ScrH() -25, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )

 
		draw.RoundedBoxEx( 0, 0, ScrH() - 85, 120, 80, Color( 0, 0, 0, 230 ), false, true, false, false )
		if LocalPlayer():Health() <= 25 then
		draw.SimpleText( LocalPlayer():Health(), "HUDNumber2", 40,ScrH()-85, Color(255,100,100,HAAB), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
		else
		draw.SimpleText( LocalPlayer():Health(), "HUDNumber2", 40,ScrH()-85, COLOR_HP, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
		end
		draw.RoundedBoxEx( 0, ScrW() -220, ScrH() - 65, 220, 60, Color( 10, 10, 10, 220 ), false, true, false, false )
		draw.SimpleText( LocalPlayer():Armor(), "HUDNumber2", 40,ScrH()-45, COLOR_HP, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
		draw.RoundedBoxEx( 0, ScrW() , ScrH() - 85, 220, 80, Color( 10, 10, 10, 220 ), false, true, false, false )

		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial( Material( "materials/apple_hud/hpicon.png", "noclamp" ) )
		surface.DrawTexturedRect( 10,(ScrH()- 75),20,20)
		surface.SetTexture(0)
		
		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial( Material( "materials/apple_hud/armoricon.png", "noclamp" ) )
		surface.DrawTexturedRect( 10,(ScrH()- 35),20,20)
		surface.SetTexture(0)
	
		draw.RoundedBoxEx( 0, 0, ScrH() - 110, 320, 25, Color( 0,0,0,155 ), false, true, false, false )
		draw.SimpleTextOutlined( "Leading Team: ", "MenuLarge2", 10,ScrH() -105, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
		draw.SimpleTextOutlined( "Score: ", "MenuLarge2", 230,ScrH() -105, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
		

		Teams = team.GetAllTeams()[1]
		for k,v in pairs(team.GetAllTeams()) do
			if k != 0 and k < 1000 then
				if team.GetScore(k) >= team.GetScore(Teams) then
				if team.GetScore(k) == 0 then
				
				else
					Teams = k
					pl = player.GetAll()[1]
					for l,r in pairs(player.GetAll()) do
						if r:Frags() > pl:Frags() then
							pl = r 
						end
					end
				end
				end
			end
		end
		
	
		if Teams == nil || team.GetName(Teams) == "" then
		draw.SimpleText( "N/A", "MenuLarge2", 125,ScrH() -105, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
		else
			if string.len(team.GetName(Teams)) >= 9 then
				draw.SimpleText( string.Left(team.GetName(Teams),6).."..", "MenuLarge2", 125,ScrH() -105, team.GetColor(Teams), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
			else
				draw.SimpleText( team.GetName(Teams), "MenuLarge2", 125,ScrH() -105, team.GetColor(Teams), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
			end
		end
		draw.SimpleText( team.GetScore(Teams), "MenuLarge2", 285,ScrH() -105, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	

if !LocalPlayer():IsValid() then
else
	if !LocalPlayer():Alive() then 
	else
	if LocalPlayer():GetActiveWeapon() == NULL || LocalPlayer():GetActiveWeapon() == nil then
	else
	local WeaponName = (LocalPlayer():GetActiveWeapon():GetPrintName( ))
	
	for _, x in pairs(weapons.GetList()) do
	DefaultClipSize = nil
		if LocalPlayer():GetActiveWeapon():GetClass() == x.ClassName then
	--	-- MsgN(x.ClipSize)
			if x.Primary.ClipSize != nil then
				DefaultClipSize = x.Primary.ClipSize
			else
				DefaultClipSize = x.Primary.DefaultClip
			end
		end
	end
	if DefaultClipSize == nil then
		DefaultClipSize = 0
	end
	
	local WeaponClip = LocalPlayer():GetActiveWeapon():Clip1()
	local WeaponClipAmmo = LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType())
	draw.SimpleText( WeaponName , "TDM_Ammo_Primary", ScrW() -210, ScrH() -90, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	draw.SimpleText( "Ammo", "TDM_Ammo_Primary", ScrW() -170, ScrH() -20, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0 )

	if WeaponClip == -1 then
		draw.SimpleText( "N/A" , "TDM_Ammo_Secondary", ScrW() -80, ScrH() -35, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0 )
	elseif (WeaponClip/DefaultClipSize) <= 0.50 then
		draw.SimpleText( WeaponClip , "TDM_Ammo_Secondary", ScrW() -80, ScrH() -35, Color(255,100,100,HAAB), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0 )
	else
		draw.SimpleText( WeaponClip , "TDM_Ammo_Secondary", ScrW() -80, ScrH() -35, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0 )
	end
	if WeaponClip == -1 then
		draw.SimpleText( "", "TDM_Ammo_Primary", ScrW() -30, ScrH() -20, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0 )
	elseif WeaponClip > DefaultClipSize then	
		draw.SimpleText( WeaponClipAmmo, "TDM_Ammo_Primary", ScrW() -30, ScrH() -20, Color(255,100,100,HAAB), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0 )
	else
		draw.SimpleText( WeaponClipAmmo, "TDM_Ammo_Primary", ScrW() -30, ScrH() -20, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0 )
	end
	end
	end
end
end
hook.Add("HUDPaint", "TDMRoundedBoxHud", TDMRoundedBoxHook)

function TDMHideDefaultHUD(name)
	if name == "CHudHealth" or name == "CHudBattery" or name == "CHudAmmo" or name == "CHudSecondaryAmmo" then 
		return false 
	end	

end
hook.Add("HUDShouldDraw", "TDMHideDefaultHUD", TDMHideDefaultHUD)


