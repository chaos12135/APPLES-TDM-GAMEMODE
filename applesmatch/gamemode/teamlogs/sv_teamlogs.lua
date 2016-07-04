-- SERVER SIDE


-- Check and see if we have a team weapons database table for each team that exists
hook.Add( "PostGamemodeLoaded", "PostGamemodeLoadedLogsDB", function(ply)
	timer.Simple(3, function()
		CreateNewTeamLogsDB()
	end)
end)


function CreateNewTeamLogsDB()
	local GENERICA_TEAMLOGS = sql.Query( "SELECT TeamName from apple_deathmatch_team;" ) -- Gets just the team name for this
	if GENERICA_TEAMLOGS == nil then return end
	if sql.LastError() != nil then
		 -- MsgN("sv_teamweapons.lua: "..sql.LastError())
	end
	for k, v in pairs(GENERICA_TEAMLOGS) do
	local NewTeamName_sv_teamlogs = string.gsub(v['TeamName'], " ", "_")
	local NewTeamName_sv_teamlogs = sql.SQLStr("apple_deathmatch_teamlogs_"..NewTeamName_sv_teamlogs)
	local NewTeamName_sv_teamlogs = string.gsub(NewTeamName_sv_teamlogs, "'", "") 
			
		if sql.TableExists("'"..NewTeamName_sv_teamlogs.."'") == false then
			sql.Query( "CREATE TABLE "..NewTeamName_sv_teamlogs.." ( ID int, Date varchar(255), Change varchar(255), Name varchar(255), SteamID varchar(255))" )
			if sql.LastError() != nil then
				 -- MsgN("sv_teamweapons.lua: "..sql.LastError())
			end
			sql.Query( "INSERT INTO "..NewTeamName_sv_teamlogs.." ( `ID`, `Date`, `Change`, `Name`, `SteamID`) VALUES ( '1', "..sql.SQLStr(tostring(os.date( "%X - %m/%d/%Y" , os.time() )))..", 'ADD', 'SYSTEM', 'SYSTEM' )" )
			if sql.LastError() != nil then
				 -- MsgN("sv_teamweapons.lua: "..sql.LastError())
			end
			-- MsgN("Creating team weapons table for: "..v['TeamName'])
		end
	end
end

