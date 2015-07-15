-- The F2 Menu

if CLIENT then
	local function f2_menu_apple(data)
	local ply = data:ReadEntity()
	WhatTeamIsSelectedForEditing = nil
		-- Main Menu
		local MainMenu = vgui.Create( "DFrame" ) -- The menu
		MainMenu:SetSize(500, 300)
		MainMenu:SetTitle( "Team Information Menu" )
		MainMenu:SetDraggable( false )
		MainMenu:Center()
		MainMenu:MakePopup()
		
		local MainMenuTabs = vgui.Create( "DPropertySheet", MainMenu ) -- Just a sheet
		MainMenuTabs:SetPos( 5, 30 )
		MainMenuTabs:SetSize( 490, 265 )
		
		
		-- THIS IS THE BEGINNING OF THE FIRST TAB
		-- THIS IS THE BEGINNING OF THE FIRST TAB
		-- THIS IS THE BEGINNING OF THE FIRST TAB

		 
		local GenInfo = vgui.Create( "DPanelList" )
		GenInfo:SetPos( 0, 0 )
		GenInfo:SetSize( MainMenuTabs:GetWide(), MainMenuTabs:GetTall() )
		GenInfo:SetSpacing( 5 )
		GenInfo:EnableHorizontal( false )
		GenInfo:EnableVerticalScrollbar( true )
		
		TeamGenListing = vgui.Create("DListView",GenInfo) -- The first list of the team information, not really important
		TeamGenListing:SetPos(0, 10)
		TeamGenListing:SetSize(330, 219)
		TeamGenListing:SetMultiSelect(false)
		TeamGenListing:AddColumn("ID")
		TeamGenListing:AddColumn("Rank")
		TeamGenListing:AddColumn("Name"):SetFixedWidth(150)
		TeamGenListing:AddColumn("Kills")
		TeamGenListing:AddColumn("Deaths")
		TeamGenListing:AddColumn("Score")
		
		TeamGenListingP = vgui.Create("DListView",GenInfo) -- This general player information, not sure why it's on this menu, but it's there so I'm keeping it
		TeamGenListingP:SetPos(335, 10)
		TeamGenListingP:SetSize(138, 219)
		TeamGenListingP:SetMultiSelect(false)
		TeamGenListingP:AddColumn("Name")
		TeamGenListingP:AddColumn("Team")
		TeamGenListingP:AddColumn("Rank")
		
		net.Start( "f2_menu_apple_fill_gen_players" ) -- This is a function just to start loading the teams on the general list
		net.SendToServer( ply )
		
		net.Start( "f2_menu_apple_fill_gen" ) -- This is a function just to start loading the players on the general list
		net.SendToServer( ply )
		
		-- THIS IS THE END OF THE FIRST TAB
		-- THIS IS THE END OF THE FIRST TAB
		-- THIS IS THE END OF THE FIRST TAB
		
		-- THIS IS THE BEGINNING OF THE SECOND TAB
		-- THIS IS THE BEGINNING OF THE SECOND TAB
		-- THIS IS THE BEGINNING OF THE SECOND TAB
		
		local EditTeam = vgui.Create( "DPanelList" )
		EditTeam:SetPos( 0, 0 )
		EditTeam:SetSize( MainMenuTabs:GetWide(), MainMenuTabs:GetTall() )
		EditTeam:SetSpacing( 5 )
		EditTeam:EnableHorizontal( false )
		EditTeam:EnableVerticalScrollbar( true )
		
		local Edit_Info_Teams = vgui.Create( "DLabel", EditTeam ) -- A label
		Edit_Info_Teams:SetPos( 50, -3 )
		Edit_Info_Teams:SetFont("Default")
		Edit_Info_Teams:SetText( "Teams" )
		Edit_Info_Teams:SetColor(Color(0,0,0,255))
		Edit_Info_Teams:SizeToContents()
		
		local Edit_Info_Spawns = vgui.Create( "DLabel", EditTeam ) -- A label
		Edit_Info_Spawns:SetPos( 180, -3 )
		Edit_Info_Spawns:SetFont("Default")
		Edit_Info_Spawns:SetText( "Spawns" )
		Edit_Info_Spawns:SetColor(Color(0,0,0,255))
		Edit_Info_Spawns:SizeToContents()
		
		local Edit_Info_Weapons = vgui.Create( "DLabel", EditTeam ) -- A label
		Edit_Info_Weapons:SetPos( 315, -3 )
		Edit_Info_Weapons:SetFont("Default")
		Edit_Info_Weapons:SetText( "Team's Weapons" )
		Edit_Info_Weapons:SetColor(Color(0,0,0,255))
		Edit_Info_Weapons:SizeToContents()
		
		local Edit_Info_WeaponsG = vgui.Create( "DLabel", EditTeam ) -- A label
		Edit_Info_WeaponsG:SetPos( 300, 117 )
		Edit_Info_WeaponsG:SetFont("Default")
		Edit_Info_WeaponsG:SetText( "Weapons Selection List" )
		Edit_Info_WeaponsG:SetColor(Color(0,0,0,255))
		Edit_Info_WeaponsG:SizeToContents()
		
		EditTeamListing = vgui.Create("DListView",EditTeam) -- Shows a list of all available teams
		EditTeamListing:SetPos(0, 10)
		EditTeamListing:SetSize(130, 200)
		EditTeamListing:SetMultiSelect(false)
		EditTeamListing:AddColumn("ID"):SetFixedWidth(20)
		EditTeamListing:AddColumn("Name")
		
		EditTeamSpawnListing = vgui.Create("DListView",EditTeam) -- Shows the spawnpoints for the team
		EditTeamSpawnListing:SetPos(135, 10)
		EditTeamSpawnListing:SetSize(130, 219)
		EditTeamSpawnListing:SetMultiSelect(false)
		EditTeamSpawnListing:AddColumn("ID"):SetFixedWidth(20)
		EditTeamSpawnListing:AddColumn("X")
		EditTeamSpawnListing:AddColumn("Y")
		EditTeamSpawnListing:AddColumn("Z")
		EditTeamSpawnListing:AddColumn("R"):SetFixedWidth(0)
		EditTeamSpawnListing:AddColumn("Y"):SetFixedWidth(0)
		EditTeamSpawnListing:AddColumn("P"):SetFixedWidth(0)
		
		EditTeamWeaponListing = vgui.Create("DListView",EditTeam) -- Shows the team's weapons
		EditTeamWeaponListing:SetPos(270, 10)
		EditTeamWeaponListing:SetSize(170, 105)
		EditTeamWeaponListing:SetMultiSelect(false)
		EditTeamWeaponListing:AddColumn("ID"):SetFixedWidth(20)
		EditTeamWeaponListing:AddColumn("Nice Name"):SetFixedWidth(100)
		EditTeamWeaponListing:AddColumn("Name")
		
		EditTeamWeaponListingPot = vgui.Create("DListView",EditTeam) -- Shows a list of all available weapons
		EditTeamWeaponListingPot:SetPos(270, 130)
		EditTeamWeaponListingPot:SetSize(170, 98)
		EditTeamWeaponListingPot:SetMultiSelect(false)
		EditTeamWeaponListingPot:AddColumn("Nice Name"):SetFixedWidth(110)
		EditTeamWeaponListingPot:AddColumn("Name")
		
		
		EditTeamListing.OnRowSelected = function( panel, line ) -- If someone selects a team, display the teams' information
		if IsValid(MainMenuCreationMenu) == true || IsValid(MainMenuCreationMenuEd) == true || IsValid(MainMenuCreationMenuI) == true || IsValid(MainMenuCreationMenuD) == true then
			if IsValid(TeamAddButton) == true then
				TeamAddButton:SetDisabled(true)
			end
			if IsValid(TeamDeleteButton) == true then
				TeamDeleteButton:SetDisabled(true)
			end
			if IsValid(TeamEditButton) == true then
				TeamEditButton:SetDisabled(true)
			end
			if IsValid(TeamInfoButton) == true then
				TeamInfoButton:SetDisabled(true)
			end
		else
		
			EditTeamSpawnListing:Clear() -- We need to clear each list, or it will just keep filling up
			EditTeamWeaponListing:Clear() -- We need to clear each list, or it will just keep filling up
			WhatTeamIsSelectedForEditing = EditTeamListing:GetLine(line):GetValue(1) -- Need to make a variable or this errors our later
			
			net.Start( "f2_menu_apple_fill_team_spawns" ) -- Fill the team spawn list
				net.WriteString(WhatTeamIsSelectedForEditing)
			net.SendToServer( ply )
			
			net.Start( "f2_menu_apple_fill_team_weapons" ) -- Fills the teams' weapons list
				net.WriteString(WhatTeamIsSelectedForEditing)
			net.SendToServer( ply )
			
			TeamAddButton:SetDisabled(false)
			TeamDeleteButton:SetDisabled(false)
			TeamEditButton:SetDisabled(false)
			TeamInfoButton:SetDisabled(false)
			
			if IsValid(EditTeamWeaponListingAdd) == true then EditTeamWeaponListingAdd:SetDisabled(true) end -- Just in case the button exists, disable it
			if IsValid(EditTeamWeaponListingRemove) == true then EditTeamWeaponListingRemove:SetDisabled(true) end -- Just in case the button exists, disable it
			EditTeamWeaponListingPot:Clear() -- We need to clear each list, or it will just keep filling up
			
			for k,v in pairs(weapons.GetList()) do -- Gets the list of all available weapons on the server
				local NewString = string.gsub( tostring(v['ClassName']), "_", " " )
				if string.find(NewString,"base") == nil then  -- If the weapon is base, don't show it on the list
					if v['PrintName'] == "" || v['PrintName'] == nil then
						EditTeamWeaponListingPot:AddLine( v['ClassName'], v['ClassName']) -- Add it now
					else
						EditTeamWeaponListingPot:AddLine( v['PrintName'], v['ClassName']) -- Add it now
					end
				end
			end
		end
		end
		
		
		TeamAddButton = vgui.Create( "DImageButton", EditTeam ) -- Add Team Button
		TeamAddButton:SetPos( 10, 212 )
		TeamAddButton:SetSize( 18, 18 )
		TeamAddButton:SetImage( "icon16/add.png" )
		TeamAddButton.DoClick = function()
			CreateNewTeam_adci(ply)
			TeamAddButton:SetDisabled(true)
			TeamDeleteButton:SetDisabled(true)
			TeamEditButton:SetDisabled(true)
			TeamInfoButton:SetDisabled(true)
		end
		
		TeamDeleteButton = vgui.Create( "DImageButton", EditTeam ) -- Delete Team Button
		TeamDeleteButton:SetPos( 40, 212 )
		TeamDeleteButton:SetSize( 18, 18 )
		TeamDeleteButton:SetImage( "icon16/delete.png" )
		TeamDeleteButton.DoClick = function()
		if WhatTeamIsSelectedForEditing == nil then 
			Derma_Message("You have not selected a team to delete", "ERROR", "OK")
		return
		elseif WhatTeamIsSelectedForEditing == 1 then
			Derma_Message("You can not delete the first or second teams. Just edit them!", "ERROR", "OK")
		return
		elseif WhatTeamIsSelectedForEditing == 2 then
			Derma_Message("You can not delete the first or second teams. Just edit this one!", "ERROR", "OK")
		return end
			DeleteTeam_adci(ply,team.GetName(WhatTeamIsSelectedForEditing),WhatTeamIsSelectedForEditing)
			TeamAddButton:SetDisabled(true)
			TeamDeleteButton:SetDisabled(true)
			TeamEditButton:SetDisabled(true)
			TeamInfoButton:SetDisabled(true)
		end
		
		TeamEditButton = vgui.Create( "DImageButton", EditTeam ) -- Edit Team Button
		TeamEditButton:SetPos( 70, 212 )
		TeamEditButton:SetSize( 18, 18 )
		TeamEditButton:SetImage( "icon16/pencil.png" )
		TeamEditButton.DoClick = function()
		if WhatTeamIsSelectedForEditing == nil then 
			Derma_Message("You have not selected a team to edit", "ERROR", "OK")
		return
		end
			EditTeam_adci(ply,WhatTeamIsSelectedForEditing)
			TeamAddButton:SetDisabled(true)
			TeamDeleteButton:SetDisabled(true)
			TeamEditButton:SetDisabled(true)
			TeamInfoButton:SetDisabled(true)
		end
		
		TeamInfoButton = vgui.Create( "DImageButton", EditTeam ) -- Information Team Button
		TeamInfoButton:SetPos( 100, 211 )
		TeamInfoButton:SetSize( 18, 18 )
		TeamInfoButton:SetImage( "icon16/book.png" )
		TeamInfoButton.DoClick = function()
		if WhatTeamIsSelectedForEditing == nil then 
			Derma_Message("You have not selected a team to look at information", "ERROR", "OK")
		return end
			TeamDeleteButton:SetDisabled(true)
			TeamEditButton:SetDisabled(true)
			TeamInfoButton:SetDisabled(true)
			InfoTeam_adci(ply,WhatTeamIsSelectedForEditing)
		end
		
		
		EditTeamWeaponListingPot.OnRowSelected = function( panel, line ) --Selected a weapon from the global list
			if IsValid(EditTeamWeaponListingAdd) == true then EditTeamWeaponListingAdd:SetDisabled(true) end -- Disables the button if it already exists
			
			EditTeamWeaponListingAdd = vgui.Create( "DButton", EditTeam ) -- Creates a button
			EditTeamWeaponListingAdd:SetPos( 446, 128 )
			EditTeamWeaponListingAdd:SetText( "ADD" )
			EditTeamWeaponListingAdd:SetSize( 28, 99 )
			EditTeamWeaponListingAdd.DoClick = function()
				net.Start( "f2_menu_apple_fill_team_weapons_add" ) -- Player clicked the button, so add it to the team
					net.WriteString(WhatTeamIsSelectedForEditing)
					net.WriteString(EditTeamWeaponListingPot:GetLine(line):GetValue(1))
					net.WriteString(EditTeamWeaponListingPot:GetLine(line):GetValue(2))
				net.SendToServer( ply )
				
				EditTeamWeaponListing:Clear() -- Now clear the list of team weapons
				
				net.Start( "f2_menu_apple_fill_team_weapons" ) -- Now fill them
					net.WriteString(WhatTeamIsSelectedForEditing)
				net.SendToServer( ply )
			end
			
			
		-- What this was is supposed to display the weapon, but it's not working for some reason
		/*	
			EditTeamWeaponListingPotView = vgui.Create( "DPanel" )
			EditTeamWeaponListingPotView:SetSize(256, 256)
			EditTeamWeaponListingPotView:SetPos(1075, 325)
			
			EditTeamWeaponListingPotView2 = vgui.Create( "DModelPanel", EditTeamWeaponListingPotView )
			EditTeamWeaponListingPotView2:SetModel( tostring(EditTeamWeaponListingPot:GetLine(line):GetValue(3)) )
			EditTeamWeaponListingPotView2:SetPos(-10, 0)
			EditTeamWeaponListingPotView2:SetSize( 450, 450 )
			EditTeamWeaponListingPotView2:SetCamPos( Vector( 0, 40, 0 ) )
			EditTeamWeaponListingPotView2:SetLookAt( Vector( 0, 0, 0 ) )
		*/
		end
		
		
		EditTeamWeaponListing.OnRowSelected = function( panel, line ) -- If the player selected a team weapon
			if IsValid(EditTeamWeaponListingRemove) == true then EditTeamWeaponListingRemove:SetDisabled(true) end -- Remove the button if it exists
			
			EditTeamWeaponListingRemove = vgui.Create( "DButton", EditTeam ) -- Creates a button
			EditTeamWeaponListingRemove:SetPos( 446, 10 )
			EditTeamWeaponListingRemove:SetText( "DEL" )
			EditTeamWeaponListingRemove:SetSize( 28, 105 )
			EditTeamWeaponListingRemove.DoClick = function()
				net.Start( "f2_menu_apple_fill_team_weapons_remove" ) -- Player clicked it, so delete it from the team
					net.WriteString(WhatTeamIsSelectedForEditing)
					net.WriteString(EditTeamWeaponListing:GetLine(line):GetValue(1))
				net.SendToServer( ply )
				
				EditTeamWeaponListing:Clear() -- Clear list
				
				net.Start( "f2_menu_apple_fill_team_weapons" ) -- Re add list
					net.WriteString(WhatTeamIsSelectedForEditing)
				net.SendToServer( ply )
				EditTeamWeaponListingRemove:SetDisabled(true)
			end

		end
		
		
		
		/*
		EditTeamWeaponListing.OnRowSelected = function( panel, line )
			local EditTeamWeaponListingOptions = DermaMenu()
			EditTeamWeaponListingOptions:AddOption("Add", function()
			
			end)
			EditTeamWeaponListingOptions:Open()
		end
		*/
		
		
		EditTeamSpawnListing.OnRowSelected = function( panel, line ) -- Player clicked team spawning
			local EditTeamSpawnListingOptions = DermaMenu() -- Adds options
			
			
			EditTeamSpawnListingOptions:AddOption("Add", function() -- Add a spawn
			EditTeamSpawnListing:Clear() -- Clears the list
			
				net.Start( "f2_menu_apple_fill_team_spawns_add" ) -- Sends the players current position
					net.WriteString(WhatTeamIsSelectedForEditing)
					net.WriteString(LocalPlayer():GetPos().x)
					net.WriteString(LocalPlayer():GetPos().y)
					net.WriteString(LocalPlayer():GetPos().z)
					net.WriteString(LocalPlayer():EyeAngles().x)
					net.WriteString(LocalPlayer():EyeAngles().y)
					net.WriteString(LocalPlayer():EyeAngles().z)
				net.SendToServer( ply )
				
			--	timer.Simple(0.75, function()
					net.Start( "f2_menu_apple_fill_team_spawns" ) -- Readds the list
						net.WriteString(WhatTeamIsSelectedForEditing)
					net.SendToServer( ply )
			--	end)
			end)
			
			
			EditTeamSpawnListingOptions:AddOption("Edit", function() -- This is honestly useless, only for the first spawn, because of some glitches
				net.Start( "f2_menu_apple_fill_team_spawns_edit" ) -- Sends the player current position
					net.WriteString(WhatTeamIsSelectedForEditing)
					net.WriteString(EditTeamSpawnListing:GetLine(line):GetValue(1))
					net.WriteString(LocalPlayer():GetPos().x)
					net.WriteString(LocalPlayer():GetPos().y)
					net.WriteString(LocalPlayer():GetPos().z)
					net.WriteString(LocalPlayer():EyeAngles().x)
					net.WriteString(LocalPlayer():EyeAngles().y)
					net.WriteString(LocalPlayer():EyeAngles().z)
				net.SendToServer( ply )
				
				EditTeamSpawnListing:Clear() -- Clears the list
				
			--	timer.Simple(0.75, function()
					net.Start( "f2_menu_apple_fill_team_spawns" ) -- Readds the list
						net.WriteString(WhatTeamIsSelectedForEditing)
					net.SendToServer( ply )
			--	end)
			end)
			
			
			EditTeamSpawnListingOptions:AddOption("Remove", function() -- Removes the button
			if tonumber(EditTeamSpawnListing:GetLine(line):GetValue(1)) == 1 then -- This won't allow you to delete all the spawns, or massive bugs will occur
				Derma_Message("You can not remove the last spawn, you may only edit this one!", "Error", "OK")
			return end
				net.Start( "f2_menu_apple_fill_team_spawns_remove" ) -- Remove it
					net.WriteString(WhatTeamIsSelectedForEditing)
					net.WriteString(EditTeamSpawnListing:GetLine(line):GetValue(1))
				net.SendToServer( ply )
				
				EditTeamSpawnListing:Clear() -- Clear list
				
			--	timer.Simple(0.75, function()
					net.Start( "f2_menu_apple_fill_team_spawns" ) -- Readd list
						net.WriteString(WhatTeamIsSelectedForEditing)
					net.SendToServer( ply )
			--	end)
			end)
			
			
			EditTeamSpawnListingOptions:AddOption("Goto", function() -- This is actually helpful, it allows the player to go to the exact position of the spawn
				net.Start( "f2_menu_apple_fill_team_spawns_goto" )
					net.WriteString(EditTeamSpawnListing:GetLine(line):GetValue(2))
					net.WriteString(EditTeamSpawnListing:GetLine(line):GetValue(3))
					net.WriteString(EditTeamSpawnListing:GetLine(line):GetValue(4))
					net.WriteString(EditTeamSpawnListing:GetLine(line):GetValue(5))
					net.WriteString(EditTeamSpawnListing:GetLine(line):GetValue(6))
					net.WriteString(EditTeamSpawnListing:GetLine(line):GetValue(7))
				net.SendToServer( ply )
			end)
			
			
		EditTeamSpawnListingOptions:Open() -- Can't remember why, but I need this or stuff doesn't work
		end
		
		net.Start( "f2_menu_apple_fill_edit" ) -- Fills the teams information to edit tab
		net.SendToServer( ply )
		
		-- THIS IS THE END OF THE SECOND TAB
		-- THIS IS THE END OF THE SECOND TAB
		-- THIS IS THE END OF THE SECOND TAB
		 
		MainMenuTabs:AddSheet( "General Info", GenInfo, "icon16/information.png", 
		false, false, "General team information" )
		MainMenuTabs:AddSheet( "Edit Teams", EditTeam, "icon16/pencil.png", 
		false, false, "Add, Delete, Edit teams" )
	end
	usermessage.Hook("f2_menu_apple", f2_menu_apple)
	
	
	
	
	
	
