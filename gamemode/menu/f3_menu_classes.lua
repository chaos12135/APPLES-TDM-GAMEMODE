-- Ranks


if CLIENT then
	function RunClassesMenu(ply)
		if MainMenuF3 == nil then return end
		
		local Edit_Info_Classes = vgui.Create( "DLabel", DPanelListF33 ) -- A label
		Edit_Info_Classes:SetPos( 50, -3 )
		Edit_Info_Classes:SetFont("Default")
		Edit_Info_Classes:SetText( "Classes" )
		Edit_Info_Classes:SetColor(Color(0,0,0,255))
		Edit_Info_Classes:SizeToContents()
		
		local Edit_Info_ClassesW = vgui.Create( "DLabel", DPanelListF33 ) -- A label
		Edit_Info_ClassesW:SetPos( 315, -3 )
		Edit_Info_ClassesW:SetFont("Default")
		Edit_Info_ClassesW:SetText( "Classes' Weapons" )
		Edit_Info_ClassesW:SetColor(Color(0,0,0,255))
		Edit_Info_ClassesW:SizeToContents()
		
		local Edit_Info_ClassesWG = vgui.Create( "DLabel", DPanelListF33 ) -- A label
		Edit_Info_ClassesWG:SetPos( 300, 117 )
		Edit_Info_ClassesWG:SetFont("Default")
		Edit_Info_ClassesWG:SetText( "Weapons Selection List" )
		Edit_Info_ClassesWG:SetColor(Color(0,0,0,255))
		Edit_Info_ClassesWG:SizeToContents()
		
		EditClassesListing = vgui.Create("DListView",DPanelListF33) -- Shows a list of all available teams
		EditClassesListing:SetPos(0, 10)
		EditClassesListing:SetSize(130, 200)
		EditClassesListing:SetMultiSelect(false)
		EditClassesListing:AddColumn("ID"):SetFixedWidth(20)
		EditClassesListing:AddColumn("Name")
		
		EditClassesListing.OnRowSelected = function( panel, line ) -- If the player selected a team weapon
		WhatClassIsSelectedForEditingID = EditClassesListing:GetLine(line):GetValue(1)
		WhatClassIsSelectedForEditingName = EditClassesListing:GetLine(line):GetValue(2)
			if IsValid(ClassesDeleteButton) == true then
				ClassesDeleteButton:SetDisabled(false)
			end
			
			if IsValid(EditClassesWeaponListing) == true then
				EditClassesWeaponListing:SetDisabled(false)
			end
			if IsValid(EditClassesWeaponListingPot) == true then
				EditClassesWeaponListingPot:SetDisabled(false)
			end
			
			if IsValid(EditClassWeaponListingRemove) == true then
				EditClassWeaponListingRemove:SetDisabled(true)
			end
			if IsValid(EditClassesWeaponListingAdd) == true then
				EditClassesWeaponListingAdd:SetDisabled(true)
			end
			
			if IsValid(EditClassesWeaponListing) == true then
				EditClassesWeaponListing:Clear()
			end
			
			net.Start( "f2_menu_apple_fill_classes_weapons_ours" ) -- Player clicked the button, so add it to the team
				net.WriteString(WhatClassIsSelectedForEditingName)
			net.SendToServer( ply )
			
			if IsValid(EditClassesWeaponListingPot) == true then
			EditClassesWeaponListingPot:Clear()
				for k,v in pairs(weapons.GetList()) do -- Gets the list of all available weapons on the server
					local NewString = string.gsub( tostring(v['ClassName']), "_", " " )
					if string.find(NewString,"base") == nil then  -- If the weapon is base, don't show it on the list
						if v['PrintName'] == "" || v['PrintName'] == nil then
							EditClassesWeaponListingPot:AddLine( v['ClassName'], v['ClassName']) -- Add it now
						else
							EditClassesWeaponListingPot:AddLine( v['PrintName'], v['ClassName']) -- Add it now
						end
					end
				end
			end
		end
		
		EditClassesWeaponListing = vgui.Create("DListView",DPanelListF33) -- Shows the team's weapons
		EditClassesWeaponListing:SetPos(270, 10)
		EditClassesWeaponListing:SetSize(170, 105)
		EditClassesWeaponListing:SetMultiSelect(false)
		EditClassesWeaponListing:AddColumn("ID"):SetFixedWidth(20)
		EditClassesWeaponListing:AddColumn("Nice Name"):SetFixedWidth(100)
		EditClassesWeaponListing:AddColumn("Name")
		
		EditClassesWeaponListing.OnRowSelected = function( panel, line ) -- If the player selected a team weapon
			if IsValid(EditClassWeaponListingRemove) == true then EditClassWeaponListingRemove:Remove() end -- Remove the button if it exists
			
			EditClassWeaponListingRemove = vgui.Create( "DButton", DPanelListF33 ) -- Creates a button
			EditClassWeaponListingRemove:SetPos( 446, 10 )
			EditClassWeaponListingRemove:SetText( "DEL" )
			EditClassWeaponListingRemove:SetSize( 28, 105 )
			EditClassWeaponListingRemove.DoClick = function()
				net.Start( "f2_menu_apple_fill_class_weapons_remove" ) -- Player clicked it, so delete it from the team
					net.WriteString(WhatClassIsSelectedForEditingID)
					net.WriteString(EditClassesWeaponListing:GetLine(line):GetValue(1))
				net.SendToServer( ply )
				
				EditClassesWeaponListing:Clear() -- Clear list
				
				net.Start( "f2_menu_apple_fill_classes_weapons_ours" ) -- Player clicked the button, so add it to the team
					net.WriteString(WhatClassIsSelectedForEditingName)
				net.SendToServer( ply )
				EditClassWeaponListingRemove:SetDisabled(true)
			end

		end
		
		local Edit_Info_Classes_Use = vgui.Create( "DLabel", DPanelListF33 ) -- A label
		Edit_Info_Classes_Use:SetPos( 150, -3 )
		Edit_Info_Classes_Use:SetFont("Default")
		Edit_Info_Classes_Use:SetText( "Use Classes System?" )
		Edit_Info_Classes_Use:SetColor(Color(0,0,0,255))
		Edit_Info_Classes_Use:SizeToContents()
		
		GameSettingsUseClasses = vgui.Create( "DCheckBox", DPanelListF33 )
		GameSettingsUseClasses:SetPos( 150, 10 )
		GameSettingsUseClasses:SetValue( 1 )
		GameSettingsUseClasses:SetTooltip("Use classes?")
		GameSettingsUseClasses.OnChange = function( self )
		if GameSettingsUseClasses:GetChecked() == true then
			net.Start( "f3_menu_apple_setting_use_classes" )
				net.WriteString(1)
			net.SendToServer( ply )
			if IsValid(EditClassesListing) == true then
				EditClassesListing:SetDisabled(false)
			end
			if IsValid(EditClassesWeaponListing) == true then
				EditClassesWeaponListing:SetDisabled(false)
			end
			if IsValid(EditClassesWeaponListingPot) == true then
				EditClassesWeaponListingPot:SetDisabled(false)
			end
			if IsValid(ClassesAddButton) == true then
				ClassesAddButton:SetDisabled(false)
			end
			if IsValid(ClassesDeleteButton) == true then
				ClassesDeleteButton:SetDisabled(true)
			end
		else
			net.Start( "f3_menu_apple_setting_use_classes" )
				net.WriteString(0)
			net.SendToServer( ply )
			if IsValid(EditClassesListing) == true then
				EditClassesListing:SetDisabled(true)
			end
			if IsValid(EditClassesWeaponListing) == true then
				EditClassesWeaponListing:SetDisabled(true)
			end
			if IsValid(EditClassesWeaponListingPot) == true then
				EditClassesWeaponListingPot:SetDisabled(true)
			end
			if IsValid(ClassesAddButton) == true then
				ClassesAddButton:SetDisabled(true)
			end
			if IsValid(ClassesDeleteButton) == true then
				ClassesDeleteButton:SetDisabled(true)
			end
		end
		end
		
		EditClassesWeaponListingPot = vgui.Create("DListView",DPanelListF33) -- Shows a list of all available weapons
		EditClassesWeaponListingPot:SetPos(270, 130)
		EditClassesWeaponListingPot:SetSize(170, 98)
		EditClassesWeaponListingPot:SetMultiSelect(false)
		EditClassesWeaponListingPot:AddColumn("Nice Name"):SetFixedWidth(110)
		EditClassesWeaponListingPot:AddColumn("Name")
			
		EditClassesWeaponListingPot.OnRowSelected = function( panel, line ) --Selected a weapon from the global list
		if IsValid(EditClassesWeaponListingAdd) == true then EditClassesWeaponListingAdd:Remove() end -- Disables the button if it already exists
			EditClassesWeaponListingAdd = vgui.Create( "DButton", DPanelListF33 ) -- Creates a button
			EditClassesWeaponListingAdd:SetPos( 446, 128 )
			EditClassesWeaponListingAdd:SetText( "ADD" )
			EditClassesWeaponListingAdd:SetSize( 28, 99 )
			EditClassesWeaponListingAdd.DoClick = function()
				net.Start( "f2_menu_apple_fill_classes_weapons_add" ) -- Player clicked the button, so add it to the team
					net.WriteString(WhatClassIsSelectedForEditingID)
					net.WriteString(EditClassesWeaponListingPot:GetLine(line):GetValue(1))
					net.WriteString(EditClassesWeaponListingPot:GetLine(line):GetValue(2))
				net.SendToServer( ply )
				
				EditClassesWeaponListing:Clear()
				
				net.Start( "f2_menu_apple_fill_classes_weapons_ours" ) -- Player clicked the button, so add it to the team
					net.WriteString(WhatClassIsSelectedForEditingName)
				net.SendToServer( ply )
				
				EditClassesWeaponListingPot:Clear() -- Now clear the list of team weapons
				
				for k,v in pairs(weapons.GetList()) do -- Gets the list of all available weapons on the server
					local NewString = string.gsub( tostring(v['ClassName']), "_", " " )
					if string.find(NewString,"base") == nil then  -- If the weapon is base, don't show it on the list
						if v['PrintName'] == "" || v['PrintName'] == nil then
							EditClassesWeaponListingPot:AddLine( v['ClassName'], v['ClassName']) -- Add it now
						else
							EditClassesWeaponListingPot:AddLine( v['PrintName'], v['ClassName']) -- Add it now
						end
					end
				end
			end
		end
		
		ClassesAddButton = vgui.Create( "DImageButton", DPanelListF33 ) -- Add Team Button
		ClassesAddButton:SetPos( 10, 212 )
		ClassesAddButton:SetSize( 18, 18 )
		ClassesAddButton:SetImage( "icon16/add.png" )
		ClassesAddButton.DoClick = function()
			if IsValid(ClassesAddButton) == true then
				ClassesAddButton:SetDisabled(true)
			end
			if IsValid(ClassesDeleteButton) == true then
				ClassesDeleteButton:SetDisabled(true)
			end
			CreateNewClass(ply)
		end
		
		ClassesDeleteButton = vgui.Create( "DImageButton", DPanelListF33 ) -- Delete Team Button
		ClassesDeleteButton:SetPos( 40, 212 )
		ClassesDeleteButton:SetSize( 18, 18 )
		ClassesDeleteButton:SetImage( "icon16/delete.png" )
		ClassesDeleteButton:SetDisabled(true)
		ClassesDeleteButton.DoClick = function()
			DeleteClasses(ply,WhatClassIsSelectedForEditingID,WhatClassIsSelectedForEditingName)
			if IsValid(ClassesDeleteButton) == true then
				ClassesDeleteButton:SetDisabled(true)
			end
			if IsValid(EditClassesWeaponListingAdd) == true then EditClassesWeaponListingAdd:Remove() end -- Disables the button if it already exists
		end
	
		
		function DeleteClasses(ply,id,name)
			MainMenuClassesCreationMenuD = vgui.Create( "DFrame" )
			MainMenuClassesCreationMenuD:SetSize(150, 125)
			MainMenuClassesCreationMenuD:SetTitle( "Delete Class: "..name.."?" )
			MainMenuClassesCreationMenuD:SetDraggable( true )
			MainMenuClassesCreationMenuD:ShowCloseButton( true )
			MainMenuClassesCreationMenuD:Center()
			MainMenuClassesCreationMenuD:MakePopup()
			
			local ClassSubmitButton = vgui.Create( "DButton", MainMenuClassesCreationMenuD ) -- Creates a button
			ClassSubmitButton:SetPos( 25, 70 )
			ClassSubmitButton:SetText( "SUBMIT" )
			ClassSubmitButton:SetSize( 100, 15 )
			ClassSubmitButton.DoClick = function()
				net.Start( "f3_menu_apple_delete_class_submit" )
					net.WriteString(id)
					net.WriteString(name)
				net.SendToServer( ply )
				MainMenuClassesCreationMenuD:Close()
				
				if IsValid(EditClassesListing) == true then
					EditClassesListing:Clear()
				end
				
				net.Start( "f3_menu_apple_class_list" )
				net.SendToServer( ply )
			end
		end
		
		function CreateNewClass(ply)
			local MainMenuClassesCreationMenu = vgui.Create( "DFrame" ) -- The menu
			MainMenuClassesCreationMenu:SetSize(200, 100)
			MainMenuClassesCreationMenu:SetTitle( "Classes Creation Menu" )
			MainMenuClassesCreationMenu:SetDraggable( true )
			MainMenuClassesCreationMenu:Center()
			MainMenuClassesCreationMenu:MakePopup()
			MainMenuClassesCreationMenu.OnClose = function()
				if IsValid(ClassesAddButton) == true then
					ClassesAddButton:SetDisabled(false)
				end
				if IsValid(ClassesDeleteButton) == true then
					ClassesDeleteButton:SetDisabled(true)
				end
				if IsValid(EditClassesListing) == true then
					EditClassesListing:Clear()
				end
				net.Start( "f3_menu_apple_class_list" )
				net.SendToServer( ply )
			end
			
			local ClassNameLabel = vgui.Create("DLabel", MainMenuClassesCreationMenu )
			ClassNameLabel:SetPos(10,27)
			ClassNameLabel:SetColor( Color( 0, 0, 0, 255 ) )
			ClassNameLabel:SetFont( "DebugFixed2" )
			ClassNameLabel:SetText("Class Name:")
			ClassNameLabel:SizeToContents()
			
			local ClassName = vgui.Create( "DTextEntry", MainMenuClassesCreationMenu )
			ClassName:SetSize(150, 20)
			ClassName:SetPos(30, 42)
			ClassName:SetText("Class Name")
			ClassName.OnChange = function(ply)
				if string.len(ClassName:GetValue()) != 0 then
					ClassSubmitButton:SetDisabled(false)
				else
					ClassSubmitButton:SetDisabled(true)
				end
			end
			ClassSubmitButton = vgui.Create( "DButton", MainMenuClassesCreationMenu ) -- Creates a button
			ClassSubmitButton:SetPos( 50, 70 )
			ClassSubmitButton:SetText( "SUBMIT" )
			ClassSubmitButton:SetSize( 100, 15 )
			ClassSubmitButton.DoClick = function()
				net.Start( "f3_menu_apple_edit_class_submit" )
					net.WriteString(ClassName:GetValue())
				net.SendToServer( ply )
				if IsValid(MainMenuClassesCreationMenu) == true then
					MainMenuClassesCreationMenu:Close()
				end
			end
		end
		
	net.Start( "f3_menu_apple_class_list" )
	net.SendToServer( ply )
		
	end

	
	function f3_menu_apple_classes(data) -- Gives the error that doesn't allow players to add duplicate weapons if they try.
		local ID = data:ReadString()
		local Name = data:ReadString()
		if IsValid(EditClassesListing) == true then
			EditClassesListing:AddLine(ID, Name)
		end
	end
	usermessage.Hook("f3_menu_apple_classes", f3_menu_apple_classes)
	
	function f3_menu_apple_classes_our_l(data)
		local ID = data:ReadString()
		local Nice = data:ReadString()
		local Name = data:ReadString()
		if IsValid(EditClassesWeaponListing) == true then
			EditClassesWeaponListing:AddLine( ID, Nice, Name )
		end
	end
	usermessage.Hook("f3_menu_apple_classes_our_l", f3_menu_apple_classes_our_l)
	
	
	function f3_menu_apple_classes_error(data)
		Derma_Message("You can't have the same name for a class, choose another name!", "ERROR", "OK")
	end
	usermessage.Hook("f3_menu_apple_classes_error", f3_menu_apple_classes_error)
	
	
	function f3_menu_apple_use_classes(data)
	local GameSettingsUseClassesV = data:ReadString()
		if IsValid(GameSettingsUseClasses) == true then
				if GameSettingsUseClassesV == "1" then
					GameSettingsUseClasses:SetChecked(1)
				if IsValid(EditClassesListing) == true then
					EditClassesListing:SetDisabled(false)
				end
				if IsValid(EditClassesWeaponListing) == true then
					EditClassesWeaponListing:SetDisabled(true)
				end
				if IsValid(EditClassesWeaponListingPot) == true then
					EditClassesWeaponListingPot:SetDisabled(true)
				end
				if IsValid(ClassesAddButton) == true then
					ClassesAddButton:SetDisabled(false)
				end
				if IsValid(ClassesDeleteButton) == true then
					ClassesDeleteButton:SetDisabled(true)
				end
			else
				GameSettingsUseClasses:SetChecked(0)
				if IsValid(EditClassesListing) == true then
					EditClassesListing:SetDisabled(true)
				end
				if IsValid(EditClassesWeaponListing) == true then
					EditClassesWeaponListing:SetDisabled(true)
				end
				if IsValid(EditClassesWeaponListingPot) == true then
					EditClassesWeaponListingPot:SetDisabled(true)
				end
				if IsValid(ClassesAddButton) == true then
					ClassesAddButton:SetDisabled(true)
				end
				if IsValid(ClassesDeleteButton) == true then
					ClassesDeleteButton:SetDisabled(true)
				end
			end
		end
	end
	usermessage.Hook("f3_menu_apple_use_classes", f3_menu_apple_use_classes)

