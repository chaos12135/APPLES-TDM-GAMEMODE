-- Ranks


if CLIENT then
	function Classes_System_Menu()
	if IsValid(MainMenuClassSystemMenu) == true then return end
		MainMenuClassSystemMenu = vgui.Create( "DFrame" ) -- The menu
		MainMenuClassSystemMenu:SetSize(250, 150)
		MainMenuClassSystemMenu:SetTitle( "Class Choosing Menu" )
		MainMenuClassSystemMenu:SetDraggable( true )
		MainMenuClassSystemMenu:Center()
		MainMenuClassSystemMenu:MakePopup()
		MainMenuClassSystemMenu.OnClose = function()
		end
		
		local ClassesListing2L = vgui.Create( "DLabel", MainMenuClassSystemMenu ) -- A label
		ClassesListing2L:SetPos( 27, 25 )
		ClassesListing2L:SetFont("Default")
		ClassesListing2L:SetText( "Classes" )
		ClassesListing2L:SetColor(Color(0,0,0,255))
		ClassesListing2L:SizeToContents()
		
		local ClassesWeaponListing2L = vgui.Create( "DLabel", MainMenuClassSystemMenu ) -- A label
		ClassesWeaponListing2L:SetPos( 95, 25 )
		ClassesWeaponListing2L:SetFont("Default")
		ClassesWeaponListing2L:SetText( "Classes' Weapons" )
		ClassesWeaponListing2L:SetColor(Color(0,0,0,255))
		ClassesWeaponListing2L:SizeToContents()
		
		ClassesListing2 = vgui.Create("DListView",MainMenuClassSystemMenu) -- Shows a list of all available teams
		ClassesListing2:SetPos(6, 40)
		ClassesListing2:SetSize(80, 105)
		ClassesListing2:SetMultiSelect(false)
		ClassesListing2:AddColumn("ID"):SetFixedWidth(0)
		ClassesListing2:AddColumn("Name")
		
		ClassesWeaponListing2 = vgui.Create("DListView",MainMenuClassSystemMenu) -- Shows a list of all available teams
		ClassesWeaponListing2:SetPos(90, 40)
		ClassesWeaponListing2:SetSize(110, 105)
		ClassesWeaponListing2:SetMultiSelect(false)
		ClassesWeaponListing2:AddColumn("Name")
		
		ClassesListing2.OnRowSelected = function( panel, line )
			WhatClassAmISelecting = ClassesListing2:GetLine(line):GetValue(2)
			
			if IsValid(ClassesWeaponListing2) == true then
				ClassesWeaponListing2:Clear()
				net.Start( "f3_menu_apple_class_list22" )
					net.WriteString(WhatClassAmISelecting)
				net.SendToServer( ply )
			end
		end
		
		ClassSubmitButton = vgui.Create( "DButton", MainMenuClassSystemMenu )
		ClassSubmitButton:SetPos( 205, 75 )
		ClassSubmitButton:SetText( "GO!" )
		ClassSubmitButton:SetSize( 35, 25 )
		ClassSubmitButton.DoClick = function()
		if WhatClassAmISelecting2 == nil then
			Derma_Message("Something has gone terribly wrong. Please select the class again!", "ERROR", "OK")
		return end
			net.Start( "f3_menu_apple_edit_class_submit_go" )
				net.WriteString(WhatClassAmISelecting)
			net.SendToServer( ply )
			if IsValid(MainMenuClassSystemMenu) == true then
				MainMenuClassSystemMenu:Close()
			end
		end
		
		net.Start( "f3_menu_apple_class_list2" )
		net.SendToServer( ply )
		
	end
	
	hook.Add( "Think", "MenuKeyListener", function()
		if input.IsKeyDown( KEY_F5 ) == true then
			if IsValid(MainMenuClassSystemMenu) == false then
				net.Start( "f3_menu_apple_class_check_s" )
				net.SendToServer( LocalPlayer() )
			end
		end
	end)
	
function f3_menu_apple_class_list2(data)
	local id = data:ReadString()
	local name = data:ReadString()
	if IsValid(ClassesListing2) == true then
		ClassesListing2:AddLine(id,name)
	end
end
usermessage.Hook("f3_menu_apple_class_list2", f3_menu_apple_class_list2)

function f3_menu_apple_class_list22(data)
	local name = data:ReadString()
	if IsValid(ClassesWeaponListing2) == true then
		ClassesWeaponListing2:AddLine(name)
	end
end
usermessage.Hook("f3_menu_apple_class_list22", f3_menu_apple_class_list22)
	
	
usermessage.Hook("Classes_System_Menu", Classes_System_Menu)
end



if SERVER then
	net.Receive( "f3_menu_apple_class_check_s", function( len, ply )
	local WhatIsIt = sql.QueryValue( "SELECT Value FROM apple_deathmatch_settings WHERE ID = '11';" )
	if tonumber(WhatIsIt) == 0 then return end
		umsg.Start( "Classes_System_Menu", ply )
		--	umsg.Entity(ply)
		umsg.End()
	end)
	
	net.Receive( "f3_menu_apple_class_list22", function( len, ply )
	local NewClassName_sv_Classweapons = string.gsub((net.ReadString()), " ", "_")
	local NewClassName_sv_Classweapons = sql.SQLStr("apple_deathmatch_classes_"..NewClassName_sv_Classweapons)
	local NewClassName_sv_Classweapons = string.gsub(NewClassName_sv_Classweapons, "'", "") 
	local AllClassesW = sql.Query( "SELECT * FROM "..NewClassName_sv_Classweapons..";" )
	if AllClassesW == nil then return end
		for k, v in pairs(AllClassesW) do
			umsg.Start( "f3_menu_apple_class_list22", ply )
				umsg.String(v['Nice'])
			umsg.End()
		end
	end)
	
	net.Receive( "f3_menu_apple_edit_class_submit_go", function( len, ply ) -- Add new weapon
		ply:SetPData("AppleTDMGmodClass", net.ReadString())
	end)
	
	net.Receive( "f3_menu_apple_class_list2", function( len, ply ) -- Add new weapon
	local AllClasses = sql.Query( "SELECT * FROM apple_deathmatch_classes;" )
	if AllClasses == nil then return end
		for k, v in pairs(AllClasses) do
			umsg.Start( "f3_menu_apple_class_list2", ply )
				umsg.String(v['ID'])
				umsg.String(v['Name'])
			umsg.End()
		end
	end)
	
	
util.AddNetworkString( "f3_menu_apple_edit_class_submit_go" )
util.AddNetworkString( "f3_menu_apple_class_check_s" )
util.AddNetworkString( "f3_menu_apple_class_list22" )
util.AddNetworkString( "f3_menu_apple_class_list2" )
end