--	function f2_menu_apple_fill_editc(data) -- Clears the Team Table
--		if IsValid(EditTeamListing) == true then
--			EditTeamListing:Clear()
--		end
--	end
--	usermessage.Hook("f2_menu_apple_fill_editc", f2_menu_apple_fill_editc)
	
	function f2_menu_apple_fill_edit(data) -- Fills the edit menu with teams
		local TeamID = data:ReadShort()
		local TeamName = data:ReadString()
		local TeamName = string.gsub(TeamName,"_"," ")
		if IsValid(EditTeamListing) == true then
			EditTeamListing:AddLine(TeamID, TeamName)
		end
	end
	usermessage.Hook("f2_menu_apple_fill_edit", f2_menu_apple_fill_edit)
	
	local function f2_menu_apple_fill_team_weapons(data) -- Fills the teams weapons list
		local ID = data:ReadShort()
		local NName = data:ReadString()
		local Name = data:ReadString()
		if IsValid(EditTeamWeaponListing) == true then
			EditTeamWeaponListing:AddLine(ID, NName, Name)
		end
	end
	usermessage.Hook("f2_menu_apple_fill_team_weapons", f2_menu_apple_fill_team_weapons)
	
	local function f2_menu_apple_fill_team_spawns(data) -- Fills the teams spawns
		local ID = data:ReadShort()
		local X = data:ReadShort()
		local Y = data:ReadShort()
		local Z = data:ReadShort()
		local Roll = data:ReadShort()
		local Yaw = data:ReadShort()
		local Pitch = data:ReadShort()
		if IsValid(EditTeamSpawnListing) == true then
			EditTeamSpawnListing:AddLine(ID, X, Y, Z, Roll, Yaw, Pitch)
		end
	end
	usermessage.Hook("f2_menu_apple_fill_team_spawns", f2_menu_apple_fill_team_spawns)
	
	function f2_menu_apple_fill_gen(data) -- Fill the team's general information
		local TeamID = data:ReadShort()
		local k = data:ReadShort()
		local TeamName = data:ReadString()
		local TeamKills = data:ReadShort()
		local TeamDeaths = data:ReadShort()
		local TeamScore = data:ReadShort()
		local TeamRed = data:ReadShort()
		local TeamGreen = data:ReadShort()
		local TeamBlue = data:ReadShort()
		local TeamY = data:ReadShort()
		local TeamName = string.gsub(TeamName,"_"," ")
		if IsValid(TeamGenListing) == true then
			TeamGenListing:AddLine(TeamID, k, TeamName, TeamKills, TeamDeaths, TeamScore)
		end
	end
	usermessage.Hook("f2_menu_apple_fill_gen", f2_menu_apple_fill_gen)
	
	local function f2_menu_apple_fill_gen_players_c(data) -- Literally fucking just clears the list..
		if IsValid(TeamGenListingP) == true then
			TeamGenListingP:Clear()
		end
	end
	usermessage.Hook("f2_menu_apple_fill_gen_players_c", f2_menu_apple_fill_gen_players_c)
	
	local function f2_menu_apple_fill_gen_players(data) -- Fills the players in the general information
		if IsValid(TeamGenListingP) == true then
			local pname = data:ReadString()
			local tname = team.GetName(data:ReadShort())
			local prank = data:ReadString()
			local tname = string.gsub(tname, "_", " ")
			TeamGenListingP:AddLine(pname, tname, prank)
		end
	end
	usermessage.Hook("f2_menu_apple_fill_gen_players", f2_menu_apple_fill_gen_players)
	
	local function f2_menu_apple_error(data) -- You don't have permission
		chat.AddText(Color(255,0,0,255), "You do not have permission to view the gamemode's teams menu!")
	end
	usermessage.Hook("f2_menu_apple_error", f2_menu_apple_error)
	
	local function f2_menu_apple_erroru(data) -- You don't have permission
		chat.AddText(Color(255,0,0,255), "[ULX] You do not have permission to view the gamemode's teams menu!")
	end
	usermessage.Hook("f2_menu_apple_erroru", f2_menu_apple_erroru)
	
	function WeaponDuplicate(data) -- Gives the error that doesn't allow players to add duplicate weapons if they try.
		Derma_Message("You can not add two of the same weapons on the same team!","Error","OK")
	end
	usermessage.Hook("WeaponDuplicate", WeaponDuplicate)
	
