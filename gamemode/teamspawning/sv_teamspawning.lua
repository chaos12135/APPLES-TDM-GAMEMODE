-- SERVER SIDE


-- Check and see if we have a teamspawn database table for each team that exists
function GM:PostGamemodeLoaded()
	timer.Simple(3, function()
		CreateNewTeamSpawningDB()
	end)
end


function CreateNewTeamSpawningDB()
	local GENERICA_TEAMSPAWNING = sql.Query( "SELECT TeamName from apple_deathmatch_team;" ) -- Gets just the team name for this
	if GENERICA_TEAMSPAWNING == nil then return end
	if sql.LastError() != nil then
		 -- MsgN("sv_teamspawning.lua 16: "..sql.LastError())
	end
	for k, v in pairs(GENERICA_TEAMSPAWNING) do
	local NewTeamName_sv_teamspawning = string.gsub(v['TeamName'], " ", "_") -- Makes sure all the spaces in the team name are replaces with underscores
	local NewTeamName_sv_teamspawning = sql.SQLStr("apple_deathmatch_"..game.GetMap().."_teamspawning_"..NewTeamName_sv_teamspawning) -- I hope this makes it so the table don't get corrupted
	local NewTeamName_sv_teamspawning = string.gsub(NewTeamName_sv_teamspawning, "'", "") -- sql.SQLStr does something that imo it shouldn't do, and it places these the ' and yeah..
			
		if sql.TableExists(NewTeamName_sv_teamspawning) == false then -- So this should work now
			sql.Query( "CREATE TABLE "..NewTeamName_sv_teamspawning.." ( ID int, X int, Y int, Z int, Roll float, Yaw float, Pitch float, R int, G int, B int, extra varchar(255))" ) -- Creates a very simple X, Y, Z system spawning. Extra is for w/e I may have forgotten
			if sql.LastError() != nil then
				 -- MsgN("sv_teamspawning.lua 26: "..sql.LastError())
			end
			sql.Query( "INSERT INTO "..NewTeamName_sv_teamspawning.." ( `ID`, `X`, `Y`, `Z`, `Roll`, `Yaw`, `Pitch`, `R`, `G`, `B`) VALUES ( '1', '0', '0', '0', '0', '0', '0', '100', '100', '100' )" )
			if sql.LastError() != nil then
				 -- MsgN("sv_teamspawning.lua 30: "..sql.LastError())
			end
			-- MsgN("Creating team spawning table for: "..v['TeamName'])
			
			
		elseif sql.TableExists(NewTeamName_sv_teamspawning) == true then
			local TeamSpawnsF = sql.Query( "SELECT * FROM "..NewTeamName_sv_teamspawning.."" )
			if TeamSpawnsF == nil then return end
			if sql.LastError() != nil then
				 -- MsgN("sv_teamspawning.lua 39: "..sql.LastError())
			end
			local SettingCreateSpawns = sql.QueryValue( "SELECT Value FROM apple_deathmatch_settings WHERE ID = '6';" )
			if tonumber(SettingCreateSpawns) == 1 then
				for k, v in pairs(TeamSpawnsF) do
					local CreateTeamSpawn = ents.Create( "team_spawn" )
					if ( !IsValid( CreateTeamSpawn ) ) then return end
					CreateTeamSpawn:SetModel( "models/props_phx/construct/windows/window_curve360x2.mdl" )
					CreateTeamSpawn:SetPos(Vector(v['X'],v['Y'],v['Z']))
					CreateTeamSpawn:SetAngles(Angle(0,tonumber(v['Yaw']),tonumber(v['Pitch'])))
					CreateTeamSpawn:SetColor(Color(v['R'],v['G'],v['B']))
					CreateTeamSpawn:Spawn()
				end
			end
		end	
	end
end

