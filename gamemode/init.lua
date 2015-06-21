
--[[---------------------------------------------------------

  Apple's Gamemode

  This was made by Dr. Apple

-----------------------------------------------------------]]

-- Adding including files
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( 'menu/soundmenu.lua' )
AddCSLuaFile( 'menu/materialsmenu.lua' )
AddCSLuaFile( 'menu/f1_menu.lua' )
AddCSLuaFile( 'menu/f2_menu.lua' )
AddCSLuaFile( 'menu/f3_menu.lua' )
AddCSLuaFile( 'menu/f3_menu_ranks.lua' )
AddCSLuaFile( 'menu/f3_menu_classes.lua' )
AddCSLuaFile( 'menu/f3_menu_shop.lua' )
AddCSLuaFile( 'menu/f4_menu.lua' )
AddCSLuaFile( 'menu/classes_menu.lua' )
AddCSLuaFile( 'menu/cl_adci_teams.lua' )
AddCSLuaFile( 'hud/cl_apple_hud.lua' )
AddCSLuaFile( 'hud/cl_apple_hud_fonts.lua' )
AddCSLuaFile( "shared.lua" )

include( 'teamcreation/sv_createteam.lua' )
include( 'settings.lua' )
include( 'menu/f1_menu.lua' )
include( 'menu/f2_menu.lua' )
include( 'menu/f3_menu.lua' )
include( 'menu/f3_menu_ranks.lua' )
include( 'menu/f3_menu_classes.lua' )
include( 'menu/f3_menu_shop.lua' )
include( 'menu/f4_menu.lua' )
include( 'menu/classes_menu.lua' )
include( 'hud/sv_apple_hud.lua' )
include( 'teamspawning/sv_teamspawning.lua' )
include( 'teamweapons/sv_teamweapons.lua' )
include( 'teammodels/sv_teammodels.lua' )
include( 'shared.lua' )

resource.AddSingleFile( "sound/apples_tdm_gm/final_count.mp3" )
resource.AddSingleFile( "sound/apples_tdm_gm/wedding.mp3" )
resource.AddSingleFile( "materials/apple_hud/armoricon.png" )
resource.AddSingleFile( "materials/apple_hud/hpicon.png" )
util.PrecacheSound("sound/apples_tdm_gm/final_count.mp3")
util.PrecacheSound("sound/apples_tdm_gm/wedding.mp3")
GlobalizationStartTimerForGamemodeApple = 0
THEGAMEISOVERDONOTFIREANYMORE = 0

/*
function Stamina_MainThink()
	for k, v in pairs(player.GetAll()) do
		MsgN(v:GetMoveType())
	end
end
hook.Add( "Think", "Stamina_MainThink", Stamina_MainThink )
*/

