-- Ranks


if CLIENT then
	function RunAmmoTypesMenu(ply)
		if MainMenuF3 == nil then return end
		AmmoTypesList = vgui.Create( "DListView", DPanelListF35 )
		AmmoTypesList:SetMultiSelect( false )
		AmmoTypesList:SetPos( 0, 17 )
		AmmoTypesList:SetSize( 400, 195 )
		AmmoTypesList:AddColumn( "Ammo Types" ):SetFixedWidth(90)
		AmmoTypesList:AddColumn( "Desc" )
		AmmoTypesList:AddColumn( "Amount" ):SetFixedWidth(50)
		AmmoTypesList.OnRowSelected = function( panel, line )
			if IsValid(AmmoTypeEntry) then
				AmmoTypeEntry:SetDisabled( false )
				AmmoTypeEntry:SetText( AmmoTypesList:GetLine(line):GetValue(3) )
			end
			WhatAmmoAreWeEditing = AmmoTypesList:GetLine(line):GetValue(1)
		end
		
		net.Start( "f3_menu_apple_ammo_types" )
		net.SendToServer( ply )
		
		local AmmoTypesListLabel = vgui.Create("DLabel", DPanelListF35 )
		AmmoTypesListLabel:SetPos(180,03)
		AmmoTypesListLabel:SetColor( Color( 0, 0, 0, 255 ) )
		AmmoTypesListLabel:SetFont( "DebugFixed2" )
		AmmoTypesListLabel:SetText("List of Ammo:")
		AmmoTypesListLabel:SizeToContents()
		
		local AmmoTypesListLabel2 = vgui.Create("DLabel", DPanelListF35 )
		AmmoTypesListLabel2:SetPos(85,212)
		AmmoTypesListLabel2:SetColor( Color( 0, 0, 0, 255 ) )
		AmmoTypesListLabel2:SetFont( "DebugFixed2" )
		AmmoTypesListLabel2:SetText("The amount of ammo the player will receive on spawn.")
		AmmoTypesListLabel2:SizeToContents()
		
		local AmmoTypesListELabel = vgui.Create("DLabel", DPanelListF35 )
		AmmoTypesListELabel:SetPos(420,25)
		AmmoTypesListELabel:SetColor( Color( 0, 0, 0, 255 ) )
		AmmoTypesListELabel:SetFont( "DebugFixed2" )
		AmmoTypesListELabel:SetText("Amount:")
		AmmoTypesListELabel:SizeToContents()
		
		AmmoTypeEntry = vgui.Create( "DTextEntry", DPanelListF35 )
		AmmoTypeEntry:SetPos( 410, 40 )
		AmmoTypeEntry:SetSize(60, 20)
		AmmoTypeEntry:SetText( 0 )
		AmmoTypeEntry:SetDisabled( true )
		AmmoTypeEntry.OnChange = function( self )
		local AmmoTypeEntry = string.gsub(AmmoTypeEntry:GetValue(),"%D", "")
		local AmmoTypeEntry = string.gsub(AmmoTypeEntry,"%W", "")
		if string.len(AmmoTypeEntry) != 0 then
			ReplaceToNumbersONLY2 = AmmoTypeEntry
		else
			ReplaceToNumbersONLY2 = "0"
		end
			net.Start( "f3_menu_apple_setting_ammo_types" )
				net.WriteString(WhatAmmoAreWeEditing)
				net.WriteString(ReplaceToNumbersONLY2)
			net.SendToServer( ply )
			
			if IsValid(AmmoTypesList) then
				AmmoTypesList:Clear()
			end
			
			net.Start( "f3_menu_apple_ammo_types" )
			net.SendToServer( ply )
		end
	end
	
	function f3_menu_apple_ammo_types(data)
		local ClassName = data:ReadString()
		local Desc = data:ReadString()
		local Amount = data:ReadString()
		if IsValid(AmmoTypesList) == true then
			AmmoTypesList:AddLine( ClassName, Desc, Amount )
		end
	end
	usermessage.Hook("f3_menu_apple_ammo_types", f3_menu_apple_ammo_types)
end




if SERVER then


function CreateAmmoTypesDB()
	local GENERICA_AT_SETTINGS = sql.Query( "SELECT * FROM apple_deathmatch_ammo_types;" )
	if GENERICA_AT_SETTINGS == nil then return end
	
		if sql.TableExists("apple_deathmatch_ammo_types") == false then
			sql.Query( "CREATE TABLE apple_deathmatch_ammo_types ( Name varchar, Desc varchar(255), Ammo varchar(255) )" )
			sql.Query( "INSERT INTO apple_deathmatch_ammo_types ( `Name`, `Desc`, `Ammo`) VALUES ( 'AR2', 'Works with all heavy weapons', '32')" )
			sql.Query( "INSERT INTO apple_deathmatch_ammo_types ( `Name`, `Desc`, `Ammo`) VALUES ( 'Pistol', 'Works with all pistols (except heavy)', '12')" )
			sql.Query( "INSERT INTO apple_deathmatch_ammo_types ( `Name`, `Desc`, `Ammo`) VALUES ( 'SMG1', 'Works with all sub-machine guns', '32')" )
			sql.Query( "INSERT INTO apple_deathmatch_ammo_types ( `Name`, `Desc`, `Ammo`) VALUES ( '357', 'Works with all heavy pistols', '12')" )
			sql.Query( "INSERT INTO apple_deathmatch_ammo_types ( `Name`, `Desc`, `Ammo`) VALUES ( 'XBowBolt', 'Cross bow and specials maybe?', '6')" )
			sql.Query( "INSERT INTO apple_deathmatch_ammo_types ( `Name`, `Desc`, `Ammo`) VALUES ( 'Buckshot', 'Works with all shotguns', '12')" )
			sql.Query( "INSERT INTO apple_deathmatch_ammo_types ( `Name`, `Desc`, `Ammo`) VALUES ( 'RPG_Round', 'Works with all RPG types', '2')" )
			sql.Query( "INSERT INTO apple_deathmatch_ammo_types ( `Name`, `Desc`, `Ammo`) VALUES ( 'SMG1_Grenade', 'Weapons with secondary functions', '2')" )
			sql.Query( "INSERT INTO apple_deathmatch_ammo_types ( `Name`, `Desc`, `Ammo`) VALUES ( 'Grenade', 'All explosives and smoke types', '1')" )
		end
end
CreateAmmoTypesDB()


net.Receive( "f3_menu_apple_setting_ammo_types", function( len, ply )
local NameStr = net.ReadString()
local Amount = net.ReadString()
	sql.Query( "UPDATE apple_deathmatch_ammo_types SET Ammo = '"..Amount.."' WHERE Name = '"..NameStr.."' " )
end)


net.Receive( "f3_menu_apple_ammo_types", function( len, ply )
	local GENERICA_AT_SETTINGS = sql.Query( "SELECT * FROM apple_deathmatch_ammo_types;" )
	if GENERICA_AT_SETTINGS == nil then return end
	for k, v in pairs(GENERICA_AT_SETTINGS) do
		umsg.Start( "f3_menu_apple_ammo_types", ply )
			umsg.String(v['Name'])
			umsg.String(v['Desc'])
			umsg.String(v['Ammo'])
		umsg.End()
	end
end)



util.AddNetworkString( "f3_menu_apple_ammo_types" )
util.AddNetworkString( "f3_menu_apple_setting_ammo_types" )
end