end













if SERVER then
	
	function f2_menu_apple_fill_gen_func(ply) -- Fill the team's general information
		local TeamInfo = sql.Query( "SELECT * from apple_deathmatch_team ORDER BY Kills DESC;" )
		if TeamInfo == nil then return end
		for k, v in pairs(TeamInfo) do
		umsg.Start( "f2_menu_apple_fill_gen", ply )
			umsg.Short(v['ID'])
			umsg.Short(k)
			umsg.String(v['TeamName'])
			umsg.Short(v['Kills'])
			umsg.Short(v['Deaths'])
			umsg.Short(v['Score'])
			umsg.Short(v['Red'])
			umsg.Short(v['Green'])
			umsg.Short(v['Blue'])
			umsg.Short(v['Y'])
		umsg.End()
		end
	end
	
	function f2_menu_apple_fill_gen_players(ply) -- Fills the players in the general information
		umsg.Start( "f2_menu_apple_fill_gen_players_c" )
		umsg.End()
		for k, v in pairs(player.GetAll()) do
			if v:Team() > 0 && v:Team() < 1000 then
				umsg.Start( "f2_menu_apple_fill_gen_players" )
					umsg.String(v:Nick())
					umsg.Short(v:Team())
					umsg.String(sql.QueryValue( "SELECT Rank FROM apple_deathmatch_player_103 WHERE SteamID = '"..tostring(v:UniqueID()).."'" ))
				umsg.End()
			end
		end
	end
	
	function f2_menu_apple_fill_edit(ply) -- Fills the edit menu with teams
		local TeamInfo = sql.Query( "SELECT * from apple_deathmatch_team ORDER BY ID ASC;" )
		if TeamInfo == nil then return end
	--	umsg.Start( "f2_menu_apple_fill_editc", ply )
	--	umsg.End()
		for k, v in pairs(TeamInfo) do
		umsg.Start( "f2_menu_apple_fill_edit", ply )
			umsg.Short(v['ID'])
			umsg.String(v['TeamName'])
		umsg.End()
		end
	end

	net.Receive( "f2_menu_apple_fill_gen", function( len, ply ) -- Loads the teams for the menu separately
		f2_menu_apple_fill_gen_func(ply)
	end)
	
	net.Receive( "f2_menu_apple_fill_gen_players", function( len, ply ) -- Loads the teams for the menu separately
		f2_menu_apple_fill_gen_players(ply)
	end)
	
	net.Receive( "f2_menu_apple_fill_edit", function( len, ply ) -- Loads the teams for the menu separately
		f2_menu_apple_fill_edit(ply)
	end)
	
	net.Receive( "f2_menu_apple_fill_team_weapons", function( len, ply ) -- Load the weapons
	local NewTeamName_sv_teamweapons = string.gsub(team.GetName(tonumber(net.ReadString())), " ", "_") 
	local NewTeamName_sv_teamweapons = sql.SQLStr("apple_deathmatch_teamweapons_"..NewTeamName_sv_teamweapons)
	local NewTeamName_sv_teamweapons = string.gsub(NewTeamName_sv_teamweapons, "'", "") 
		local TeamInfo = sql.Query( "SELECT * from "..NewTeamName_sv_teamweapons )
		if TeamInfo == nil then return end
		for k, v in pairs(TeamInfo) do
		umsg.Start( "f2_menu_apple_fill_team_weapons", ply )
			umsg.Short(v['ID'])
			umsg.String(v['Nice'])
			umsg.String(v['Name'])
		umsg.End()
		end
	end)
	
	net.Receive( "f2_menu_apple_fill_team_spawns", function( len, ply ) -- Load the spawns
	local NewTeamName_sv_teamspawning = string.gsub(team.GetName(tonumber(net.ReadString())), " ", "_") 
	local NewTeamName_sv_teamspawning = sql.SQLStr("apple_deathmatch_"..game.GetMap().."_teamspawning_"..NewTeamName_sv_teamspawning)
	local NewTeamName_sv_teamspawning = string.gsub(NewTeamName_sv_teamspawning, "'", "")
		local TeamInfo = sql.Query( "SELECT * from "..NewTeamName_sv_teamspawning )
		if TeamInfo == nil then return end
		for k, v in pairs(TeamInfo) do
		umsg.Start( "f2_menu_apple_fill_team_spawns", ply )
			umsg.Short(v['ID'])
			umsg.Short(v['X'])
			umsg.Short(v['Y'])
			umsg.Short(v['Z'])
			umsg.Short(v['Roll'])
			umsg.Short(v['Yaw'])
			umsg.Short(v['Pitch'])
		umsg.End()
		end
	end)
	
	net.Receive( "f2_menu_apple_fill_team_spawns_add", function( len, ply ) -- Add new spawn
		local WhatTeamIsItAgain = net.ReadString()
		AddNewTeamSpawn(WhatTeamIsItAgain,net.ReadString(),net.ReadString(),net.ReadString(),net.ReadString(),net.ReadString(),net.ReadString(),(team.GetColor(tonumber(WhatTeamIsItAgain)).r),(team.GetColor(tonumber(WhatTeamIsItAgain)).g),(team.GetColor(tonumber(WhatTeamIsItAgain)).b))
	end)
	
	net.Receive( "f2_menu_apple_fill_team_weapons_add", function( len, ply ) -- Add new weapon
		AddNewTeamWeapon(net.ReadString(),net.ReadString(),net.ReadString(),ply)
	end)
	
	net.Receive( "f2_menu_apple_fill_team_spawns_edit", function( len, ply ) -- Add new spawn
		EditTeamSpawn(net.ReadString(),net.ReadString(),net.ReadString(),net.ReadString(),net.ReadString(),net.ReadString(),net.ReadString(),net.ReadString())
	end)
	
	net.Receive( "f2_menu_apple_fill_team_spawns_remove", function( len, ply ) -- remove a spawn
		RemoveTeamSpawn(net.ReadString(),net.ReadString())
	end)
	
	net.Receive( "f2_menu_apple_fill_team_weapons_remove", function( len, ply ) -- remove a spawn
		RemoveTeamWeapon(net.ReadString(),net.ReadString())
	end)
	
	net.Receive( "f2_menu_apple_fill_team_spawns_goto", function( len, ply ) -- Goto spawn
		ply:SetPos(Vector(net.ReadString(),net.ReadString(),net.ReadString()))
		ply:SetEyeAngles(Angle(""..net.ReadString().." "..net.ReadString().." "..net.ReadString()..""))
	end)

	local function LaunchF2Menu(ply) -- Opens the actual menu
		umsg.Start( "f2_menu_apple", ply )
			umsg.Entity(ply)
		umsg.End()
	end

	function GM:ShowTeam( ply ) -- Launched the F2 Menu
		if ULib != nil then
			if ULib.ucl.query( ply, "apple gamemode teams" ) == true then
				LaunchF2Menu(ply)	
			elseif ULib.ucl.query( ply, "apple gamemode teams" ) == false then
				umsg.Start( "f2_menu_apple_erroru", ply )
				umsg.End()	
			end
		elseif ply:IsSuperAdmin() == true then
			LaunchF2Menu(ply)
		else
			umsg.Start( "f2_menu_apple_error", ply )
			umsg.End()	
		end
	end

util.AddNetworkString( "f2_menu_apple_fill_gen" )
util.AddNetworkString( "f2_menu_apple_fill_edit" )
util.AddNetworkString( "f2_menu_apple_fill_team_spawns" )
util.AddNetworkString( "f2_menu_apple_fill_team_weapons" )
util.AddNetworkString( "f2_menu_apple_fill_team_spawns_goto" )
util.AddNetworkString( "f2_menu_apple_fill_team_spawns_add" )
util.AddNetworkString( "f2_menu_apple_fill_team_spawns_remove" )
util.AddNetworkString( "f2_menu_apple_fill_team_spawns_edit" )
util.AddNetworkString( "f2_menu_apple_fill_team_weapons_add" )
util.AddNetworkString( "f2_menu_apple_fill_team_weapons_remove" )
util.AddNetworkString( "f2_menu_apple_fill_gen_players" )

end