-- Initiates joining a team
function GM:PlayerInitialSpawn(ply)
	if ply:IsValid() == false then return end
		CheckPlayerDatabase( ply ) -- Checks to see if the player exists in the database.
		ply:SetTeam(0)
		timer.Simple( 0.5, function()
			CheckGameTime(ply) -- This will see if there are any other players playing at the moment
		end)
		
		timer.Simple( 1.5, function()
			umsg.Start( "FetchRankandNum", ply )
				umsg.String(sql.QueryValue( "SELECT Rank FROM apple_deathmatch_player_103 WHERE SteamID = '"..tostring(ply:UniqueID()).."';" ))
				umsg.String(sql.QueryValue( "SELECT RankNum FROM apple_deathmatch_player_103 WHERE SteamID = '"..tostring(ply:UniqueID()).."';" ))
				umsg.String(sql.QueryValue( "SELECT RankMat FROM apple_deathmatch_player_103 WHERE SteamID = '"..tostring(ply:UniqueID()).."';" ))
				umsg.Entity(ply)
			umsg.End()
		end)
			
	for k, v in pairs(player.GetAll()) do -- Get a list of all players playing
		TopAllPlayersExisting = k
	end

	local SettingInfoIntro = sql.QueryValue( "SELECT Value FROM apple_deathmatch_settings WHERE ID = '3';" )
	local SettingInfoIntroChk = sql.QueryValue( "SELECT Value FROM apple_deathmatch_settings WHERE ID = '4';" )
	local SettingInfoIntroTime = sql.QueryValue( "SELECT Value FROM apple_deathmatch_settings WHERE ID = '5';" )
	if tonumber(SettingInfoIntroChk) == 1 then
		umsg.Start( "TheGameAppleIntro", ply )
			umsg.String(SettingInfoIntro)
			umsg.String(SettingInfoIntroTime)
		umsg.End()
	end
	
	
	if TopAllPlayersExisting == 2 then -- If two players are playing, begin the countdown
		LobbyTimerApple = math.Round(CurTime()) + 60 -- Lobby timer is 60 seconds, might make it a variable later if not already a variable
		
		if timer.Exists( "AppleCountDownStart" ) == true then -- If the timer already exists, meaning the second player left and a new one has come
			timer.Remove( "AppleCountDownStart" ) 
		end	
	
		timer.Create( "AppleCountDownStart", 60, 1, function() -- After 60 seconds passes, close the 'lobby' and spawn all the players who are in spectator mde
			GlobalizationStartTimerForGamemodeApple = 1
			local SettingInfoTime = sql.QueryValue( "SELECT Value from apple_deathmatch_settings WHERE ID = '2';" )
			if SettingInfoTime == nil then return end
			local SettingInfoTime = (SettingInfoTime * 60)
			GlobalSettingInfoTime = (CurTime() + SettingInfoTime)
			for k, v in pairs(player.GetAll()) do
				v:UnSpectate()
				v:StripWeapons()
				v:StripAmmo()
				v:Spawn()
				umsg.Start( "TheGameAppleTimeFunc", v )
					umsg.Short(1)
					umsg.Short(GlobalSettingInfoTime)
				umsg.End()
			end
			EndofGame()
		end)
		
		timer.Create( "AppleCountDownStartSound", 50, 1, function() -- Plays the sound at 50
			for k, v in pairs(player.GetAll()) do
				umsg.Start( "AppleCountDownStartSound", v )
				umsg.End()
			end
		end)
		
		for k, v in pairs(player.GetAll()) do -- Just displays the timer for the first and second player
			umsg.Start( "LobbyTimerApple", v )
				umsg.Short(1)
				umsg.Short(LobbyTimerApple)
			umsg.End()
		end
		
		f2_menu_apple_fill_gen_players() -- Refills the menu for the administrative menu if anyone has it open
		
	elseif TopAllPlayersExisting == 1 then -- Because if I didn't list this, else would be considered as first player too
	
		f2_menu_apple_fill_gen_players() -- Refills the menu for the administrative menu if anyone has it open
	
	elseif THEGAMEISOVERDONOTFIREANYMORE == 1 then
		CheckMVP(THEGAMEISOVERDONOTFIREANYMOREID)
		return
	else -- This is for if there are already two players, then display the thing
		if GlobalizationStartTimerForGamemodeApple == 0 then
			umsg.Start( "LobbyTimerApple", ply )
				umsg.Short(1)
				umsg.Short(LobbyTimerApple)
			umsg.End()
		elseif GlobalizationStartTimerForGamemodeApple == 1 then
			umsg.Start( "TheGameAppleTimeFunc", ply )
				umsg.Short(1)
				umsg.Short(GlobalSettingInfoTime)
			umsg.End()
		end
	
		f2_menu_apple_fill_gen_players() -- Refills the menu for the administrative menu if anyone has it open
	end
end

function EndofGameA()
	local WhoHighest = sql.QueryValue( "SELECT ID FROM apple_deathmatch_team ORDER BY Kills DESC LIMIT 1;" )
					/*
					for k, v in pairs(player.GetAll()) do
						if v:Team() == tonumber(WhoHighest) then
							GetStupidID = v
						end
					end
					*/
					
	THEGAMEISOVERDONOTFIREANYMORE = 1
					
	local p = (team.GetPlayers(tonumber(WhoHighest)))[1]
	if p != nil then
		THEGAMEISOVERDONOTFIREANYMOREID = p
		local maxKills = p:Frags()
		for k,v in pairs(team.GetPlayers(tonumber(WhoHighest))) do
			if v:Frags() > maxKills then
				p = v
				maxKills = v:Frags()
			end
		SpectateMVP(p)
		end
	else
		MsgN("NO MVP")
		FindANewMapForUsOky()
	end

	local CheckWinSound = sql.QueryValue( "SELECT WinSound from apple_deathmatch_team WHERE ID = '"..tostring(WhoHighest).."';" )
	if CheckWinSound != nil || CheckWinSound != "NULL" then
		for k, v in pairs(player.GetAll()) do
			umsg.Start( "PlayWinSoundForAll", v ) -- Because I can't seem to find a way to get weapons names without going to client, I send info to client and get it back
				umsg.String(CheckWinSound)
			umsg.End()
		end
	end
end

function EndofGame()
	local SettingInfoTime = sql.QueryValue( "SELECT Value from apple_deathmatch_settings WHERE ID = '2';" )
	if SettingInfoTime == nil then return end
	local SettingInfoTime = (SettingInfoTime * 60)
	timer.Create("GameTimerCur",SettingInfoTime, 1, function()
		EndofGameA()
	end)
end