end



if SERVER then

function CreateNewClassWeaponDB()
	local GENERICA_CLASSWEAPONS = sql.Query( "SELECT Name from apple_deathmatch_classes;" ) -- Gets just the team name for this
	if GENERICA_CLASSWEAPONS == nil then return end
	if sql.LastError() != nil then
		 -- MsgN("sv_teamweapons.lua: "..sql.LastError())
	end
	for k, v in pairs(GENERICA_CLASSWEAPONS) do
	local NewClassName_sv_Classweapons = string.gsub(v['Name'], " ", "_")
	local NewClassName_sv_Classweapons = sql.SQLStr("apple_deathmatch_classes_"..NewClassName_sv_Classweapons)
	local NewClassName_sv_Classweapons = string.gsub(NewClassName_sv_Classweapons, "'", "") 
			
		if sql.TableExists(NewClassName_sv_Classweapons) == false then
			sql.Query( "CREATE TABLE "..NewClassName_sv_Classweapons.." ( ID int, Nice varchar(255), Name varchar(255))" )
			if sql.LastError() != nil then
				 -- MsgN("sv_teamweapons.lua: "..sql.LastError())
			end
			sql.Query( "INSERT INTO "..NewClassName_sv_Classweapons.." ( `ID`, `Nice`, `Name`) VALUES ( '1', 'Medkit', 'weapon_medkit' )" )
			if sql.LastError() != nil then
				 -- MsgN("sv_teamweapons.lua: "..sql.LastError())
			end
			-- MsgN("Creating team weapons table for: "..v['TeamName'])
		end
	end
