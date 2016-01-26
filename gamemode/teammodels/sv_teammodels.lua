-- SERVER SIDE


function CreateNewTeamModelsDB()
	local GENERICA_TEAMMOELS = sql.Query( "SELECT * from apple_deathmatch_team;" ) -- Gets just tshe team name for this
	if GENERICA_TEAMMOELS == nil then return end
	for k, v in pairs(GENERICA_TEAMMOELS) do
	local NewTeamName_sv_teammodels = string.gsub(v['TeamName'], " ", "_") -- Makes sure all the spaces in the team name are replaces with underscores
	local NewTeamName_sv_teammodels = sql.SQLStr("apple_deathmatch_teammodels_"..NewTeamName_sv_teammodels) -- I hope this makes it so the table don't get corrupted
	local NewTeamName_sv_teammodels = string.gsub(NewTeamName_sv_teammodels, "'", "") -- sql.SQLStr does something that imo it shouldn't do, and it places these the ' and yeah..
	--MsgN("Working 11")
		
		if sql.TableExists("'"..NewTeamName_sv_teammodels.."'") == false then -- So this should work now
			sql.Query( "CREATE TABLE "..NewTeamName_sv_teammodels.." ( ID int, ModelName varchar(255), ModelDir varchar(255) )" )
			--MsgN("Working 16")
			if sql.LastError() != nil then
			--	MsgN("sv_teammodels.lua: "..sql.LastError())
			--	MsgN("Working 19")
			end
			
			/*
			local OnlyStartOnce = sql.QueryValue( "SELECT Value FROM apple_deathmatch_settings WHERE ID = '13';" )
			if OnlyStartOnce == "0" then
				sql.Query( "INSERT INTO "..NewTeamName_sv_teammodels.." ( `ID`, `ModelName`, `ModelDir`) VALUES ( '1', 'gman', 'models/player/gman_high.mdl')" )
				MsgN("Creating default team models table for: "..v['TeamName'])
				if sql.LastError() != nil then
					 -- MsgN("sv_teammodels.lua: "..sql.LastError())
				end
			end
			*/
			
		elseif sql.TableExists("'"..NewTeamName_sv_teammodels.."'") == true then
			local CacheModels = sql.Query( "SELECT * FROM "..NewTeamName_sv_teammodels..";" )
			if CacheModels == nil then return end
			if sql.LastError() != nil then
				 -- MsgN("sv_teammodels.lua: "..sql.LastError())
			end
			for k, v in pairs(CacheModels) do
				util.PrecacheModel( v['ModelDir'] )
			--	-- MsgN(v['ModelDir'])
			end
		end	
	end
	--sql.Query( "UPDATE apple_deathmatch_settings SET Value = '1' WHERE ID = '13'" )
end


-- Check and see if we have a models database table for each team that existss
hook.Add( "PostGamemodeLoaded", "PostGamemodeLoadedModelsDB", function(ply)
	timer.Simple(3, function()
		CreateNewTeamModelsDB()
	end)
end)


-- This never got used, so it will sit here as a possible usage
/* 
function AddNewTeamModels(Team,NiceName,Name,ply)
	local NewTeamName_sv_teammodels = string.gsub(team.GetName(tonumber(Team)), " ", "_")
	local NewTeamName_sv_teammodels = sql.SQLStr("apple_deathmatch_teamweapons_"..NewTeamName_sv_teammodels)
	local NewTeamName_sv_teammodels = string.gsub(NewTeamName_sv_teammodels, "'", "")
	local CheckLastIDModel = sql.QueryValue( "SELECT ID FROM "..NewTeamName_sv_teammodels.." ORDER BY ID DESC LIMIT 1;" )
		if CheckLastIDModel == nil then
			sql.Query( "INSERT INTO "..NewTeamName_sv_teammodels.." ( `ID`, `ModelName`, `ModelDir`) VALUES ( '1', '"..(NiceName).."', '"..(Name).."' )" )
		else
			sql.Query( "INSERT INTO "..NewTeamName_sv_teammodels.." ( `ID`, `ModelName`, `ModelDir`) VALUES ( '"..(CheckLastIDModel+1).."', '"..(NiceName).."', '"..(Name).."' )" )
		end
	if sql.LastError() != nil then
		-- -- MsgN(sql.LastError())
	end
end