/*
hook.Add( "PlayerInitialSpawn", "PlayerInitialSpawnTeamSpawning", function(ply)
	local GENERICA_TEAMSPAWNING = sql.Query( "SELECT TeamName from apple_deathmatch_team;" ) -- Gets just the team name for this
	
	for k, v in pairs(GENERICA_TEAMSPAWNING) do
	local NewTeamName_sv_teamspawning = string.gsub(v['TeamName'], " ", "_") -- Makes sure all the spaces in the team name are replaces with underscores
	local NewTeamName_sv_teamspawning = sql.SQLStr("apple_deathmatch_teamspawning_"..NewTeamName_sv_teamspawning) -- I hope this makes it so the table don't get corrupted
	local NewTeamName_sv_teamspawning = string.gsub(NewTeamName_sv_teamspawning, "'", "")
		
		if sql.TableExists(NewTeamName_sv_teamspawning) == true then
			local TeamSpawnsF = sql.Query( "SELECT * FROM "..NewTeamName_sv_teamspawning.."" )
			-- MsgN(TeamSpawnsF)
			if TeamSpawnsF == nil then return end
			for k, v in pairs(TeamSpawnsF) do
				local CreateTeamSpawn = ents.Create( "team_spawn" )
				if ( !IsValid( CreateTeamSpawn ) ) then return end
				CreateTeamSpawn:SetModel( "models/props_phx/construct/windows/window_curve360x2.mdl" )
				CreateTeamSpawn:SetPos(Vector(v['X'],v['Y'],v['Z']))
				CreateTeamSpawn:SetAngles(Angle(tonumber(v['Roll']),tonumber(v['Yaw']),tonumber(v['Pitch'])))
				CreateTeamSpawn:SetColor(Color(v['R'],v['G'],v['B']))
				CreateTeamSpawn:Spawn()
			end
		end
	end
end)
*/


function GM:PlayerSpawn(ply)
if THEGAMEISOVERDONOTFIREANYMORE == 1 then 
	
return end

	if ply:Team() < 1000 && ply:Team() > 0 then
	ply:StripWeapons()
	ply:StripAmmo()
	ply:AllowFlashlight( true ) 
		local NewTeamName_sv_teamspawning = string.gsub(team.GetName(ply:Team()), " ", "_")
		local NewTeamName_sv_teamspawning = sql.SQLStr("apple_deathmatch_"..game.GetMap().."_teamspawning_"..NewTeamName_sv_teamspawning)
		local NewTeamName_sv_teamspawning = string.gsub(NewTeamName_sv_teamspawning, "'", "")
		if sql.TableExists(NewTeamName_sv_teamspawning) == true then
			local TeamSpawnsF = sql.Query( "SELECT * FROM "..NewTeamName_sv_teamspawning.."" )
			local TeamSpawnsC = sql.QueryValue( "SELECT COUNT(ID) from "..NewTeamName_sv_teamspawning..";" )
			local SelectedSpawn = math.random(1,tonumber(TeamSpawnsC))
			if TeamSpawnsF == nil || TeamSpawnsC == nil then return end
			for k, v in pairs(TeamSpawnsF) do
				if tonumber(v['ID']) == tonumber(SelectedSpawn) then
					ply:SetPos(Vector(v['X'],v['Y'],v['Z']))
					ply:SetEyeAngles(Angle(""..v['Roll'].." "..v['Yaw'].." "..v['Pitch']..""))
				end
			end
		end
		
		local NewTeamName_sv_teamweapons = string.gsub(team.GetName(ply:Team()), " ", "_")
		local NewTeamName_sv_teamweapons = sql.SQLStr("apple_deathmatch_teamweapons_"..NewTeamName_sv_teamweapons)
		local NewTeamName_sv_teamweapons = string.gsub(NewTeamName_sv_teamweapons, "'", "")
		local GiveWeaponsToPlayers = sql.Query( "SELECT * FROM "..NewTeamName_sv_teamweapons..";" )
		if GiveWeaponsToPlayers != nil || GiveWeaponsToPlayers == true then
		--GetAmmoTypesForClasses = {}
			for k, v in pairs(GiveWeaponsToPlayers) do
				/*
				for n,p in pairs(weapons.GetList()) do -- Gets the list of all available weapons on the server
					local NewString = string.gsub( tostring(v['Name']), "_", " " )
					if string.find(NewString,"base") == nil then  -- If the weapon is base, don't show it on the list
						if p['ClassName'] == tostring(v['Name']) then
							if tostring(p.Primary.Ammo) != nil || tostring(p.Primary.Ammo) != "nil" then
								GetAmmoTypesForClasses[tostring(p.Primary.Ammo)] = k
							end
						end
					end
				end
				*/
				ply:Give(v['Name'])
			end
		end
		
		local WhatIsItClass = sql.QueryValue( "SELECT Value FROM apple_deathmatch_settings WHERE ID = '11';" )
		if tonumber(WhatIsItClass) == 1 then
			if ply:GetPData("AppleTDMGmodClass") != nil then
				local NewClassName_sv_Classweapons = string.gsub((ply:GetPData("AppleTDMGmodClass")), " ", "_")
				local NewClassName_sv_Classweapons = sql.SQLStr("apple_deathmatch_classes_"..NewClassName_sv_Classweapons)
				local NewClassName_sv_Classweapons = string.gsub(NewClassName_sv_Classweapons, "'", "") 
				local AllClassesW = sql.Query( "SELECT * FROM "..NewClassName_sv_Classweapons..";" )
				if AllClassesW != nil || AllClassesW == true then
				--GetAmmoTypesForClasses = {}
					for k, v in pairs(AllClassesW) do
						/*
						for n,p in pairs(weapons.GetList()) do -- Gets the list of all available weapons on the server
							local NewString = string.gsub( tostring(v['Name']), "_", " " )
							if string.find(NewString,"base") == nil then  -- If the weapon is base, don't show it on the list
								if p['ClassName'] == tostring(v['Name']) then
									if tostring(p.Primary.Ammo) != nil || tostring(p.Primary.Ammo) != "nil" then
										GetAmmoTypesForClasses[tostring(p.Primary.Ammo)] = k
									end
								end
							end
						end
						*/
						ply:Give(v['Name'])
					end
					/*
					for r,s in pairs(GetAmmoTypesForClasses) do
						MsgN(tostring(r))
						ply:GiveAmmo( 1, tostring(r), true)
					end
					*/
				end
			end
		end
		
		local AllAmmoGives = sql.Query( "SELECT * FROM apple_deathmatch_ammo_types;" )
		if AllAmmoGives == nil then return end
		for k, v in pairs(AllAmmoGives) do
			ply:GiveAmmo( tonumber(v['Ammo']), tostring(v['Name']), true )
		end
		
		local NewTeamName_sv_teammodels = string.gsub(team.GetName(ply:Team()), " ", "_")
		local NewTeamName_sv_teammodels = sql.SQLStr("apple_deathmatch_teammodels_"..NewTeamName_sv_teammodels)
		local NewTeamName_sv_teammodels = string.gsub(NewTeamName_sv_teammodels, "'", "")
		local GiveModelsToPlayers = sql.QueryValue( "SELECT COUNT(ID) FROM "..NewTeamName_sv_teammodels..";" )
		if GiveModelsToPlayers == nil || GiveModelsToPlayers == false then return end
		local GiveModelsToPlayersNum = math.random(1, GiveModelsToPlayers)
		local GiveModelsToPlayers = sql.QueryValue( "SELECT ModelDir FROM "..NewTeamName_sv_teammodels.." WHERE ID = '"..GiveModelsToPlayersNum.."';" )
			ply:SetModel(GiveModelsToPlayers)
	end
