
--[[---------------------------------------------------------

  Apple's Gamemode

  This was made by Dr. Apple

-----------------------------------------------------------]]


-- Adding including files
include( 'shared.lua' )
include( 'menu/soundmenu.lua' )
include( 'menu/materialsmenu.lua' )
include( 'menu/f1_menu.lua' )
include( 'menu/f2_menu.lua' )
include( 'menu/f3_menu.lua' )
include( 'menu/f3_menu_ranks.lua' )
include( 'menu/f4_menu.lua' )
include( 'menu/cl_adci_teams.lua' )
include( 'hud/cl_apple_hud.lua' )
include( 'hud/cl_apple_hud_fonts.lua' )
AmIAllowedToDisplaySpectator = 0
TheLobbyAppleTime = 0
TheLobbyAppleTimeID = 0
YouAreTheMVP = 0
NextMapNameID = 0
RestartServerPleaseNowID = 0
YouAreNotTheMVPID = 0
TheGameAppleTimeID = 0

function GetNiceNameofWeapon(data) -- This is to get the weapon name for the favorite weapons table
local WeaponName = data:ReadEntity()
local PlayerName = data:ReadEntity()
	net.Start( "GetNiceNameofWeapon" )
		if WeaponName:GetPrintName() == nil || WeaponName:GetPrintName() == "" || WeaponName:GetPrintName() == " " || WeaponName:GetPrintName() == NULL then
			net.WriteString( WeaponName )
		else
			net.WriteString( WeaponName:GetPrintName() )
		end
	net.SendToServer( PlayerName )
end
usermessage.Hook("GetNiceNameofWeapon", GetNiceNameofWeapon)


function TheGameAppleIntro(data)
	local url = data:ReadString()
	local time = data:ReadString()
	timer.Simple(tonumber(time), function()
		if LocalPlayer().gmod_apple_channel ~= nil && LocalPlayer().gmod_apple_channel:IsValid() then
			LocalPlayer().gmod_apple_channel:Stop()
		end
	end)
	if LocalPlayer().gmod_apple_channel ~= nil && LocalPlayer().gmod_apple_channel:IsValid() then
		LocalPlayer().gmod_apple_channel:Stop()
	end
	
	sound.PlayURL(url,"",function(ch)
		if ch != nil and ch:IsValid() then
			ch:Play()
			LocalPlayer().gmod_apple_channel = ch
		end
	end)
end
usermessage.Hook("TheGameAppleIntro", TheGameAppleIntro)

function PlayWinSoundForAll(data)
	surface.PlaySound( data:ReadString() ) 
end
usermessage.Hook("PlayWinSoundForAll", PlayWinSoundForAll)

function LobbyTimerApple(data)
	TheLobbyAppleTimeID = data:ReadShort()
	TheLobbyAppleTime = data:ReadShort()
end
usermessage.Hook("LobbyTimerApple", LobbyTimerApple)

function TheGameAppleTimeFunc(data)
	TheGameAppleTimeID = data:ReadShort()
	TheGameAppleTime = data:ReadShort()
end
usermessage.Hook("TheGameAppleTimeFunc", TheGameAppleTimeFunc)

function YouAreNotTheMVP(data)
	YouAreNotTheMVPID = data:ReadShort()
	YouAreNotTheMVP = data:ReadString()
end
usermessage.Hook("YouAreNotTheMVP", YouAreNotTheMVP)

function YouAreTheMVP(data)
	YouAreTheMVP = data:ReadShort()
end
usermessage.Hook("YouAreTheMVP", YouAreTheMVP)

function RestartServer2(data)
	RestartServerPleaseNowID = data:ReadShort()
	RestartServerPleaseNow = data:ReadShort()
end
usermessage.Hook("RestartServer2", RestartServer2)


function FoundAGreatMap(data)
	NextMapNameID = data:ReadShort()
	NextMapName = data:ReadString()
end
usermessage.Hook("FoundAGreatMap", FoundAGreatMap)


function PlayerIsSpectating(data)
	AmIAllowedToDisplaySpectator = data:ReadShort()
	AmIAllowedToDisplaySpectatorred = data:ReadShort()
	AmIAllowedToDisplaySpectatorgreen = data:ReadShort()
	AmIAllowedToDisplaySpectatorblue = data:ReadShort()
	AmIAllowedToDisplaySpectator3 = data:ReadString()
