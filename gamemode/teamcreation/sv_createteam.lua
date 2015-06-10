-- SERVER


net.Receive( "adci_add_new_team", function( len, ply )
	GetTheTotalNumberofWeaponsForListing = 0
	local TeamModel = net.ReadTable()
	local TeamName = net.ReadString()
	local TeamWinSound = net.ReadString()
	local TeamColor = net.ReadTable()
	local TeamName = string.gsub(TeamName, "[%W]", function(a)
		if a == " " then 
			return " "
		else
			return "" 
		end
	end)
	local TeamName = string.gsub(TeamName," ","_")
	local CreateTeams = sql.Query( "SELECT * from apple_deathmatch_team WHERE TeamName = "..sql.SQLStr(tostring(TeamName))..";" )
	if CreateTeams == nil then
		if sql.LastError() != nil then
			 -- MsgN("sv_createteam.lua: "..sql.LastError())
		end
		local NiceName = "Medkit"
		local Name = "weapon_medkit"
		local FindLastID = sql.QueryValue( "SELECT ID from apple_deathmatch_team ORDER BY ID DESC LIMIT 1;" )
		sql.Query( "INSERT INTO apple_deathmatch_team ( `ID`, `TeamName`, `Kills`, `Deaths`, `Score`, `Red`, `Blue`, `Green`, `Y`, `WhoCreatedMe`, `WhoCreatedMeID`, `WhatTime`, `WinSound` ) VALUES ( '"..(FindLastID+1).."', "..sql.SQLStr(tostring(TeamName))..", '0', '0', '0', '"..(TeamColor.r).."', '"..(TeamColor.b).."', '"..(TeamColor.g).."', '"..(TeamColor.a).."', '"..ply:Nick().."', '"..ply:SteamID().."', "..sql.SQLStr(tostring(os.date( "%X - %m/%d/%Y" , os.time() )))..", "..sql.SQLStr(tostring(TeamWinSound)).." )" )
		if sql.LastError() != nil then
			 -- MsgN("sv_createteam.lua: "..sql.LastError())
		end
		CreateNewTeamWeaponDB()
		CreateNewTeamSpawningDB()
		CreateNewTeamModelsDB()
		CreateTeamsForServer()
		
		local NewTeamName_sv_teammodels = string.gsub(tostring(TeamName), " ", "_")
		local NewTeamName_sv_teammodels = sql.SQLStr("apple_deathmatch_teammodels_"..NewTeamName_sv_teammodels)
		local NewTeamName_sv_teammodels = string.gsub(NewTeamName_sv_teammodels, "'", "")
		for k, v in pairs(TeamModel) do
			GetTheTotalNumberofWeaponsForListing = GetTheTotalNumberofWeaponsForListing + 1
			sql.Query( "INSERT INTO "..NewTeamName_sv_teammodels.." (`ID`, `ModelName`, `ModelDir`) VALUES ('"..tonumber(GetTheTotalNumberofWeaponsForListing).."', '"..tostring(k).."', '"..tostring(v).."')" )
		if sql.LastError() != nil then
			 -- MsgN("sv_createteam.lua: "..sql.LastError())
		end
		end
		
		for k, v in pairs(player.GetAll()) do
			PlayerInitialSpawnTeams(v)
		end
		
		umsg.Start( "creating_teams_not_error", ply )
		umsg.End()
	else
		umsg.Start( "creating_teams_error", ply )
		umsg.End()
	end
	
--PrintTable(team.GetAllTeams())
end)


function FixTeamIDOrderTeamsID(WhatTeam)
local SelectedResetTeam = sql.Query( "SELECT * FROM apple_deathmatch_team ORDER BY ID ASC;" )

	for k, v in pairs(SelectedResetTeam) do
		sql.Query( "UPDATE apple_deathmatch_team SET ID = '"..k.."' WHERE ID = '"..tonumber(v['ID']).."'" )
		if sql.LastError() != nil then
			 -- MsgN("sv_createteam.lua: "..sql.LastError())
		end
	end

	local MakeLastTeamNull = sql.QueryValue( "SELECT COUNT(ID) from apple_deathmatch_team;" )
	team.SetUp( tonumber(MakeLastTeamNull+1), "ISDELETED", Color(100,100,100,100), false)	
	
	CreateTeamsForServer()

	for k, v in pairs(player.GetAll()) do
		f2_menu_apple_fill_edit(v)
		PlayerInitialSpawnTeams(v)
	end
	
	timer.Simple(0.25, function()
		for k, v in pairs(player.GetAll()) do
			if v:Team() == tonumber(WhatTeam) then
				PlaceMeOnTheLowestTeamAvaialable(v)
			end
		end
	end)
	
	
	
	ReCreateSpawnItems()

