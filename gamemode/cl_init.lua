
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
include( 'menu/f3_menu_classes.lua' )
include( 'menu/f3_menu_ammo_types.lua' )
include( 'menu/f3_menu_shop.lua' )
include( 'menu/f4_menu.lua' )
include( 'menu/classes_menu.lua' )
include( 'menu/cl_adci_teams.lua' )
include( 'scoreboard_tab/cl_tab.lua' )
include( 'hud/cl_apple_hud.lua' )
include( 'hud/cl_apple_hud_fonts.lua' )
include( "cs_ignore/client/csr_cvars.lua" )
AmIAllowedToDisplaySpectator = 0
TheLobbyAppleTime = 0
TheLobbyAppleTimeID = 0
YouAreTheMVP = 0
NextMapNameID = 0
RestartServerPleaseNowID = 0
YouAreNotTheMVPID = 0
TheGameAppleTimeID = 0
TheGameAppleTime = 0
	local KEY1_CLASSES_CLIENT = 0
	local KEY2_CLASSES_CLIENT = 0
	local KEY3_CLASSES_CLIENT = 0
	local KEY4_CLASSES_CLIENT = 0
	local KEY5_CLASSES_CLIENT = 0
	local KEY6_CLASSES_CLIENT = 0
	local KEY7_CLASSES_CLIENT = (1)

function GM:PostDrawViewModel( vm, ply, weapon )
if ( weapon.UseHands || !weapon:IsScripted() ) then
local hands = LocalPlayer():GetHands()
if ( IsValid( hands ) ) then hands:DrawModel() end
end
end
	
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


/*
	hook.Add( "Think", "MenuKeyListener", function()
		if input.IsKeyDown( KEY_A ) == true then
			if KEY1_CLASSES_CLIENT == 0 then
			KEY1_CLASSES_CLIENT = 1
				timer.Simple(KEY7_CLASSES_CLIENT, function()
					KEY1_CLASSES_CLIENT = 0
				end)
			end
		end
		if input.IsKeyDown( KEY_P ) == true then
			if KEY2_CLASSES_CLIENT == 0 then
			KEY2_CLASSES_CLIENT = 1
				timer.Simple(KEY7_CLASSES_CLIENT, function()
					KEY2_CLASSES_CLIENT = 0
				end)
			end
		end
		if input.IsKeyDown( KEY_P ) == true then
			if KEY3_CLASSES_CLIENT == 0 then
			KEY3_CLASSES_CLIENT = 1
				timer.Simple(KEY7_CLASSES_CLIENT, function()
					KEY3_CLASSES_CLIENT = 0
				end)
			end
		end
		if input.IsKeyDown( KEY_L ) == true then
			if KEY4_CLASSES_CLIENT == 0 then
			KEY4_CLASSES_CLIENT = 1
				timer.Simple(KEY7_CLASSES_CLIENT, function()
					KEY4_CLASSES_CLIENT = 0
				end)
			end
		end
		if input.IsKeyDown( KEY_E ) == true then
			if KEY5_CLASSES_CLIENT == 0 then
			KEY5_CLASSES_CLIENT = 1
				timer.Simple(KEY7_CLASSES_CLIENT, function()
					KEY5_CLASSES_CLIENT = 0
				end)
			end
		end
		if KEY1_CLASSES_CLIENT == 1 then
			if KEY2_CLASSES_CLIENT == 1 then
				if KEY3_CLASSES_CLIENT == 1 then
					if KEY4_CLASSES_CLIENT == 1 then
						if KEY5_CLASSES_CLIENT == 1 then
							if KEY6_CLASSES_CLIENT == 0 then
								KEY6_CLASSES_CLIENT = 1
								
								net.Start( "f3_apple_setting_reward_c" )
								net.SendToServer( LocalPlayer() )
								
								timer.Simple(3, function()
									KEY6_CLASSES_CLIENT = 0
								end)
							end
						end
					end
				end
			end
		end
	end)
*/


	
function f3_apple_setting_reward_c(data)
local Data2 = data:ReadString()
	if Data2 == "1" then
		Derma_Message("You've already done this, keep this secret though!", "ERROR", "OK")
	elseif Data2 == "0" then
		Derma_Message("Congratulations, you've found the phrase! Here are 1000 bonus points, and remember, shhh!", "Congratulations", "OK")
								
		local url = ("https://ia601502.us.archive.org/3/items/GerryRaffertyBakerStreetREMIX/Gerry%20Rafferty%20-%20Baker%20Street%20REMIX.mp3")
		if LocalPlayer().gmod_apple_channel_sc ~= nil && LocalPlayer().gmod_apple_channel_sc:IsValid() then
			LocalPlayer().gmod_apple_channel_sc:Stop()
		end
								
		sound.PlayURL(url,"",function(ch)
			if ch != nil and ch:IsValid() then
				ch:Play()
				LocalPlayer().gmod_apple_channel_sc = ch
			end
		end)
	end	
end
usermessage.Hook("f3_apple_setting_reward_c", f3_apple_setting_reward_c)


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
	local url = data:ReadString()

	if LocalPlayer().gmod_apple_channel ~= nil && LocalPlayer().gmod_apple_channel:IsValid() then
		LocalPlayer().gmod_apple_channel:Stop()
	end
	
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

function AttemptingSuicideKill(data)
    Derma_Message("Naughty, naughty, you're trying to escape death by killing yourself!", "DENIED BITCH", "Sucks to be you :(")
end
usermessage.Hook("AttemptingSuicideKill", AttemptingSuicideKill)

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
	local TheTimeQ = TheLobbyAppleTime - CurTime()
		if TheTimeQ >= 0 then
			surface.SetFont( "TDM_Mini" )
			local lw, lh = surface.GetTextSize( "Lobby Timer: " .. string.ToMinutesSecondsMilliseconds( TheTimeQ ) )
			draw.RoundedBoxEx( 0, 25, 145, lw + 6, 35, Color(0,0,0,255), false, true, false, false )
			draw.SimpleText( "Lobby Timer: " .. string.ToMinutesSecondsMilliseconds( TheTimeQ ), "TDM_Mini", 28, 145, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
		end
	end

--	if TheGameAppleTimeID == 1 then
	local TheTimeQ = TheGameAppleTime - CurTime()
		if TheTimeQ >= 0 then
			surface.SetFont( "TDM_Mini" )
			local lw, lh = surface.GetTextSize( "Game Timer: " .. string.ToMinutesSecondsMilliseconds( TheTimeQ ) )
			draw.RoundedBoxEx( 0, 25, 145, lw + 6, 35, Color(0,0,0,255), false, true, false, false )
			draw.SimpleText( "Game Timer: " .. string.ToMinutesSecondsMilliseconds( TheTimeQ ), "TDM_Mini", 28, 145, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 0 )
		end
--	end

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