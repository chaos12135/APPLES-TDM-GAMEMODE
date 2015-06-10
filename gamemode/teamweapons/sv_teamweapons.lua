-- SERVER SIDE


-- Check and see if we have a team weapons database table for each team that exists
hook.Add( "PostGamemodeLoaded", "PostGamemodeLoadedWeaponsDB", function(ply)
	timer.Simple(3, function()
		CreateNewTeamWeaponDB()
	end)
end)


function CreateNewTeamWeaponDB()
	local GENERICA_TEAMWEAPONS = sql.Query( "SELECT TeamName from apple_deathmatch_team;" ) -- Gets just the team name for this
	if GENERICA_TEAMWEAPONS == nil then return end
	if sql.LastError() != nil then
		 -- MsgN("sv_teamweapons.lua: "..sql.LastError())
	end
	for k, v in pairs(GENERICA_TEAMWEAPONS) do
	local NewTeamName_sv_teamweapons = string.gsub(v['TeamName'], " ", "_")
	local NewTeamName_sv_teamweapons = sql.SQLStr("apple_deathmatch_teamweapons_"..NewTeamName_sv_teamweapons)
	local NewTeamName_sv_teamweapons = string.gsub(NewTeamName_sv_teamweapons, "'", "") 
			
		if sql.TableExists(NewTeamName_sv_teamweapons) == false then
			sql.Query( "CREATE TABLE "..NewTeamName_sv_teamweapons.." ( ID int, Nice varchar(255), Name varchar(255))" )
			if sql.LastError() != nil then
				 -- MsgN("sv_teamweapons.lua: "..sql.LastError())
			end
			sql.Query( "INSERT INTO "..NewTeamName_sv_teamweapons.." ( `ID`, `Nice`, `Name`) VALUES ( '1', 'Medkit', 'weapon_medkit' )" )
			if sql.LastError() != nil then
				 -- MsgN("sv_teamweapons.lua: "..sql.LastError())
			end
			-- MsgN("Creating team weapons table for: "..v['TeamName'])
		end
	end
end


function FixTeamIDOrderWep(NewTeamName_sv_teamweapons)
local SelectedResetTeamWep = sql.Query( "SELECT * FROM "..NewTeamName_sv_teamweapons.." ORDER BY ID ASC;" )
if SelectedResetTeamWep == nil then return end
	if sql.LastError() != nil then
		 -- MsgN("sv_teamweapons.lua: "..sql.LastError())
	end
	for k, v in pairs(SelectedResetTeamWep) do
		sql.Query( "UPDATE "..NewTeamName_sv_teamweapons.." SET ID = '"..k.."' WHERE ID = '"..tonumber(v['ID']).."'" )
	if sql.LastError() != nil then
		 -- MsgN("sv_teamweapons.lua: "..sql.LastError())
	end
	end
end


function RemoveTeamWeapon(Team,ID)
	local NewTeamName_sv_teamweapons = string.gsub(team.GetName(tonumber(Team)), " ", "_")
	local NewTeamName_sv_teamweapons = sql.SQLStr("apple_deathmatch_teamweapons_"..NewTeamName_sv_teamweapons)
	local NewTeamName_sv_teamweapons = string.gsub(NewTeamName_sv_teamweapons, "'", "")
	sql.Query( "DELETE FROM "..NewTeamName_sv_teamweapons.." WHERE ID = '"..tonumber(ID).."'" )
	if sql.LastError() != nil then
		 -- MsgN("sv_teamweapons.lua: "..sql.LastError())
	end
	FixTeamIDOrderWep(NewTeamName_sv_teamweapons)
end


function AddNewTeamWeapon(Team,NiceName,Name,ply)
	local ChecForDuplicate = nil
	local NewTeamName_sv_teamweapons = string.gsub(team.GetName(tonumber(Team)), " ", "_")
	local NewTeamName_sv_teamweapons = sql.SQLStr("apple_deathmatch_teamweapons_"..NewTeamName_sv_teamweapons)
	local NewTeamName_sv_teamweapons = string.gsub(NewTeamName_sv_teamweapons, "'", "")
	local CheckLastIDWeapon = sql.QueryValue( "SELECT ID FROM "..NewTeamName_sv_teamweapons.." ORDER BY ID DESC LIMIT 1;" )
	local ChecForDuplicate = sql.QueryValue( "SELECT Name FROM "..NewTeamName_sv_teamweapons.." WHERE Name = '"..(Name).."';" )
	if ChecForDuplicate == nil then
		if CheckLastIDWeapon == nil then
			sql.Query( "INSERT INTO "..NewTeamName_sv_teamweapons.." ( `ID`, `Nice`, `Name`) VALUES ( '1', '"..(NiceName).."', '"..(Name).."' )" )
			if sql.LastError() != nil then
				 -- MsgN("sv_teamweapons.lua: "..sql.LastError())
			end
		else
			sql.Query( "INSERT INTO "..NewTeamName_sv_teamweapons.." ( `ID`, `Nice`, `Name`) VALUES ( '"..(CheckLastIDWeapon+1).."', '"..(NiceName).."', '"..(Name).."' )" )
			if sql.LastError() != nil then
				 -- MsgN("sv_teamweapons.lua: "..sql.LastError())
			end
		end
	else
		umsg.Start("WeaponDuplicate", ply)
		umsg.End()
	end
end