function GM:PlayerDisconnected( ply )

	if ply:GetMoveType() == 2 then -- Because we don't like people who leave during matches, we mark those who leave during the matches.
	-- I don't think I'm going to make a punishment system for those who leave, I'll just leave that up to whoever even cares about that.
		local GetTotalDisconnections = tonumber(sql.QueryValue( "SELECT dsc from apple_deathmatch_player_103 WHERE SteamID = '"..tostring(ply:UniqueID()).."';" ))
		sql.Query( "UPDATE apple_deathmatch_player_103 SET dsc = '"..(GetTotalDisconnections+1).."' WHERE SteamID = '"..tostring(ply:UniqueID()).."'" )
		if sql.LastError() != nil then
			 -- MsgN("init.lua: "..sql.LastError())
		end
	end

	timer.Simple(1, function() -- This entire function here is for if the player leaves, stop everything
		local HowManyPlayersLeft = 0
		for k, v in pairs(player.GetAll()) do
			HowManyPlayersLeft = k
		end
		
		if HowManyPlayersLeft < 2 then
			if GlobalizationStartTimerForGamemodeApple == 1 then -- If the game has already been started, end the game and declare winner!
				EndofGameA()
				umsg.Start( "TheGameAppleTimeFunc", v )
					umsg.Short(0)
					umsg.Short(0)
				umsg.End()
				timer.Remove( "GameTimerCur" )
			elseif GlobalizationStartTimerForGamemodeApple == 0 then
				timer.Remove( "AppleCountDownStart" ) -- Removes the timer
				timer.Remove( "AppleCountDownStartSound" ) -- Removes the timer that plays the sound
				timer.Remove( "GameTimerCur" ) -- Removes the timer that stops the game
				for k, v in pairs(player.GetAll()) do
					umsg.Start( "LobbyTimerApple", v )
						umsg.Short(0)
						umsg.Short(0)
					umsg.End()
				--	if v:GetMoveType() == 2 then -- If the game has already started, put them back into spectator mode
				--		GAMEMODE:PlayerSpawnAsSpectator( v )
				--	end
				end
			end
		end
	end)
end



function ClassesSystemActivated( ply )
	if tonumber(sql.QueryValue( "SELECT Value FROM apple_deathmatch_settings WHERE ID = '11';" )) == 1 then
		timer.Simple(3, function()
			umsg.Start( "Classes_System_Menu", ply )
			--	umsg.Entity(ply)
			umsg.End()
		end)
	end
end



function PlaceMeOnTheLowestTeamAvaialable( ply ) -- Find the lowest team available, hopefully Garry' fully fixed this
	ply:SetTeam(team.BestAutoJoinTeam())
	---- MsgN(team.GetName(ply:Team()).."("..ply:Team()..")")
end

function CheckGameTime(ply) -- This will see if there are any other players playing at the moment
local CheckGameTimeTeamInfo = sql.QueryValue( "SELECT COUNT(ID) from apple_deathmatch_team;" ) -- Count how many teams exist
--local TeamCounter = 0 
	if CheckGameTimeTeamInfo == nil then return end -- If no teams exist, well not only is there an issue, but the gamemode will just break
	
--	for i=1,CheckGameTimeTeamInfo do -- To get a number of all the players playing on all the teams
--		TeamCounter = TeamCounter + team.NumPlayers(i)
--	end

	for k, v in pairs(player.GetAll()) do
		PlayerCounterAll = k
	end
	
	local function PlaceSecondPlayerOnTeam(ply) -- Literally just places the second player on every other team
	local CheckGameTimeTeamInfo = sql.QueryValue( "SELECT COUNT(ID) from apple_deathmatch_team;" ) -- Count again
	local PickTeamRandom = math.random( 1, CheckGameTimeTeamInfo ) -- Pick a random number 
	local GetTeamPlayers = team.NumPlayers(PickTeamRandom) -- Find out how many players are on this team
		if GetTeamPlayers == 1 then -- if there is already a player on here, place me on the other team. Currently the gamemode would break if there is one team, so I need to fix this if not already
			PlaceSecondPlayerOnTeam(ply) -- The server wants me to be on a two man team, so we gotta fix that
		else
			ply:SetTeam(PickTeamRandom) -- Server picked a team, now time to place us here
		end
	end
	
	local function YouChooseMeToSpectate(ply) -- So because the game is already in action, now we need to choose a player to spectate, this is still bugged and most likely will remain like this
		for k, v in pairs(player.GetAll()) do
			YouChooseMeToSpectatePlayerCounter = k
		end
		if YouChooseMeToSpectatePlayerCounter == 1 then return end -- Just in case somehow the player is faster then he CPU, and he leaves, then just kill this or the server will go crazy and die
		local PickAPlayerToSpectate = math.random( 1, YouChooseMeToSpectatePlayerCounter ) -- Finds a random player to spectate
		for k, v in pairs(player.GetAll()) do
			if PickAPlayerToSpectate == k then -- Found player to sepctate, time to do checks
				if v == ply then -- If the player it choose was me, try again till it isn't
					YouChooseMeToSpectate(ply) -- It choose me, so it has to choose another person. Thankfully the CPU can literally do hundreds of these in 1 second
				else
					ply:Spectate( OBS_MODE_IN_EYE )
					ply:SpectateEntity(v)
					ply:SetPData("PickAPlayerToSpectate", PickAPlayerToSpectate) -- Just the number of the player who we are spectating
					timer.Simple(2, function()
						umsg.Start( "PlayerIsSpectating", ply ) -- Give the HUD the information on who we are spectating
							umsg.Short(1)
							umsg.Short(team.GetColor(v:Team()).r)
							umsg.Short(team.GetColor(v:Team()).g)
							umsg.Short(team.GetColor(v:Team()).b)
							umsg.String(v:Nick())
						umsg.End()
					end)
				end
			end
		end
	end
	
	if PlayerCounterAll <= 1 then -- Checks to see if no players are on, then just place the first guy on a random team
		GAMEMODE:PlayerSpawnAsSpectator( ply )
		ply:SetTeam(math.random( 1, CheckGameTimeTeamInfo )) -- Just find a random team to be apart of
		ClassesSystemActivated( ply )
	elseif PlayerCounterAll == 2 then -- If one person is on, and you're going to be the second person, then place you on another team other than the first guy
		GAMEMODE:PlayerSpawnAsSpectator( ply )
		PlaceSecondPlayerOnTeam(ply)
		ClassesSystemActivated( ply )
	elseif GlobalizationStartTimerForGamemodeApple == 1 then -- The game has started, so place spectator mode, and find a player to spectate
		GAMEMODE:PlayerSpawnAsSpectator( ply )
		YouChooseMeToSpectate(ply) -- This chooses a players to spectate, and also makes sure it's not the player himself
	else
		GAMEMODE:PlayerSpawnAsSpectator( ply ) -- This is for if the game hasn't started, and there are more than two players
		PlaceMeOnTheLowestTeamAvaialable( ply ) -- This places the person on the next following team with the lowest number of people on it
		ClassesSystemActivated( ply )
	end