end
	
function ReCreateSpawnItems()
	local ReCreateTeamSpawn = ents.FindByClass("team_spawn")
	for _,v in pairs(ReCreateTeamSpawn) do v:Remove() end
	
	local GENERICA_TEAMSPAWNING = sql.Query( "SELECT TeamName from apple_deathmatch_team;" )
	if GENERICA_TEAMSPAWNING == nil then return end
	if sql.LastError() != nil then
		 -- MsgN("sv_teamspawning.lua 148: "..sql.LastError())
	end
	for k, v in pairs(GENERICA_TEAMSPAWNING) do
		local NewTeamName_sv_teamspawning = string.gsub(v['TeamName'], " ", "_")
		local NewTeamName_sv_teamspawning = sql.SQLStr("apple_deathmatch_"..game.GetMap().."_teamspawning_"..NewTeamName_sv_teamspawning)
		local NewTeamName_sv_teamspawning = string.gsub(NewTeamName_sv_teamspawning, "'", "")
		
		local TeamSpawnsF = sql.Query( "SELECT * FROM "..NewTeamName_sv_teamspawning.."" )
		if sql.LastError() != nil then
			 -- MsgN("sv_teamspawning.lua 157: "..sql.LastError())
		end
		if TeamSpawnsF == nil then return end
		local SettingCreateSpawns = sql.QueryValue( "SELECT Value FROM apple_deathmatch_settings WHERE ID = '6';" )
		if tonumber(SettingCreateSpawns) == 1 then
			for k, v in pairs(TeamSpawnsF) do
				local CreateTeamSpawn = ents.Create( "team_spawn" )
				if ( !IsValid( CreateTeamSpawn ) ) then return end
				CreateTeamSpawn:SetModel( "models/props_phx/construct/windows/window_curve360x2.mdl" )
				CreateTeamSpawn:SetPos(Vector(v['X'],v['Y'],v['Z']))
				CreateTeamSpawn:SetAngles(Angle(0,tonumber(v['Yaw']),tonumber(v['Pitch'])))
				CreateTeamSpawn:SetColor(Color(tonumber(v['R']),tonumber(v['G']),tonumber(v['B'])))
				CreateTeamSpawn:Spawn()
			end
		end
	end
end