end


net.Receive( "adci_delete_team", function( len, ply )
	local WhatTeam = net.ReadString()
	local HardDelete = net.ReadString()
	local WhatTeam2 = team.GetName(tonumber(WhatTeam))
	---- MsgN(WhatTeam)
	---- MsgN(WhatTeam2)

	-- MsgN(HardDelete)
	if tonumber(HardDelete) == 1 then
		local NewTeamName_sv_teamspawning = string.gsub(tostring(WhatTeam2), " ", "_")
		local NewTeamName_sv_teamspawning = sql.SQLStr("apple_deathmatch_teamspawning_"..NewTeamName_sv_teamspawning)
		local NewTeamName_sv_teamspawning = string.gsub(NewTeamName_sv_teamspawning, "'", "")
		local Trash = ("AP_GM_TRASH_TS_"..tostring(os.time()).."")
		sql.Query( "ALTER TABLE "..NewTeamName_sv_teamspawning.." RENAME TO "..tostring(Trash).."" )
		if sql.LastError() != nil then
			 -- MsgN("sv_createteam.lua: "..sql.LastError())
		end
		
		local NewTeamName_sv_teamweapons = string.gsub(tostring(WhatTeam2), " ", "_")
		local NewTeamName_sv_teamweapons = sql.SQLStr("apple_deathmatch_teamweapons_"..NewTeamName_sv_teamweapons)
		local NewTeamName_sv_teamweapons = string.gsub(NewTeamName_sv_teamweapons, "'", "")
		local Trash = ("AP_GM_TRASH_TW_"..tostring(os.time()).."")
		sql.Query( "ALTER TABLE "..NewTeamName_sv_teamweapons.." RENAME TO "..tostring(Trash).."" )
		if sql.LastError() != nil then
			 -- MsgN("sv_createteam.lua: "..sql.LastError())
		end
		
		local NewTeamName_sv_teammodels = string.gsub(tostring(WhatTeam2), " ", "_")
		local NewTeamName_sv_teammodels = sql.SQLStr("apple_deathmatch_teammodels_"..NewTeamName_sv_teammodels)
		local NewTeamName_sv_teammodels = string.gsub(NewTeamName_sv_teammodels, "'", "")
		local Trash = ("AP_GM_TRASH_TM_"..tostring(os.time()).."")
		sql.Query( "ALTER TABLE "..NewTeamName_sv_teammodels.." RENAME TO "..tostring(Trash).."" )
		if sql.LastError() != nil then
			 -- MsgN("sv_createteam.lua: "..sql.LastError())
		end
	end

	
	sql.Query( "DELETE FROM apple_deathmatch_team WHERE TeamName = "..sql.SQLStr(tostring(WhatTeam2))..";" )
	if sql.LastError() != nil then
		 -- MsgN("sv_createteam.lua: "..sql.LastError())
	end
	if sql.LastError() != nil then
		-- -- MsgN(sql.LastError())
	end
	
	FixTeamIDOrderTeamsID(WhatTeam)
end)