end


NewPlayerOnSpectate = 0 -- This is bullshit, but thankfully Garry allows me to work with bullshit
function GM:KeyPress( ply, keypressed ) -- This is the system that allows us to decide what players we want to look at ourselves
if THEGAMEISOVERDONOTFIREANYMORE == 1 then return end
	if ply:GetMoveType() == 0 then
	
		
		for k,v in pairs(player.GetAll()) do
			TotalPlayersOnSpectate = k
		end
		
	
		
		if keypressed == IN_ATTACK then -- Left Click
			NewPlayerOnSpectate = NewPlayerOnSpectate - 1 -- Because left is down, just goes does
			if NewPlayerOnSpectate <= 0 then -- If the number is at one, and is trying to go below one, then reset to the highest number again
				NewPlayerOnSpectate = TotalPlayersOnSpectate -- Reset the thing to the top amount of players
			end
			/*
			function LEFTCLICKSPECTATE(NewPlayerOnSpectate)
				for k, v in pairs(player.GetAll()) do
					if NewPlayerOnSpectate == k then -- If the player exists, lets do it
						if v:GetMoveType() == 0 then -- If they are spectators too, then don't spectate them please
							NewPlayerOnSpectate = NewPlayerOnSpectate - 1 -- Go down
							LEFTCLICKSPECTATE(NewPlayerOnSpectate) -- Check to see if the player is a spectator again
						end
					end
				end
			end
			
			if NewPlayerOnSpectate == 1 then -- if the thing is at one, then reset to the top
				NewPlayerOnSpectate = TotalPlayersOnSpectate
			end
			
			LEFTCLICKSPECTATE(NewPlayerOnSpectate)
			*/
		end
		

		if keypressed == IN_ATTACK2 then -- Right Click
			NewPlayerOnSpectate = NewPlayerOnSpectate + 1
			/*
			function RIGHTCLICKSPECTATE()
				for k, v in pairs(player.GetAll()) do
					if NewPlayerOnSpectate == k then
						if v:GetMoveType() == 0 then
							NewPlayerOnSpectate = NewPlayerOnSpectate + 1
							RIGHTCLICKSPECTATE()
						end
					end
				end
			end
			*/
			if NewPlayerOnSpectate > TotalPlayersOnSpectate then
				NewPlayerOnSpectate = 1
			end
			--RIGHTCLICKSPECTATE()
		end

		
		for k, v in pairs(player.GetAll()) do
			if NewPlayerOnSpectate == k then
				ply:SpectateEntity(v)
				ply:SetPData("PickAPlayerToSpectate", k)
				umsg.Start( "PlayerIsSpectating", ply )
					umsg.Short(1)
					umsg.Short(team.GetColor(v:Team()).r)
					umsg.Short(team.GetColor(v:Team()).g)
					umsg.Short(team.GetColor(v:Team()).b)
					umsg.String(v:Nick())
				umsg.End()
			end
		end
	end
end