function FixTeamIDOrder(NewTeamName_sv_teamspawning)
local SelectedResetTeam = sql.Query( "SELECT * FROM "..NewTeamName_sv_teamspawning.." ORDER BY ID ASC;" )

	for k, v in pairs(SelectedResetTeam) do
		sql.Query( "UPDATE "..NewTeamName_sv_teamspawning.." SET ID = '"..k.."' WHERE ID = '"..tonumber(v['ID']).."'" )
		if sql.LastError() != nil then
			 -- MsgN("sv_teamspawning.lua 178: "..sql.LastError())
		end
	end
	
ReCreateSpawnItems()
end


function EditTeamSpawn(Team,ID,X,Y,Z,Roll,Yaw,Pitch)
	local NewTeamName_sv_teamspawning = string.gsub(team.GetName(tonumber(Team)), " ", "_")
	local NewTeamName_sv_teamspawning = sql.SQLStr("apple_deathmatch_"..game.GetMap().."_teamspawning_"..NewTeamName_sv_teamspawning)
	local NewTeamName_sv_teamspawning = string.gsub(NewTeamName_sv_teamspawning, "'", "")
	sql.Query( "UPDATE "..NewTeamName_sv_teamspawning.." SET X = '"..math.Round(X).."', Y = '"..math.Round(Y).."', Z = '"..math.Round(Z).."', Roll = '"..Roll.."', Yaw = '"..Yaw.."', Pitch = '"..Pitch.."', R = '"..(team.GetColor(tonumber(Team)).r).."', G = '"..(team.GetColor(tonumber(Team)).g).."', B = '"..(team.GetColor(tonumber(Team)).b).."' WHERE ID = '"..tonumber(ID).."'" )
	if sql.LastError() != nil then
		 -- MsgN("sv_teamspawning.lua 192: "..sql.LastError())
	end
	ReCreateSpawnItems()
end


function RemoveTeamSpawn(Team,ID)
	local NewTeamName_sv_teamspawning = string.gsub(team.GetName(tonumber(Team)), " ", "_")
	local NewTeamName_sv_teamspawning = sql.SQLStr("apple_deathmatch_"..game.GetMap().."_teamspawning_"..NewTeamName_sv_teamspawning)
	local NewTeamName_sv_teamspawning = string.gsub(NewTeamName_sv_teamspawning, "'", "")
	sql.Query( "DELETE FROM "..NewTeamName_sv_teamspawning.." WHERE ID = '"..tonumber(ID).."'" )
	if sql.LastError() != nil then
		 -- MsgN("sv_teamspawning.lua 204: "..sql.LastError())
	end
	FixTeamIDOrder(NewTeamName_sv_teamspawning)
end


function AddNewTeamSpawn(Team,X,Y,Z,Roll,Yaw,Pitch,Red,Green,Blue)
	local NewTeamName_sv_teamspawning = string.gsub(team.GetName(tonumber(Team)), " ", "_")
	local NewTeamName_sv_teamspawning = sql.SQLStr("apple_deathmatch_"..game.GetMap().."_teamspawning_"..NewTeamName_sv_teamspawning)
	local NewTeamName_sv_teamspawning = string.gsub(NewTeamName_sv_teamspawning, "'", "")

	local CheckLastIDSpawn = sql.QueryValue( "SELECT ID FROM "..NewTeamName_sv_teamspawning.." ORDER BY ID DESC LIMIT 1;" )
	if CheckLastIDSpawn == nil then
		sql.Query( "INSERT INTO "..NewTeamName_sv_teamspawning.." ( `ID`, `X`, `Y`, `Z`, `Roll`, `Yaw`, `Pitch`, `R`, `G`, `B`) VALUES ( '1', '"..math.Round(X).."', '"..math.Round(Y).."', '"..math.Round(Z).."', '"..(Roll).."', '"..(Yaw).."', '"..(Pitch).."', '"..(Red).."', '"..(Green).."', '"..(Blue).."' )" )
		if sql.LastError() != nil then
			 -- MsgN("sv_teamspawning.lua 219: "..sql.LastError())
		end
	else
		sql.Query( "INSERT INTO "..NewTeamName_sv_teamspawning.." ( `ID`, `X`, `Y`, `Z`, `Roll`, `Yaw`, `Pitch`, `R`, `G`, `B`) VALUES ( '"..(CheckLastIDSpawn+1).."', '"..math.Round(X).."', '"..math.Round(Y).."', '"..math.Round(Z).."', '"..(Roll).."', '"..(Yaw).."', '"..(Pitch).."', '"..(Red).."', '"..(Green).."', '"..(Blue).."' )" )
		if sql.LastError() != nil then
			 -- MsgN("sv_teamspawning.lua 224: "..sql.LastError())
		end
	end
		
	ReCreateSpawnItems()
end