end

function CreateNewClassWeaponDBFirst()
	local GENERICA_CLASSWEAPONS = sql.Query( "SELECT Name from apple_deathmatch_classes;" ) -- Gets just the team name for this
	if GENERICA_CLASSWEAPONS == nil then return end
	if sql.LastError() != nil then
		 -- MsgN("sv_teamweapons.lua: "..sql.LastError())
	end
	for k, v in pairs(GENERICA_CLASSWEAPONS) do
	local NewClassName_sv_Classweapons = string.gsub(v['Name'], " ", "_")
	local NewClassName_sv_Classweapons = sql.SQLStr("apple_deathmatch_classes_"..NewClassName_sv_Classweapons)
	local NewClassName_sv_Classweapons = string.gsub(NewClassName_sv_Classweapons, "'", "") 
			
		if sql.TableExists(NewClassName_sv_Classweapons) == false then
			sql.Query( "CREATE TABLE "..NewClassName_sv_Classweapons.." ( ID int, Nice varchar(255), Name varchar(255))" )
			-- MsgN("Creating team weapons table for: "..v['TeamName'])
		end
	end
	sql.Query( "INSERT INTO apple_deathmatch_classes_Assault ( `ID`, `Nice`, `Name`) VALUES ( '1', 'Five Seven', 'weapon_real_cs_five-seven' )" )
	sql.Query( "INSERT INTO apple_deathmatch_classes_Assault ( `ID`, `Nice`, `Name`) VALUES ( '2', 'Galil', 'weapon_real_cs_galil' )" )
	sql.Query( "INSERT INTO apple_deathmatch_classes_Sniper ( `ID`, `Nice`, `Name`) VALUES ( '1', 'Sniper', 'weapon_real_cs_awp' )" )
	sql.Query( "INSERT INTO apple_deathmatch_classes_Sniper ( `ID`, `Nice`, `Name`) VALUES ( '2', 'Glock', 'weapon_real_cs_glock18' )" )
	sql.Query( "INSERT INTO apple_deathmatch_classes_Heavy ( `ID`, `Nice`, `Name`) VALUES ( '1', 'Pump Shotgun', 'weapon_real_cs_pumpshotgun' )" )
	sql.Query( "INSERT INTO apple_deathmatch_classes_Heavy ( `ID`, `Nice`, `Name`) VALUES ( '2', 'Deagle', 'weapon_real_cs_desert_eagle' )" )