-- Checks to see if the player exists in the database | I wouldn't mess with this, just saying
function CheckPlayerDatabase( ply )
	local PlayerInfo = sql.QueryValue( "SELECT cont from apple_deathmatch_player_103 WHERE SteamID = '"..tostring(ply:UniqueID()).."';" )
	if PlayerInfo == nil then
		sql.Query( "INSERT INTO apple_deathmatch_player_103 ( `SteamID`, `PlayerName`, `Kills`, `Deaths`, `Score`, `LifeScore`, `Ratio`, `RankNum`, `Rank`, `RankMat`, `dsc`, `time`, `cont` ) VALUES ( '"..tostring(ply:UniqueID()).."', "..tostring(sql.SQLStr(ply:Nick()))..", '0', '0', '0', '0', '0', '0', 'Newb', 'apple_ranks/1.png', '0', '0', '1' )" )
		-- MsgN(ply:Nick().. " was added to the players database.")
		if sql.LastError() != nil then
			 -- MsgN("init.lua: "..sql.LastError())
		end
	else
		sql.Query( "UPDATE apple_deathmatch_player_103 SET cont = '"..(PlayerInfo+1).."' WHERE SteamID = '"..tostring(ply:UniqueID()).."'" )
		if sql.LastError() != nil then
			 -- MsgN("init.lua: "..sql.LastError())
		end
	end
	-- Favorite gun table
	if sql.TableExists( "apple_deathmatch_fav_gun"..tostring(ply:UniqueID()).."" ) == false then
		sql.Query( "CREATE TABLE apple_deathmatch_fav_gun"..tostring(ply:UniqueID()).." ( SteamID varchar(255), weapon_name varchar(255), weapon_name_nice varchar(255), Kills int )" )
		-- MsgN(ply:Nick().. " was added to the favorite guns database.")
		if sql.LastError() != nil then
			 -- MsgN("init.lua: "..sql.LastError())
		end
	end
	umsg.Start( "HUD_GET_POINTS", ply ) -- Because I can't seem to find a way to get weapons names without going to client, I send info to client and get it back
		umsg.Short(sql.QueryValue( "SELECT Score FROM apple_deathmatch_player_103 WHERE SteamID = '"..tostring(ply:UniqueID()).."';" ))
	umsg.End()
end


-- Check to see if the players table exists
if sql.TableExists( "apple_deathmatch_player_103" ) == false then
	sql.Query( "CREATE TABLE apple_deathmatch_player_103 ( SteamID varchar(255), PlayerName varchar(255), Kills int, Deaths int, Score int, LifeScore int, Ratio float, RankNum int, Rank varchar(255), RankMat varchar(255), dsc int, time int, cont int )" )
	-- MsgN("Creating table for players")
	if sql.LastError() != nil then
		 -- MsgN("init.lua: "..sql.LastError())
	end
end


-- Check to see if the teams table exists
if sql.TableExists( "apple_deathmatch_team" ) == false then
	sql.Query( "CREATE TABLE apple_deathmatch_team ( ID int, TeamName varchar(255), Kills int, Deaths int, Score int, Red int, Blue int, Green int, Y int, WhoCreatedMe varchar(255), WhoCreatedMeID varchar(255), WhatTime varchar(255), WinSound varchar(255) )" )
	-- MsgN("Creating table for teams")
	
	if sql.LastError() != nil then
		 -- MsgN("init.lua: "..sql.LastError())
	end
	
	sql.Query( "INSERT INTO apple_deathmatch_team ( `ID`, `TeamName`, `Kills`, `Deaths`, `Score`, `Red`, `Blue`, `Green`, `Y`, `WhoCreatedMe`, `WhoCreatedMeID`, `WhatTime`, `WinSound` ) VALUES ( '1', 'Red', '0', '0', '0', '255', '0', '0', '255', 'SYSTEM', 'SYSTEM', "..sql.SQLStr(tostring(os.date( "%X - %m/%d/%Y" , os.time() )))..", 'music/hl2_song23_suitsong3.mp3' )" )
	sql.Query( "INSERT INTO apple_deathmatch_team ( `ID`, `TeamName`, `Kills`, `Deaths`, `Score`, `Red`, `Blue`, `Green`, `Y`, `WhoCreatedMe`, `WhoCreatedMeID`, `WhatTime`, `WinSound` ) VALUES ( '2', 'Blue', '0', '0', '0', '0', '255', '0', '255', 'SYSTEM', 'SYSTEM', "..sql.SQLStr(tostring(os.date( "%X - %m/%d/%Y" , os.time() )))..", 'music/hl2_song23_suitsong3.mp3' )" )
	--	sql.Query( "INSERT INTO apple_deathmatch_team ( `ID`, `TeamName`, `Kills`, `Deaths`, `Score`, `Red`, `Blue`, `Green`, `Y`, `WhoCreatedMe`, `WhoCreatedMeID`, `WhatTime` ) VALUES ( '3', 'Green', '0', '0', '0', '0', '0', '255', '255', 'SYSTEM', 'SYSTEM', "..sql.SQLStr(tostring(os.date( "%X - %d/%m/%Y" , os.time() ))).." )" )
	-- MsgN("Creating default teams: Red")
	-- MsgN("Creating default teams: Blue")
