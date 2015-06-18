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
		
		EditClassesWeaponListing = vgui.Create("DListView",DPanelListF33) -- Shows the team's weapons
		EditClassesWeaponListing:SetPos(270, 10)
		EditClassesWeaponListing:SetSize(170, 105)
		EditClassesWeaponListing:SetMultiSelect(false)
		EditClassesWeaponListing:AddColumn("ID"):SetFixedWidth(20)
		EditClassesWeaponListing:AddColumn("Nice Name"):SetFixedWidth(100)
		EditClassesWeaponListing:AddColumn("Name")
		
		EditClassesWeaponListingPot = vgui.Create("DListView",DPanelListF33) -- Shows a list of all available weapons
		EditClassesWeaponListingPot:SetPos(270, 130)
		EditClassesWeaponListingPot:SetSize(170, 98)
		EditClassesWeaponListingPot:SetMultiSelect(false)
		EditClassesWeaponListingPot:AddColumn("Nice Name"):SetFixedWidth(110)
		EditClassesWeaponListingPot:AddColumn("Name")
		
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
		
		EditClassesListing.OnRowSelected = function( panel, line ) -- If the player selected a team weapon
		WhatClassIsSelectedForEditingID = EditClassesListing:GetLine(line):GetValue(1)
		WhatClassIsSelectedForEditingName = EditClassesListing:GetLine(line):GetValue(2)
			if IsValid(ClassesDeleteButton) == true then
				ClassesDeleteButton:SetDisabled(false)
			end
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
		end
	
		
		function DeleteClasses(ply,id,name)
			MainMenuClassesCreationMenuD = vgui.Create( "DFrame" )
			MainMenuClassesCreationMenuD:SetSize(150, 125)
			MainMenuClassesCreationMenuD:SetTitle( "Delete Class: "..name.."?" )
			MainMenuClassesCreationMenuD:SetDraggable( true )
			MainMenuClassesCreationMenuD:ShowCloseButton( true )
			MainMenuClassesCreationMenuD:Center()
			MainMenuClassesCreationMenuD:MakePopup()
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
				MainMenuClassesCreationMenu:Close()
			end
		end
		
	net.Start( "f3_menu_apple_class_list" )
	net.SendToServer( ply )
		
	end

	function f3_menu_apple_classes(data) -- Gives the error that doesn't allow players to add duplicate weapons if they try.
		local ID = data:ReadString()
		local Name = data:ReadString()
		EditClassesListing:AddLine(ID, Name)
	end
	usermessage.Hook("f3_menu_apple_classes", f3_menu_apple_classes)
end



if SERVER then
	function CreateClassesDB()
	local GENERICA_SETTINGS = sql.Query( "SELECT * FROM apple_deathmatch_classes;" )
	if GENERICA_SETTINGS == nil then return end
	
		if sql.TableExists("apple_deathmatch_classes") == false then
			sql.Query( "CREATE TABLE apple_deathmatch_classes ( ID int, Name varchar(255) )" )
		end
	end
	CreateClassesDB()
	
	
	net.Receive( "f3_menu_apple_class_list", function( len, ply ) -- Add new weapon
	local AllClasses = sql.Query( "SELECT * FROM apple_deathmatch_classes;" )
	if AllClasses == nil then return end
		for k, v in pairs(AllClasses) do
			umsg.Start( "f3_menu_apple_classes", ply )
				umsg.String(v['ID'])
				umsg.String(v['Name'])
			umsg.End()
		end
	end)
	
	net.Receive( "f3_menu_apple_edit_class_submit", function( len, ply ) -- Add new weapon
		local LastNum = sql.QueryValue( "SELECT ID FROM apple_deathmatch_classes ORDER BY ID DESC;" )
		if LastNum == nil then
			sql.Query( "INSERT INTO apple_deathmatch_classes ( `ID`, `Name`) VALUES ( '1', "..(sql.SQLStr(net.ReadString()))..")" )
		else
			sql.Query( "INSERT INTO apple_deathmatch_classes ( `ID`, `Name`) VALUES ( '"..(tonumber(LastNum)+1).."', "..(sql.SQLStr(net.ReadString()))..")" )
		end
	end)
	
	
util.AddNetworkString( "f3_menu_apple_edit_class_submit" )
util.AddNetworkString( "f3_menu_apple_class_list" )
end