net.Receive( "adci_edit_team", function( len, ply )
	GetTheTotalNumberofWeaponsForListing = 0
	local TeamID = net.ReadString()
	local TeamModelTable = net.ReadTable()
	local TeamName = net.ReadString()
	local TeamWinSound = net.ReadString()
	local TeamColor = net.ReadTable()
	local TeamName = string.gsub(TeamName, "[%W]", function(a)
		if a == " " then 
			return " "
		else
			return "" 
		end
	end)
	local TeamName = string.gsub(TeamName," ","_")
	local CreateTeams = sql.Query( "SELECT * from apple_deathmatch_team WHERE ID = '"..tonumber(TeamID).."';" )
	if CreateTeams != nil then
		if sql.LastError() != nil then
			 -- MsgN("sv_createteam.lua: "..sql.LastError())
		end
		local OldTeamName = sql.QueryValue( "SELECT TeamName from apple_deathmatch_team WHERE ID = '"..tonumber(TeamID).."';" )
		
		if tostring(OldTeamName) != tostring(TeamName) then
			local NewTeamName_sv_teamspawning = string.gsub(tostring(OldTeamName), " ", "_")
			local NewTeamName_sv_teamspawning = sql.SQLStr("apple_deathmatch_"..game.GetMap().."_teamspawning_"..NewTeamName_sv_teamspawning)
			local NewTeamName_sv_teamspawning = string.gsub(NewTeamName_sv_teamspawning, "'", "")
			local NewTeamName_sv_teamspawning2 = string.gsub(tostring(TeamName), " ", "_")
			local NewTeamName_sv_teamspawning2 = sql.SQLStr("apple_deathmatch_"..game.GetMap().."_teamspawning_"..NewTeamName_sv_teamspawning2)
			local NewTeamName_sv_teamspawning2 = string.gsub(NewTeamName_sv_teamspawning2, "'", "")
			if sql.TableExists(NewTeamName_sv_teamspawning) == true then
				if sql.TableExists(NewTeamName_sv_teamspawning2) == false then
					sql.Query( "ALTER TABLE "..NewTeamName_sv_teamspawning.." RENAME TO "..NewTeamName_sv_teamspawning2.."" )
					if sql.LastError() != nil then
						 -- MsgN("sv_createteam.lua: "..sql.LastError())
					end
				end
			end
			
			local NewTeamName_sv_teamweapons = string.gsub(tostring(OldTeamName), " ", "_")
			local NewTeamName_sv_teamweapons = sql.SQLStr("apple_deathmatch_teamweapons_"..NewTeamName_sv_teamweapons)
			local NewTeamName_sv_teamweapons = string.gsub(NewTeamName_sv_teamweapons, "'", "") 
			local NewTeamName_sv_teamweapons2 = string.gsub(tostring(TeamName), " ", "_")
			local NewTeamName_sv_teamweapons2 = sql.SQLStr("apple_deathmatch_teamweapons_"..NewTeamName_sv_teamweapons2)
			local NewTeamName_sv_teamweapons2 = string.gsub(NewTeamName_sv_teamweapons2, "'", "") 
			if sql.TableExists(NewTeamName_sv_teamweapons) == true then
				if sql.TableExists(NewTeamName_sv_teamweapons2) == false then
					sql.Query( "ALTER TABLE "..NewTeamName_sv_teamweapons.." RENAME TO "..NewTeamName_sv_teamweapons2.."" )
					if sql.LastError() != nil then
						 -- MsgN("sv_createteam.lua: "..sql.LastError())
					end
				end
			end
		end
		
			
			local NewTeamName_sv_teammodels = string.gsub(tostring(OldTeamName), " ", "_")
			local NewTeamName_sv_teammodels = sql.SQLStr("apple_deathmatch_teammodels_"..NewTeamName_sv_teammodels)
			local NewTeamName_sv_teammodels = string.gsub(NewTeamName_sv_teammodels, "'", "")
			local NewTeamName_sv_teammodels2 = string.gsub(tostring(TeamName), " ", "_")
			local NewTeamName_sv_teammodels2 = sql.SQLStr("apple_deathmatch_teammodels_"..NewTeamName_sv_teammodels2)
			local NewTeamName_sv_teammodels2 = string.gsub(NewTeamName_sv_teammodels2, "'", "")
			if sql.TableExists(NewTeamName_sv_teammodels) == true then
			local GatherAllModels = sql.Query( "SELECT * FROM "..NewTeamName_sv_teammodels.." ORDER BY ID DESC" )
				
				if GatherAllModels != nil then
			--	-- MsgN("~~~~~")
					for k, v in pairs(GatherAllModels) do
				--		-- MsgN("LINE_1: "..k)
						sql.Query( "DELETE FROM "..NewTeamName_sv_teammodels.." WHERE ID = '"..tonumber(k).."'" )
					end
					if sql.LastError() != nil then
						 -- MsgN("sv_createteam.lua: "..sql.LastError())
					end
				end	
				
				
				for k, v in pairs(TeamModelTable) do
					if tostring(v) != "nil" then
					GetTheTotalNumberofWeaponsForListing = GetTheTotalNumberofWeaponsForListing + 1
						sql.Query( "INSERT INTO "..NewTeamName_sv_teammodels.." (`ID`, `ModelName`, `ModelDir`) VALUES ('"..tonumber(GetTheTotalNumberofWeaponsForListing).."', '"..tostring(k).."', '"..tostring(v).."')" )
						if sql.LastError() != nil then
							 -- MsgN("sv_createteam.lua: "..sql.LastError())
						end
					end
				end
			
			
				if sql.TableExists(NewTeamName_sv_teammodels2) == false then
					sql.Query( "ALTER TABLE "..NewTeamName_sv_teammodels.." RENAME TO "..NewTeamName_sv_teammodels2.."" )
					if sql.LastError() != nil then
						 -- MsgN("sv_createteam.lua: "..sql.LastError())
					end
				end
			end
		
		umsg.Start( "creating_teams_not_error", ply )
		umsg.End()
		
		sql.Query( "UPDATE apple_deathmatch_team SET TeamName = "..sql.SQLStr(tostring(TeamName))..", Red = '"..(TeamColor.r).."', Green = '"..(TeamColor.g).."', Blue = '"..(TeamColor.b).."', WinSound = "..sql.SQLStr(tostring(TeamWinSound)).." WHERE ID = '"..tonumber(TeamID).."'" )
	
		if sql.LastError() != nil then
			 -- MsgN("sv_createteam.lua: "..sql.LastError())
		end
	
		for k, v in pairs(player.GetAll()) do
			PlayerInitialSpawnTeams(v)
		end
	
		CreateTeamsForServer()
	else
		umsg.Start( "creating_teams_error", ply )
		umsg.End()
	end
	
--PrintTable(team.GetAllTeams())
end)