end


-- Adds score to players who kill
function GM:PlayerDeath( victim, weapon, attacker )
if IsValid(attacker) == false || attacker:IsValid() == false then return end
local VictimInfo = sql.Query( "SELECT * from apple_deathmatch_player_103 WHERE SteamID = '"..tostring(victim:UniqueID()).."';" ) -- Gets Victims Informations
	for k, v in pairs(VictimInfo) do
		VictimKills = tonumber(v['Kills'])
		VictimDeaths = tonumber(v['Deaths'])
		VictimScore = tonumber(v['Score'])
	--	VictimRatio = tonumber(v['Ratio']) -- I don't really need this, but I'll just keep it commented out.
	end
local AttackerInfo = sql.Query( "SELECT * from apple_deathmatch_player_103 WHERE SteamID = '"..tostring(attacker:UniqueID()).."';" ) -- Gets the Attackers Informations
	for k, v in pairs(AttackerInfo) do
		AttackerKills = tonumber(v['Kills'])
		AttackerDeaths = tonumber(v['Deaths'])
		AttackerScore = tonumber(v['Score'])
	--	AttackerRatio = tonumber(v['Ratio']) -- I don't really need this, but I'll just keep it commented out too.
	end
	
	if victim == attacker || attacker == victim then -- Player just killed himself?
		local VictimDeaths = VictimDeaths + 1
		local VictimScore = VictimScore - 10
		local VictimRatio = VictimKills/VictimDeaths
		sql.Query( "UPDATE apple_deathmatch_player_103 SET Deaths = '"..VictimDeaths.."', Score = '"..VictimScore.."', Ratio = '"..VictimRatio.."' WHERE SteamID = '"..tostring(victim:UniqueID()).."'" )
		if sql.LastError() != nil then
			 -- MsgN("init.lua: "..sql.LastError())
		end
	return end
	
	if attacker:Team() == victim:Team() then -- Are players on the same team?
		local AttackerScore = AttackerScore - 10
		sql.Query( "UPDATE apple_deathmatch_player_103 SET Score = '"..AttackerScore.."' WHERE SteamID = '"..tostring(attacker:UniqueID()).."'" )
		if sql.LastError() != nil then
			 -- MsgN("init.lua: "..sql.LastError())
		end		
	return end
	
	if attacker:Team() != victim:Team() && attacker != victim then -- Are players not on the same team, and are they not themselves?
		local AttackerScore = AttackerScore + 10
		local AttackerKills = AttackerKills + 1
		local VictimDeaths = VictimDeaths + 1
		local AttackerRatio = AttackerKills/AttackerDeaths
		local VictimRatio = VictimKills/VictimDeaths
		sql.Query( "UPDATE apple_deathmatch_player_103 SET Score = '"..AttackerScore.."', Kills = '"..AttackerKills.."', Ratio = '"..AttackerRatio.."' WHERE SteamID = '"..tostring(attacker:UniqueID()).."'" )
		if sql.LastError() != nil then
			 -- MsgN("init.lua: "..sql.LastError())
		end
		sql.Query( "UPDATE apple_deathmatch_player_103 SET Deaths = '"..VictimDeaths.."', Ratio = '"..VictimRatio.."' WHERE SteamID = '"..tostring(victim:UniqueID()).."'" )
		if sql.LastError() != nil then
			 -- MsgN("init.lua: "..sql.LastError())
		end
		
		local CheckRankNowN = sql.QueryValue( "SELECT Kills FROM apple_deathmatch_player_103 WHERE SteamID = '"..tostring(attacker:UniqueID()).."'" )
		local CheckRankNowID = sql.QueryValue( "SELECT ID FROM apple_deathmatch_ranks WHERE Req = '"..CheckRankNowN.."'" )
		if CheckRankNowID != nil then
				local CheckSettingSeven = sql.QueryValue( "SELECT Value FROM apple_deathmatch_settings WHERE ID = '7'" )
				local CheckSettingEight = sql.QueryValue( "SELECT Value FROM apple_deathmatch_settings WHERE ID = '8'" )
				local CheckSettingNine = sql.QueryValue( "SELECT Value FROM apple_deathmatch_settings WHERE ID = '9'" )
				local CheckSettingTen = sql.QueryValue( "SELECT Value FROM apple_deathmatch_settings WHERE ID = '10'" )
				
				umsg.Start( "AppleRankUpSoundEffect", attacker )
					umsg.String(CheckSettingNine)
					umsg.String(CheckSettingTen)
					umsg.Entity(attacker)
				umsg.End()
				
				if CheckSettingEight == "1" then
					ScoreEarnedFromLevelUp = (tonumber(CheckRankNowID) * tonumber(CheckSettingSeven))
				elseif CheckSettingEight == "0" then
					ScoreEarnedFromLevelUp = tonumber(CheckSettingSeven)
				end
				
				local AttackerScore = AttackerScore + ScoreEarnedFromLevelUp
				
				sql.Query( "UPDATE apple_deathmatch_player_103 SET Score = '"..AttackerScore.."' WHERE SteamID = '"..tostring(attacker:UniqueID()).."'" )
		
			local CheckRankNowRN = sql.QueryValue( "SELECT RankName FROM apple_deathmatch_ranks WHERE ID = '"..CheckRankNowID.."'" )
			local CheckRankNowRM = sql.QueryValue( "SELECT Material FROM apple_deathmatch_ranks WHERE ID = '"..CheckRankNowID.."'" )
			umsg.Start( "FetchRankandNum", attacker )
				umsg.String(CheckRankNowRN)
				umsg.String(CheckRankNowID)
				umsg.String(CheckRankNowRM)
				umsg.Entity(attacker)
			umsg.End()
			sql.Query( "UPDATE apple_deathmatch_player_103 SET Rank = "..(sql.SQLStr(CheckRankNowRN))..", RankNum = '"..CheckRankNowID.."', RankMat = "..(sql.SQLStr(CheckRankNowRM)).." WHERE SteamID = '"..tostring(attacker:UniqueID()).."'" )
		end
		
		
		local GetTotalKillsForTeam = sql.QueryValue( "SELECT Kills from apple_deathmatch_team WHERE ID = "..tonumber(attacker:Team())..";" )
		local GetTotalKillsForTeam3 = sql.QueryValue( "SELECT Score from apple_deathmatch_team WHERE ID = "..tonumber(attacker:Team())..";" )
		local GetTotalKillsForTeam2 = sql.QueryValue( "SELECT Deaths from apple_deathmatch_team WHERE ID = "..tonumber(victim:Team())..";" )
		sql.Query( "UPDATE apple_deathmatch_team SET Kills = '"..tonumber(GetTotalKillsForTeam+1).."', Score = '"..tonumber(GetTotalKillsForTeam3+10).."' WHERE ID = "..tonumber(attacker:Team()).."" )
		if sql.LastError() != nil then
			 -- MsgN("init.lua: "..sql.LastError())
		end
		sql.Query( "UPDATE apple_deathmatch_team SET Deaths = '"..tonumber(GetTotalKillsForTeam2+1).."' WHERE ID = "..tonumber(victim:Team()).."" )
		if sql.LastError() != nil then
			 -- MsgN("init.lua: "..sql.LastError())
		end
		team.SetScore(attacker:Team(), tonumber(GetTotalKillsForTeam3+10))
		
		umsg.Start( "HUD_GET_POINTS", attacker ) -- Because I can't seem to find a way to get weapons names without going to client, I send info to client and get it back
			umsg.Short(tonumber(sql.QueryValue( "SELECT Score FROM apple_deathmatch_player_103 WHERE SteamID = '"..tostring(attacker:UniqueID()).."';" )))
		umsg.End()
		
		local CheckScoreCount = sql.QueryValue( "SELECT Kills from apple_deathmatch_team WHERE ID = '"..tostring(attacker:Team()).."';" )
		local GetWinAmount = sql.QueryValue( "SELECT Value FROM apple_deathmatch_settings WHERE ID = '1';" )
		
		if tonumber(CheckScoreCount) == tonumber(GetWinAmount) then -- Checks to see if the team score has been met with the game winning score

		THEGAMEISOVERDONOTFIREANYMORE = 1
		THEGAMEISOVERDONOTFIREANYMOREID = attacker
		
		CheckMVP(attacker)

			local CheckWinSound = sql.QueryValue( "SELECT WinSound from apple_deathmatch_team WHERE ID = '"..tostring(attacker:Team()).."';" )
			if CheckWinSound != nil || CheckWinSound != "NULL" then
				for k, v in pairs(player.GetAll()) do
					umsg.Start( "PlayWinSoundForAll", v ) -- Because I can't seem to find a way to get weapons names without going to client, I send info to client and get it back
						umsg.String(CheckWinSound)
					umsg.End()
				end
			end
		end
		
		
		--f2_menu_apple_fill_gen_func(ply)
		
		umsg.Start( "GetNiceNameofWeapon", attacker ) -- Because I can seem to find a way to get weapons names without going to client, I send info to client and get it back
			umsg.Entity(attacker:GetActiveWeapon())
			umsg.Entity(attacker)
		umsg.End()
	return end