end
usermessage.Hook("PlayerIsSpectating", PlayerIsSpectating)

function AppleCountDownStartSound(data)
surface.PlaySound( "apples_tdm_gm/final_count.mp3" )
surface.PlaySound( "apples_tdm_gm/wedding.mp3" )
end
usermessage.Hook("AppleCountDownStartSound", AppleCountDownStartSound)


function AppleRankUpSoundEffect(data)
	local url = data:ReadString()
	local time = data:ReadString()
	timer.Simple(tonumber(time), function()
		if LocalPlayer().gmod_apple_channel ~= nil && LocalPlayer().gmod_apple_channel:IsValid() then
			LocalPlayer().gmod_apple_channel:Stop()
		end
	end)
	if LocalPlayer().gmod_apple_channel ~= nil && LocalPlayer().gmod_apple_channel:IsValid() then
		LocalPlayer().gmod_apple_channel:Stop()
	end
	
	sound.PlayURL(url,"",function(ch)
		if ch != nil and ch:IsValid() then
			ch:Play()
			LocalPlayer().gmod_apple_channel = ch
		end
	end)
end
usermessage.Hook("AppleRankUpSoundEffect", AppleRankUpSoundEffect)

function APPLE_GM_HUD()
	if AmIAllowedToDisplaySpectator == 1 then
		draw.RoundedBoxEx( 0, 25, 25, 700, 35, Color(0,0,0,255), false, true, false, false )
		draw.SimpleText( "YOU ARE CURRENTLY SPECTATING: "..AmIAllowedToDisplaySpectator3, "TDM_Mini", 45, 25, Color(AmIAllowedToDisplaySpectatorred,AmIAllowedToDisplaySpectatorgreen,AmIAllowedToDisplaySpectatorblue,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	end
	if TheLobbyAppleTimeID == 1 then
	local TheTimeQ = TheLobbyAppleTime - math.Round(CurTime())
		if TheTimeQ >= 0 then
			draw.RoundedBoxEx( 0, 25, 145, 260, 35, Color(0,0,0,255), false, true, false, false )
			draw.SimpleText( "Lobby Timer: "..TheTimeQ, "TDM_Mini", 45, 145, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
		end
	end
	if TheGameAppleTimeID == 1 then
	local TheTimeQ = TheGameAppleTime - math.Round(CurTime())
		if TheTimeQ >= 0 then
			draw.RoundedBoxEx( 0, 25, 145, 260, 35, Color(0,0,0,255), false, true, false, false )
			draw.SimpleText( "Game Timer: "..TheTimeQ, "TDM_Mini", 45, 145, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
		end
	end
	if YouAreTheMVP == 1 then
		draw.RoundedBoxEx( 0, ScrW()/2 - 500, 48, 1000, 58, Color(0,0,0,255), false, true, false, false )
		draw.SimpleText( "CONGRATULATIONS, YOU ARE MVP", "TDM_Ammo_Secondary", ScrW()/2, 75, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0 )
	end
	if YouAreNotTheMVPID == 1 then
		draw.RoundedBoxEx( 0, ScrW()/2 - 500, 48, 1000, 58, Color(0,0,0,255), false, true, false, false )
		draw.SimpleText( YouAreNotTheMVP.." is MVP", "TDM_Ammo_Secondary", ScrW()/2, 75, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0 )
	end
	if RestartServerPleaseNowID == 1 then
		local TheTimeQ = RestartServerPleaseNow - math.Round(CurTime())
		local XVa = 300
		if TheTimeQ >= 0 then
			draw.RoundedBoxEx( 0, XVa, 115, 360, 35, Color(0,0,0,255), false, true, false, false )
			draw.SimpleText( "Game Restart Timer: "..TheTimeQ, "TDM_Mini", XVa+15, 115, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
		end
	end
	if NextMapNameID == 1 then
		draw.RoundedBoxEx( 0, 300, 155, 400, 35, Color(0,0,0,255), false, true, false, false )
		draw.SimpleText( "Next Map: "..NextMapName, "TDM_Mini", 315, 154, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
	end
end
hook.Add("HUDPaint", "APPLE_GM_HUD", APPLE_GM_HUD)