net.Receive( "GetWhoCreatedDetails", function( len, ply )
	local TeamID = net.ReadString()
	local GetRed = sql.QueryValue( "SELECT Red from apple_deathmatch_team WHERE ID = '"..tonumber(TeamID).."';" )
	local GetGreen = sql.QueryValue( "SELECT Green from apple_deathmatch_team WHERE ID = '"..tonumber(TeamID).."';" )
	local GetBlue = sql.QueryValue( "SELECT Blue from apple_deathmatch_team WHERE ID = '"..tonumber(TeamID).."';" )
	local GetAlpha = sql.QueryValue( "SELECT Y from apple_deathmatch_team WHERE ID = '"..tonumber(TeamID).."';" )
	local GetCreator = sql.QueryValue( "SELECT WhoCreatedMe from apple_deathmatch_team WHERE ID = '"..tonumber(TeamID).."';" )
	local GetCreatorID = sql.QueryValue( "SELECT WhoCreatedMeID from apple_deathmatch_team WHERE ID = '"..tonumber(TeamID).."';" )
	local GetCreatorTime = sql.QueryValue( "SELECT WhatTime from apple_deathmatch_team WHERE ID = '"..tonumber(TeamID).."';" )
	
	local NewTeamName_sv_teamspawning = string.gsub(team.GetName(tonumber(TeamID)), " ", "_")
	local NewTeamName_sv_teamspawning = sql.SQLStr("apple_deathmatch_"..game.GetMap().."_teamspawning_"..NewTeamName_sv_teamspawning)
	local NewTeamName_sv_teamspawning = string.gsub(NewTeamName_sv_teamspawning, "'", "")
	local HowManySpawns = sql.QueryValue( "SELECT COUNT(ID) from "..NewTeamName_sv_teamspawning..";" )
	
	local NewTeamName_sv_teamweapons = string.gsub(team.GetName(tonumber(TeamID)), " ", "_")
	local NewTeamName_sv_teamweapons = sql.SQLStr("apple_deathmatch_teamweapons_"..NewTeamName_sv_teamweapons)
	local NewTeamName_sv_teamweapons = string.gsub(NewTeamName_sv_teamweapons, "'", "")
	local HowManyWeapons = sql.QueryValue( "SELECT COUNT(ID) FROM "..NewTeamName_sv_teamweapons..";" )
	
		if sql.LastError() != nil then
			 -- MsgN("sv_createteam.lua: "..sql.LastError())
		end
	
	umsg.Start( "GetWhoCreatedDetails", ply )
		umsg.String(GetRed)
		umsg.String(GetGreen)
		umsg.String(GetBlue)
		umsg.String(GetAlpha)
		umsg.String(GetCreator)
		umsg.String(GetCreatorID)
		umsg.String(GetCreatorTime)
		umsg.String(HowManyWeapons)
		umsg.String(HowManySpawns)
	umsg.End()
end)