end

RestartServerTimerVarGlo = nil
function FindANewMapForUsOky()
	local FindANewMapID = sql.QueryValue( "SELECT COUNT(ID) FROM apple_deathmatch_maplist" )
	local FindANewMapID = tonumber(FindANewMapID)
	if FindANewMapID == nil then 
		FoundAvailableMapToPlay = game.GetMap() 
		
	elseif FindANewMapID == 1 then
	local FindANewMap = sql.QueryValue( "SELECT Map FROM apple_deathmatch_maplist WHERE ID = '"..FindANewMapID.."'" )
		if FindANewMap == game.GetMap() then
			FoundAvailableMapToPlay = game.GetMap() 
		else
			FoundAvailableMapToPlay = FindANewMap
		end
		umsg.Start( "FoundAGreatMap" )
			umsg.Short(1)
			umsg.String(FoundAvailableMapToPlay)
		umsg.End()
		
		timer.Simple(15, function()
			game.ConsoleCommand( "changelevel ".. FoundAvailableMapToPlay.."\n" ) 
		end)
		
	elseif FindANewMapID > 1 then
		local SelectNewMap = math.random(1, FindANewMapID)
		local TakeAPeak = sql.QueryValue( "SELECT Map FROM apple_deathmatch_maplist WHERE ID = '"..tostring(SelectNewMap).."'" )
		if TakeAPeak == game.GetMap() then
			FindANewMapForUsOky()
		else
			FoundAvailableMapToPlay = TakeAPeak
			umsg.Start( "FoundAGreatMap" )
				umsg.Short(1)
				umsg.String(FoundAvailableMapToPlay)
			umsg.End()
			
			timer.Simple(15, function()
				game.ConsoleCommand( "changelevel ".. FoundAvailableMapToPlay.."\n" ) 
			end)
		end
	end
	if RestartServerTimerVarGlo == nil then
		RestartServerTimerVarGlo = math.Round(CurTime()) + 15
	end
	umsg.Start( "RestartServer2" )
		umsg.Short(1)
		umsg.Short(RestartServerTimerVarGlo)
	umsg.End()