end


	function CreateClassesDB()
	local GENERICA_SETTINGS = sql.Query( "SELECT * FROM apple_deathmatch_classes;" )
	if GENERICA_SETTINGS == nil then return end
	
		if sql.TableExists("apple_deathmatch_classes") == false then
			sql.Query( "CREATE TABLE apple_deathmatch_classes ( ID int, Name varchar(255) )" )
			sql.Query( "INSERT INTO apple_deathmatch_classes ( `ID`, `Name`) VALUES ( '1', 'Assault')" )
			sql.Query( "INSERT INTO apple_deathmatch_classes ( `ID`, `Name`) VALUES ( '2', 'Sniper')" )
			sql.Query( "INSERT INTO apple_deathmatch_classes ( `ID`, `Name`) VALUES ( '3', 'Heavy')" )
			CreateNewClassWeaponDBFirst()
		end
	end
	CreateClassesDB()
	
	
	net.Receive( "f3_menu_apple_class_list", function( len, ply ) -- Add new weapon
	local AllClasses = sql.Query( "SELECT * FROM apple_deathmatch_classes;" )
	local SettingsInfoUseClasses = sql.QueryValue( "SELECT Value from apple_deathmatch_settings WHERE ID = '11';" )
		umsg.Start( "f3_menu_apple_use_classes", ply )
			umsg.String(SettingsInfoUseClasses)
		umsg.End()
	if AllClasses == nil then return end
		for k, v in pairs(AllClasses) do
			umsg.Start( "f3_menu_apple_classes", ply )
				umsg.String(v['ID'])
				umsg.String(v['Name'])
			umsg.End()
		end
	end)
	
	net.Receive( "f3_menu_apple_setting_use_classes", function( len, ply )
		local ClassesUse = net.ReadString()
		sql.Query( "UPDATE apple_deathmatch_settings SET Value = '"..ClassesUse.."' WHERE ID = '11' " )
	end)
	
	function FixTeamIDOrderClassWep()
	local SelectedResetClassWep = sql.Query( "SELECT * FROM apple_deathmatch_classes ORDER BY ID ASC;" )
	if SelectedResetClassWep == nil then return end
		if sql.LastError() != nil then
			 -- MsgN("sv_teamweapons.lua: "..sql.LastError())
		end
		for k, v in pairs(SelectedResetClassWep) do
			sql.Query( "UPDATE apple_deathmatch_classes SET ID = '"..k.."' WHERE ID = '"..tonumber(v['ID']).."'" )
		if sql.LastError() != nil then
			 -- MsgN("sv_teamweapons.lua: "..sql.LastError())
		end
		end
	end
	
	function FixTeamIDOrderClassWep2(NewClassName_sv_Classweapons)
	local SelectedResetClassWep2 = sql.Query( "SELECT * FROM "..NewClassName_sv_Classweapons.." ORDER BY ID ASC;" )
	if SelectedResetClassWep2 == nil then return end
		if sql.LastError() != nil then
			 -- MsgN("sv_teamweapons.lua: "..sql.LastError())
		end
		for k, v in pairs(SelectedResetClassWep2) do
			sql.Query( "UPDATE "..NewClassName_sv_Classweapons.." SET ID = '"..k.."' WHERE ID = '"..tonumber(v['ID']).."'" )
		if sql.LastError() != nil then
			 -- MsgN("sv_teamweapons.lua: "..sql.LastError())
		end
		end
	end
	
	net.Receive( "f2_menu_apple_fill_classes_weapons_ours", function( len, ply ) -- Add new weapon
		local NewClassName_sv_Classweapons = string.gsub(net.ReadString(), " ", "_")
		local NewClassName_sv_Classweapons = sql.SQLStr("apple_deathmatch_classes_"..NewClassName_sv_Classweapons)
		local NewClassName_sv_Classweapons = string.gsub(NewClassName_sv_Classweapons, "'", "") 
		local WhatDB = sql.Query( "SELECT * FROM "..NewClassName_sv_Classweapons.." ORDER BY ID ASC;" )
		if WhatDB == nil then return end
		for k, v in pairs(WhatDB) do
			umsg.Start( "f3_menu_apple_classes_our_l", ply )
				umsg.String(v['ID'])
				umsg.String(v['Nice'])
				umsg.String(v['Name'])
			umsg.End()
		end
	end)
	
	net.Receive( "f2_menu_apple_fill_classes_weapons_add", function( len, ply ) -- Add new weapon
	local ID = net.ReadString()
	local Nice = net.ReadString()
	local Name = net.ReadString()
	local CheckName = sql.QueryValue( "SELECT Name FROM apple_deathmatch_classes WHERE ID = '"..tonumber(ID).."';" )
		local NewClassName_sv_Classweapons = string.gsub(CheckName, " ", "_")
		local NewClassName_sv_Classweapons = sql.SQLStr("apple_deathmatch_classes_"..NewClassName_sv_Classweapons)
		local NewClassName_sv_Classweapons = string.gsub(NewClassName_sv_Classweapons, "'", "") 
		
		local LastNum = sql.QueryValue( "SELECT ID FROM "..NewClassName_sv_Classweapons.." ORDER BY ID DESC;" )
		if LastNum == nil then
			sql.Query( "INSERT INTO "..NewClassName_sv_Classweapons.." ( `ID`, `Nice`, `Name`) VALUES ( '1', "..(sql.SQLStr(Nice))..", "..(sql.SQLStr(Name)).." )" )
		else
			sql.Query( "INSERT INTO "..NewClassName_sv_Classweapons.." ( `ID`, `Nice`, `Name`) VALUES ( '"..(tonumber(LastNum)+1).."', "..(sql.SQLStr(Nice))..", "..(sql.SQLStr(Name)).." )" )
			FixTeamIDOrderClassWep2(NewClassName_sv_Classweapons)
		end
	end)
	
	
	net.Receive( "f2_menu_apple_fill_class_weapons_remove", function( len, ply ) -- Add new weapon
	local CID = net.ReadString()
	local ID = net.ReadString()
	local CheckName = sql.QueryValue( "SELECT Name FROM apple_deathmatch_classes WHERE ID = '"..tonumber(CID).."';" )
		local NewClassName_sv_Classweapons = string.gsub(CheckName, " ", "_")
		local NewClassName_sv_Classweapons = sql.SQLStr("apple_deathmatch_classes_"..NewClassName_sv_Classweapons)
		local NewClassName_sv_Classweapons = string.gsub(NewClassName_sv_Classweapons, "'", "") 
		sql.Query( "DELETE FROM "..NewClassName_sv_Classweapons.." WHERE ID = '"..tonumber(ID).."'" )
		FixTeamIDOrderClassWep2(NewClassName_sv_Classweapons)
	end)
	
	
	net.Receive( "f3_menu_apple_delete_class_submit", function( len, ply ) -- Add new weapon
		sql.Query( "DELETE FROM apple_deathmatch_classes WHERE ID = '"..tonumber(net.ReadString()).."'" )
		
		local NewClassName_sv_Classweapons = string.gsub(net.ReadString(), " ", "_")
		local NewClassName_sv_Classweapons = sql.SQLStr("apple_deathmatch_classes_"..NewClassName_sv_Classweapons)
		local NewClassName_sv_Classweapons = string.gsub(NewClassName_sv_Classweapons, "'", "") 
		local Trash = ("AP_GM_TRASH_CS_"..tostring(os.time()).."")
		sql.Query( "ALTER TABLE "..NewClassName_sv_Classweapons.." RENAME TO "..tostring(Trash).."" )
		
		FixTeamIDOrderClassWep()
	end)
	
	
	net.Receive( "f3_menu_apple_edit_class_submit", function( len, ply ) -- Add new weapon
		local NewClassName = net.ReadString()
		local CheckSame = sql.QueryValue( "SELECT Name FROM apple_deathmatch_classes WHERE Name = "..(sql.SQLStr(NewClassName))..";" )
		if CheckSame != nil then 
			umsg.Start( "f3_menu_apple_classes_error", ply )
			umsg.End()
		return end
		local LastNum = sql.QueryValue( "SELECT ID FROM apple_deathmatch_classes ORDER BY ID DESC;" )
		if LastNum == nil then
			sql.Query( "INSERT INTO apple_deathmatch_classes ( `ID`, `Name`) VALUES ( '1', "..(sql.SQLStr(NewClassName))..")" )
			CreateNewClassWeaponDB()
		else
			sql.Query( "INSERT INTO apple_deathmatch_classes ( `ID`, `Name`) VALUES ( '"..(tonumber(LastNum)+1).."', "..(sql.SQLStr(NewClassName))..")" )
			CreateNewClassWeaponDB()
			FixTeamIDOrderClassWep()
		end
	end)
	
	
util.AddNetworkString( "f3_menu_apple_edit_class_submit" )
util.AddNetworkString( "f2_menu_apple_fill_class_weapons_remove" )
util.AddNetworkString( "f3_menu_apple_setting_use_classes" )
util.AddNetworkString( "f3_menu_apple_class_list" )
util.AddNetworkString( "f3_menu_apple_delete_class_submit" )
util.AddNetworkString( "f2_menu_apple_fill_classes_weapons_ours" )
util.AddNetworkString( "f2_menu_apple_fill_classes_weapons_add" )
end













