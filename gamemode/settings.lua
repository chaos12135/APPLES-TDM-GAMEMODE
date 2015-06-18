-- SERVER SIDE


hook.Add( "PostGamemodeLoaded", "PostGamemodeLoadedSettingsDB", function(ply)
	timer.Simple(3, function()
		CreateSettingsDB()
		CreateMapsDB()
	end)
end)


function CreateSettingsDB()
	local GENERICA_SETTINGS = sql.Query( "SELECT * from apple_deathmatch_settings;" )
	if GENERICA_SETTINGS == nil then return end
	if sql.TableExists("apple_deathmatch_settings") == false then
		sql.Query( "CREATE TABLE apple_deathmatch_settings ( ID int, Type varchar(255), Value varchar(255) )" )
		if sql.LastError() != nil then
			 -- MsgN("settings.lua: "..sql.LastError())
		end
		if sql.QueryValue( "SELECT ID FROM apple_deathmatch_settings WHERE ID = '1';" ) == nil then
			sql.Query( "INSERT INTO apple_deathmatch_settings ( `ID`, `Type`, `Value`) VALUES ( '1', 'Score', '50')" )
		end
		if sql.QueryValue( "SELECT ID FROM apple_deathmatch_settings WHERE ID = '2';" ) == nil then
			sql.Query( "INSERT INTO apple_deathmatch_settings ( `ID`, `Type`, `Value`) VALUES ( '2', 'Time', '5')" )
		end
		if sql.QueryValue( "SELECT ID FROM apple_deathmatch_settings WHERE ID = '3';" ) == nil then
			sql.Query( "INSERT INTO apple_deathmatch_settings ( `ID`, `Type`, `Value`) VALUES ( '3', 'Intro', "..sql.SQLStr('https://ia601508.us.archive.org/35/items/njoin2/njoin2.mp3')..")" )
		end
		if sql.QueryValue( "SELECT ID FROM apple_deathmatch_settings WHERE ID = '4';" ) == nil then
			sql.Query( "INSERT INTO apple_deathmatch_settings ( `ID`, `Type`, `Value`) VALUES ( '4', 'IntroChk', '1')" )
		end
		if sql.QueryValue( "SELECT ID FROM apple_deathmatch_settings WHERE ID = '5';" ) == nil then
			sql.Query( "INSERT INTO apple_deathmatch_settings ( `ID`, `Type`, `Value`) VALUES ( '5', 'IntroTime', '25')" )
		end
		if sql.QueryValue( "SELECT ID FROM apple_deathmatch_settings WHERE ID = '6';" ) == nil then
			sql.Query( "INSERT INTO apple_deathmatch_settings ( `ID`, `Type`, `Value`) VALUES ( '6', 'ShowSpawns', '1')" )
		end
		if sql.QueryValue( "SELECT ID FROM apple_deathmatch_settings WHERE ID = '7';" ) == nil then
			sql.Query( "INSERT INTO apple_deathmatch_settings ( `ID`, `Type`, `Value`) VALUES ( '7', 'RewardLevel', '100')" )
		end
		if sql.QueryValue( "SELECT ID FROM apple_deathmatch_settings WHERE ID = '8';" ) == nil then
			sql.Query( "INSERT INTO apple_deathmatch_settings ( `ID`, `Type`, `Value`) VALUES ( '8', 'RewardLevelMutli', '1')" )
		end
		if sql.QueryValue( "SELECT ID FROM apple_deathmatch_settings WHERE ID = '9';" ) == nil then
			sql.Query( "INSERT INTO apple_deathmatch_settings ( `ID`, `Type`, `Value`) VALUES ( '9', 'RewardLevelSound', "..sql.SQLStr('https://ia601506.us.archive.org/17/items/levelup_201506/levelup.mp3')..")" )
		end
		if sql.QueryValue( "SELECT ID FROM apple_deathmatch_settings WHERE ID = '10';" ) == nil then
			sql.Query( "INSERT INTO apple_deathmatch_settings ( `ID`, `Type`, `Value`) VALUES ( '10', 'RewardLevelSoundTime', '12')" )
		end
		if sql.QueryValue( "SELECT ID FROM apple_deathmatch_settings WHERE ID = '11';" ) == nil then
			sql.Query( "INSERT INTO apple_deathmatch_settings ( `ID`, `Type`, `Value`) VALUES ( '11', 'Classes', '0')" )
		end
		-- MsgN("Creating setting : Score")
		if sql.LastError() != nil then
			 -- MsgN("settings.lua: "..sql.LastError())
		end
	end
end



function CreateMapsDB()
	local GENERICA_SETTINGS_MAPS = sql.Query( "SELECT * from apple_deathmatch_maplist;" )
	if GENERICA_SETTINGS_MAPS == nil then return end
	if sql.TableExists("apple_deathmatch_maplist") == false then
		sql.Query( "CREATE TABLE apple_deathmatch_maplist ( ID int, Map varchar(255) )" )
		sql.Query( "INSERT INTO apple_deathmatch_maplist ( `ID`, `Map`) VALUES ( '1', 'gm_construct')" )
		MsgN("Creating setting : maplist")
	end
end


/*
function CreateSpectatingDB()
	local GENERICA_SPECY = sql.Query( "SELECT * from apple_deathmatch_active_players;" )
	if GENERICA_SPECY == nil then return end
	if sql.TableExists(GENERICA_SPECY) == false then
		sql.Query( "CREATE TABLE apple_deathmatch_active_players ( ID int, PlayerID varchar(255), Kills int, TeamID int )" )
		if sql.LastError() != nil then
			 -- MsgN("settings.lua: "..sql.LastError())
		end
	end
end



function AddToSpectator(ply)
	timer.Simple(5, function()
		sql.Query( "INSERT INTO apple_deathmatch_active_players ( `ID`, `PlayerID`, `Kills`, `TeamID`) VALUES ( '1', "..(sql.SQLStr(ply:UniqueID()))..", '0', "..(tonumber(ply:Team()))..")" )
	end)
end
hook.Add( "PlayerInitialSpawn", "AddToSpectator", AddToSpectator)
*/