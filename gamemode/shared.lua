
--[[---------------------------------------------------------

  Apple's Gamemode

  This was made by Dr. Apple

-----------------------------------------------------------]]


-- General Gamemode Information
GM.Name 	= "Apple's TDM 1.03" --Set the gamemode name
GM.Author 	= "Dr. Apple" --Set the author name
GM.Email 	= "support@f4egaming.com" --Set the author email
GM.Website 	= "http://www.f4egaming.com" --Set the author website


-- Setting up default teams
team.SetUp( 0, "Waiting to Spawn", Color(100,100,100,100), false)

if CLIENT then
	function PlayerInitialSpawnTeams(data)
		team.SetUp( data:ReadShort(), data:ReadString(), Color(data:ReadShort(),data:ReadShort(),data:ReadShort(),data:ReadShort()), true)
	end
	usermessage.Hook("PlayerInitialSpawnTeams", PlayerInitialSpawnTeams)
end


if SERVER then

	function CreateTeamsForServer()
	local SharedLuaTeamInfo = sql.Query( "SELECT * from apple_deathmatch_team" )
	if SharedLuaTeamInfo == nil then return end
		if sql.TableExists( "apple_deathmatch_team" ) == true then 
			for k, v in pairs(SharedLuaTeamInfo) do
				team.SetUp( tonumber(v['ID']), tostring(v['TeamName']), Color(tonumber(v['Red']),tonumber(v['Green']),tonumber(v['Blue']),tonumber(v['Y'])), true)
				sql.Query( "UPDATE apple_deathmatch_team SET Kills = '0', Deaths = '0', Score = '0' WHERE ID = '"..v['ID'].."'" )
			end
		end
	end
	
	/*
	function ClearPlayersFromActive()
	local PlayersFromActive = sql.Query( "SELECT * from apple_deathmatch_active_players" )
	if PlayersFromActive == nil then return end
		if sql.TableExists( "apple_deathmatch_active_players" ) == true then 
			for k, v in pairs(PlayersFromActive) do
				sql.Query( "DELETE FROM apple_deathmatch_active_players WHERE ID = '"..v['ID'].."'" )
			end
		end
	end
	*/

	timer.Simple(3, function()
		CreateTeamsForServer()
	--	ClearPlayersFromActive()
	end)
	
	function PlayerInitialSpawnTeams(ply)
	local SharedLuaTeamInfo = sql.Query( "SELECT * from apple_deathmatch_team" )
		for k, v in pairs(SharedLuaTeamInfo) do
			umsg.Start( "PlayerInitialSpawnTeams", ply )
				umsg.Short(v['ID'])
				umsg.String(v['TeamName'])
				umsg.Short(v['Red'])
				umsg.Short(v['Green'])
				umsg.Short(v['Blue'])
				umsg.Short(v['Y'])
			umsg.End()
		end
	end
	
	hook.Add("PlayerInitialSpawn", "PlayerInitialSpawnTeams", PlayerInitialSpawnTeams)
end