net.Receive( "FillEditTeamInformation", function( len, ply )
	local TeamID = net.ReadString()
	local GetName = sql.QueryValue( "SELECT TeamName from apple_deathmatch_team WHERE ID = '"..tonumber(TeamID).."';" )
	local GetRed = sql.QueryValue( "SELECT Red from apple_deathmatch_team WHERE ID = '"..tonumber(TeamID).."';" )
	local GetGreen = sql.QueryValue( "SELECT Green from apple_deathmatch_team WHERE ID = '"..tonumber(TeamID).."';" )
	local GetBlue = sql.QueryValue( "SELECT Blue from apple_deathmatch_team WHERE ID = '"..tonumber(TeamID).."';" )
	local GetAlpha = sql.QueryValue( "SELECT Y from apple_deathmatch_team WHERE ID = '"..tonumber(TeamID).."';" )
	local WinSound = sql.QueryValue( "SELECT WinSound from apple_deathmatch_team WHERE ID = '"..tonumber(TeamID).."';" )

		if sql.LastError() != nil then
			 -- MsgN("sv_createteam.lua: "..sql.LastError())
		end
	
	umsg.Start( "FillEditTeamInformation", ply )
		umsg.String(GetName)
		umsg.String(GetRed)
		umsg.String(GetGreen)
		umsg.String(GetBlue)
		umsg.String(GetAlpha)
		umsg.String(WinSound)
	umsg.End()
	
	-- NEW SHIT BELOW THIS
	
	local NewTeamName_sv_teammodels = string.gsub(team.GetName(tonumber(TeamID)), " ", "_")
	local NewTeamName_sv_teammodels = sql.SQLStr("apple_deathmatch_teammodels_"..NewTeamName_sv_teammodels)
	local NewTeamName_sv_teammodels = string.gsub(NewTeamName_sv_teammodels, "'", "")
	local GatherAllModels = sql.Query( "SELECT * FROM "..NewTeamName_sv_teammodels.."" )
				
		if sql.LastError() != nil then
			 -- MsgN("sv_createteam.lua: "..sql.LastError())
		end
				
	if GatherAllModels != nil then
		for k, v in pairs(GatherAllModels) do
			umsg.Start( "FillEditTeamInforModels", ply )
				umsg.Short(v['ID'])
				umsg.String(v['ModelName'])
				umsg.String(v['ModelDir'])
			umsg.End()
		end
	end	
end)



-- JUST SOME TESTS, IGNORE THIS. Im going to keep this for further studies
/*
local WHATEVER = "ABC 123 ;@3"
local WHATEVER = string.gsub(WHATEVER, "[%W]", function(a)
	if a == " " then 
		return " "
	else
		return "" 
	end
end)
-- MsgN(WHATEVER)

-- MsgN("~ ~ ~")
local TeamName = "ABC 123 !@#$%^&*()_+{}|:<>?-=[]"
-- MsgN("FIRST: "..TeamName)
local TeamName = string.gsub(TeamName,"[%W]","_")
-- MsgN("THIRD: "..TeamName)
*/


util.AddNetworkString( "FillEditTeamInformation" )
util.AddNetworkString( "adci_add_new_team" )
util.AddNetworkString( "adci_delete_team" )
util.AddNetworkString( "adci_edit_team" )
util.AddNetworkString( "GetWhoCreatedDetails" )