end


function SpectateMVP(ply)

	FindANewMapForUsOky()
	
	umsg.Start( "TheGameAppleTimeFunc" )
		umsg.Short(0)
		umsg.Short(0)
	umsg.End()
	
	for k, v in pairs(player.GetAll()) do
		if ply != v then
			local PutMeBack = v:Team()
			GAMEMODE:PlayerSpawnAsSpectator( v )
			v:SetTeam(PutMeBack)
			v:Spectate( OBS_MODE_IN_EYE )
			v:SpectateEntity(ply)
			umsg.Start( "YouAreNotTheMVP", v )
				umsg.Short(1)
				umsg.String(ply:Nick())
			umsg.End()
		elseif ply == v then
			umsg.Start( "YouAreTheMVP", ply )
				umsg.Short(1)
			umsg.End()
		end
	end
end


function CheckMVP(attacker)
		local p = attacker 
		local maxKills = p:Frags()
		for k,v in pairs(team.GetPlayers(attacker:Team())) do
		if v:Frags() > maxKills then
			p = v
			maxKills = v:Frags()
		end
		SpectateMVP(p)
		if p == nil then return end
		local WhatsScore = sql.QueryValue( "SELECT Score FROM apple_deathmatch_player_103 WHERE SteamID = '"..tostring(p:UniqueID()).."';" )
		sql.Query( "UPDATE apple_deathmatch_player_103 SET Score = "..(WhatsScore+50).." WHERE SteamID = '"..tostring(p:UniqueID()).."';" )
	end
end


net.Receive( "GetNiceNameofWeapon", function( len, ply ) -- And this is where I get my weapon data back
local TheNiceNameForaWeapon = net.ReadString()
	if TheNiceNameForaWeapon == nil || ply:GetActiveWeapon():GetClass() == nil || TheNiceNameForaWeapon == "" || TheNiceNameForaWeapon == " " then return end
	local FavoriteGun = sql.QueryValue( "SELECT Kills from apple_deathmatch_fav_gun"..tostring(ply:UniqueID()).." WHERE weapon_name = "..tostring(sql.SQLStr(ply:GetActiveWeapon():GetClass()))..";" )
	if FavoriteGun == nil then
		sql.Query( "INSERT INTO apple_deathmatch_fav_gun"..tostring(ply:UniqueID()).." ( `SteamID`, `weapon_name`, `weapon_name_nice`, `Kills` ) VALUES ( "..tostring(sql.SQLStr(ply:Nick()))..", "..tostring(sql.SQLStr(ply:GetActiveWeapon():GetClass()))..", "..tostring(sql.SQLStr(TheNiceNameForaWeapon))..", '1' )" )
		-- MsgN(ply:Nick().. " was added to the gamemode's database.")
		if sql.LastError() != nil then
			 -- MsgN("init.lua: "..sql.LastError())
		end
	else
		local FavoriteGun = FavoriteGun + 1
		sql.Query( "UPDATE apple_deathmatch_fav_gun"..tostring(ply:UniqueID()).." SET Kills = '"..FavoriteGun.."', SteamID = "..tostring(sql.SQLStr(ply:Nick())).." WHERE weapon_name = "..tostring(sql.SQLStr(ply:GetActiveWeapon():GetClass())).."" )
		if sql.LastError() != nil then
			 -- MsgN("init.lua: "..sql.LastError())
		end
	end
end)


util.AddNetworkString( "GetNiceNameofWeapon" )