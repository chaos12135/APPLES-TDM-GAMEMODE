-- Ranks


if CLIENT then
	function RunRanksMenu(ply)
		if MainMenuF3 == nil then return end
		
		RankListing = vgui.Create("DListView", DPanelListF32)
		RankListing:SetPos(246, 10)
		RankListing:SetSize(195, 210)
		RankListing:SetMultiSelect(false)
		RankListing:AddColumn("Level"):SetFixedWidth(40)
		RankListing:AddColumn("Name")
		RankListing:AddColumn("Req"):SetFixedWidth(30)
		RankListing:AddColumn("Material"):SetFixedWidth(0)
		
		RankImageL = vgui.Create( "DImage", DPanelListF32 )
		RankImageL:SetPos( 10, 10 )
		--RankImageL:SetImage( "apple_ranks/test.png" )
		--RankImageL:SizeToContents()
		
		RankListing.OnRowSelected = function( panel, line )
			GLOBAL_RANK_ID = RankListing:GetLine(line):GetValue(1)
			GLOBAL_RANK_NAME = RankListing:GetLine(line):GetValue(2)
			GLOBAL_RANK_KILLS = RankListing:GetLine(line):GetValue(3)
			GLOBAL_RANK_MATERIALS = RankListing:GetLine(line):GetValue(4)
		
			if IsValid(RankImageL) then
				RankImageL:SetImage( RankListing:GetLine(line):GetValue(4) )
				RankImageL:SizeToContents()
			end			
			
			if IsValid(RankListingEdit) then
				RankListingEdit:SetDisabled( false )
			end
			
			if IsValid(RankListingRemove) then
				RankListingRemove:SetDisabled( false )
			end
			
			WhatRanksAreWeTouching = RankListing:GetLine(line):GetValue(1)
		end
		
		RankListingAdd = vgui.Create( "DButton", DPanelListF32 ) -- Creates a button
		RankListingAdd:SetPos( 445, 152 )
		RankListingAdd:SetText( "ADD" )
		RankListingAdd:SetSize( 28, 66 )
		RankListingAdd:SetDisabled( false )
		RankListingAdd.DoClick = function()
			if IsValid(RankListing) == true then
				RankListing:Clear()
			end
			
		if IsValid(RankListingEdit) == true then
			RankListingEdit:SetDisabled(true)
		end
		if IsValid(RankListingRemove) == true then
			RankListingRemove:SetDisabled(true)
		end
			
			CreateNewRank(ply)
			
			if IsValid(RankListingAdd) then
				RankListingAdd:SetDisabled( true )
			end
		end
		
		RankListingEdit = vgui.Create( "DButton", DPanelListF32 ) -- Creates a button
		RankListingEdit:SetPos( 445, 82 )
		RankListingEdit:SetText( "EDIT" )
		RankListingEdit:SetSize( 28, 66 )
		RankListingEdit:SetDisabled( true )
		RankListingEdit.DoClick = function()
			if IsValid(RankListing) == true then
				RankListing:Clear()
			end
			
		if IsValid(RankListingEdit) == true then
			RankListingEdit:SetDisabled(true)
		end
		if IsValid(RankListingRemove) == true then
			RankListingRemove:SetDisabled(true)
		end
			
			EditExistingRank(ply, GLOBAL_RANK_ID, GLOBAL_RANK_NAME, GLOBAL_RANK_KILLS, GLOBAL_RANK_MATERIALS)
			
			if IsValid(RankListingEdit) then
				RankListingEdit:SetDisabled( true )
			end
		end
		
		RankListingRemove = vgui.Create( "DButton", DPanelListF32 ) -- Creates a button
		RankListingRemove:SetPos( 445, 10 )
		RankListingRemove:SetText( "DEL" )
		RankListingRemove:SetSize( 28, 66 )
		RankListingRemove:SetDisabled( true )
		RankListingRemove.DoClick = function()
			if IsValid(RankListing) == true then
				RankListing:Clear()
			end
			
			net.Start( "f3_menu_apple_remove_rank" )
				net.WriteString(WhatRanksAreWeTouching)
			net.SendToServer( ply )
			
			net.Start( "f3_menu_apple_fill_ranks" )
			net.SendToServer( ply )
			
			if IsValid(RankListingRemove) then
				RankListingRemove:SetDisabled( true )
			end
			if IsValid(RankListingEdit) == true then
				RankListingEdit:SetDisabled(true)
			end
		end	
		
		
		net.Start( "f3_menu_apple_fill_ranks" )
		net.SendToServer( ply )
	end
	
	
	
function EditExistingRank(ply, id, name, kills, mats)
	MainMenuCreationRankMenu = vgui.Create( "DFrame" ) -- The menu
	MainMenuCreationRankMenu:SetSize(600, 200)
	MainMenuCreationRankMenu:SetTitle( "Rank Creation Menu" )
	MainMenuCreationRankMenu:SetDraggable( true )
	MainMenuCreationRankMenu:Center()
	MainMenuCreationRankMenu:MakePopup()
	MainMenuCreationRankMenu.OnClose = function()
		net.Start( "f3_menu_apple_fill_ranks" )
		net.SendToServer( ply )
	end
	
	RankImageL2 = vgui.Create( "DImage", MainMenuCreationRankMenu )
	RankImageL2:SetPos( 400, 55 )
	RankImageL2:SetImage( mats )
	RankImageL2:SizeToContents()
	
	local RankNameLabel = vgui.Create("DLabel", MainMenuCreationRankMenu )
	RankNameLabel:SetPos(19,45)
	RankNameLabel:SetColor( Color( 0, 0, 0, 255 ) )
	RankNameLabel:SetFont( "DebugFixed2" )
	RankNameLabel:SetText("Name:")
	RankNameLabel:SizeToContents()
	
	RankName = vgui.Create( "DTextEntry", MainMenuCreationRankMenu )
	RankName:SetSize(200, 20)
	RankName:SetPos(55, 42)
	RankName:SetText(name)
	RankName.OnChange = function(ply)
		if string.len(RankName:GetValue()) != 0 then
			RankSubmitButton:SetDisabled(false)
		else
			RankSubmitButton:SetDisabled(true)
		end
	end
	
	local RankMaterialLabel = vgui.Create("DLabel", MainMenuCreationRankMenu )
	RankMaterialLabel:SetPos(10,67)
	RankMaterialLabel:SetColor( Color( 0, 0, 0, 255 ) )
	RankMaterialLabel:SetFont( "DebugFixed2" )
	RankMaterialLabel:SetText("Material:")
	RankMaterialLabel:SizeToContents()
	
	RankMaterial = vgui.Create( "DTextEntry", MainMenuCreationRankMenu )
	RankMaterial:SetSize(200, 20)
	RankMaterial:SetPos(55, 65)
	RankMaterial:SetText(mats)
	RankMaterial.OnChange = function(ply)
		if string.len(RankMaterial:GetValue()) != 0 then
			RankSubmitButton:SetDisabled(false)
		else
			RankSubmitButton:SetDisabled(true)
		end
	end
	
	local RankKillLabel = vgui.Create("DLabel", MainMenuCreationRankMenu )
	RankKillLabel:SetPos(19,89)
	RankKillLabel:SetColor( Color( 0, 0, 0, 255 ) )
	RankKillLabel:SetFont( "DebugFixed2" )
	RankKillLabel:SetText("Kills:")
	RankKillLabel:SizeToContents()
	
	RankKill = vgui.Create( "DTextEntry", MainMenuCreationRankMenu )
	RankKill:SetSize(200, 20)
	RankKill:SetPos(55, 88)
	RankKill:SetText(kills)
	RankKill.OnChange = function(ply)
		if string.len(RankKill:GetValue()) != 0 then
			RankSubmitButton:SetDisabled(false)
		else
			RankSubmitButton:SetDisabled(true)
		end
	end
	
	RankSubmitButton = vgui.Create( "DButton", MainMenuCreationRankMenu ) -- Creates a button
	RankSubmitButton:SetPos( 92, 135 )
	RankSubmitButton:SetText( "SUBMIT" )
	RankSubmitButton:SetSize( 100, 40 )
	RankSubmitButton.DoClick = function()
	local ReplaceToNumbers = string.gsub(RankKill:GetValue(),"%D", "")
	local ReplaceToNumbers = string.gsub(ReplaceToNumbers,"%W", "")
	if string.len(ReplaceToNumbers) != 0 then
		ReplaceToNumbersONLY = ReplaceToNumbers
	else
		ReplaceToNumbersONLY = "10"
	end
		net.Start( "f3_menu_apple_edit_rank_submit" )
			net.WriteString(id)
			net.WriteString(RankName:GetValue())
			net.WriteString(RankMaterial:GetValue())
			net.WriteString(ReplaceToNumbersONLY)
		net.SendToServer( ply )
		MainMenuCreationRankMenu:Close()
	end
	
	local RankMaterialButton = vgui.Create( "DButton", MainMenuCreationRankMenu ) -- Creates a button
	RankMaterialButton:SetPos( 255, 65 )
	RankMaterialButton:SetText( "Browse" )
	RankMaterialButton:SetSize( 50, 20 )
	RankMaterialButton.DoClick = function()
		MaterialsMenu()
	end
end

	
	
	
function CreateNewRank(ply)
	MainMenuCreationRankMenu = vgui.Create( "DFrame" ) -- The menu
	MainMenuCreationRankMenu:SetSize(600, 200)
	MainMenuCreationRankMenu:SetTitle( "Rank Creation Menu" )
	MainMenuCreationRankMenu:SetDraggable( true )
	MainMenuCreationRankMenu:Center()
	MainMenuCreationRankMenu:MakePopup()
	MainMenuCreationRankMenu.OnClose = function()
		if IsValid(RankListingAdd) == true then
			RankListingAdd:SetDisabled(false)
		end
		if IsValid(RankListingEdit) == true then
			RankListingEdit:SetDisabled(false)
		end
		if IsValid(RankListingRemove) == true then
			RankListingRemove:SetDisabled(false)
		end
		
		net.Start( "f3_menu_apple_fill_ranks" )
		net.SendToServer( ply )
	end
	
	RankImageL2 = vgui.Create( "DImage", MainMenuCreationRankMenu )
	RankImageL2:SetPos( 400, 55 )
	RankImageL2:SetImage( "apple_ranks/test.png" )
	RankImageL2:SizeToContents()
	
	local RankNameLabel = vgui.Create("DLabel", MainMenuCreationRankMenu )
	RankNameLabel:SetPos(19,45)
	RankNameLabel:SetColor( Color( 0, 0, 0, 255 ) )
	RankNameLabel:SetFont( "DebugFixed2" )
	RankNameLabel:SetText("Name:")
	RankNameLabel:SizeToContents()
	
	RankName2 = vgui.Create( "DTextEntry", MainMenuCreationRankMenu )
	RankName2:SetSize(200, 20)
	RankName2:SetPos(55, 42)
	--RankName2:SetText("The Name of the Rank")
	RankName2:SetText("test")
	RankName2.OnChange = function(ply)
		if string.len(RankName2:GetValue()) != 0 then
			RankSubmitButton2:SetDisabled(false)
		else
			RankSubmitButton2:SetDisabled(true)
		end
	end
	
	local RankMaterialLabel = vgui.Create("DLabel", MainMenuCreationRankMenu )
	RankMaterialLabel:SetPos(10,67)
	RankMaterialLabel:SetColor( Color( 0, 0, 0, 255 ) )
	RankMaterialLabel:SetFont( "DebugFixed2" )
	RankMaterialLabel:SetText("Material:")
	RankMaterialLabel:SizeToContents()
	
	RankMaterial2 = vgui.Create( "DTextEntry", MainMenuCreationRankMenu )
	RankMaterial2:SetSize(200, 20)
	RankMaterial2:SetPos(55, 65)
	RankMaterial2:SetText("The Icon/Material for Rank")
	RankMaterial2.OnChange = function(ply)
		if string.len(RankMaterial2:GetValue()) != 0 then
			RankSubmitButton2:SetDisabled(false)
		else
			RankSubmitButton2:SetDisabled(true)
		end
	end
	
	local RankKillLabel = vgui.Create("DLabel", MainMenuCreationRankMenu )
	RankKillLabel:SetPos(19,89)
	RankKillLabel:SetColor( Color( 0, 0, 0, 255 ) )
	RankKillLabel:SetFont( "DebugFixed2" )
	RankKillLabel:SetText("Kills:")
	RankKillLabel:SizeToContents()
	
	RankKill2 = vgui.Create( "DTextEntry", MainMenuCreationRankMenu )
	RankKill2:SetSize(200, 20)
	RankKill2:SetPos(55, 88)
	--RankKill2:SetText("Number of Kills to proceed to Rank")
	RankKill2:SetText("1")
	RankKill2.OnChange = function(ply)
		if string.len(RankKill2:GetValue()) != 0 then
			RankSubmitButton2:SetDisabled(false)
		else
			RankSubmitButton2:SetDisabled(true)
		end
	end
	
	RankSubmitButton2 = vgui.Create( "DButton", MainMenuCreationRankMenu ) -- Creates a button
	RankSubmitButton2:SetPos( 92, 135 )
	RankSubmitButton2:SetText( "SUBMIT" )
	RankSubmitButton2:SetSize( 100, 40 )
	RankSubmitButton2.DoClick = function()
	local ReplaceToNumbers = string.gsub(RankKill2:GetValue(),"%D", "")
	local ReplaceToNumbers = string.gsub(ReplaceToNumbers,"%W", "")
	if string.len(ReplaceToNumbers) != 0 then
		ReplaceToNumbersONLY = ReplaceToNumbers
	else
		ReplaceToNumbersONLY = "10"
	end
		net.Start( "f3_menu_apple_add_rank_submit" )
			net.WriteString(RankName2:GetValue())
			net.WriteString(RankMaterial2:GetValue())
			net.WriteString(ReplaceToNumbersONLY)
		net.SendToServer( ply )
		MainMenuCreationRankMenu:Close()
	end
	
	local RankMaterialButton = vgui.Create( "DButton", MainMenuCreationRankMenu ) -- Creates a button
	RankMaterialButton:SetPos( 255, 65 )
	RankMaterialButton:SetText( "Browse" )
	RankMaterialButton:SetSize( 50, 20 )
	RankMaterialButton.DoClick = function()
		MaterialsMenu()
	end
end
	
	
	
	
function f3_menu_apple_fill_ranks(data)
	if IsValid(RankListing) == true then
	local ID = data:ReadShort()
	local Name = data:ReadString()
	local Req = data:ReadShort()
	local MaterialID = data:ReadString()
		RankListing:AddLine(ID, Name, Req, MaterialID)
	end
end
usermessage.Hook("f3_menu_apple_fill_ranks", f3_menu_apple_fill_ranks)
end




if SERVER then


net.Receive( "f3_menu_apple_edit_rank_submit", function( len, ply )
	local RankID = net.ReadString()
	local RankName = net.ReadString()
	local RankMaterial = net.ReadString()
	local RankKill = net.ReadString()
	sql.Query( "UPDATE apple_deathmatch_ranks SET RankName = "..(sql.SQLStr(RankName))..", Req = '"..RankKill.."', Material = "..(sql.SQLStr(RankMaterial)).." WHERE ID = '"..RankID.."' " )
end)


net.Receive( "f3_menu_apple_add_rank_submit", function( len, ply )
local RankName = net.ReadString()
local RankMaterial = net.ReadString()
local RankKill = net.ReadString()
local GENERICA_RANKS = sql.QueryValue( "SELECT ID FROM apple_deathmatch_ranks ORDER BY ID DESC;" )
MsgN(GENERICA_RANKS)
	if GENERICA_RANKS == nil then
	sql.Query( "INSERT INTO apple_deathmatch_ranks ( `ID`, `RankName`, `Req`, `Material`) VALUES ( '1', "..(sql.SQLStr(RankName))..", '"..RankKill.."', "..(sql.SQLStr(RankMaterial))..")" )
	else
	local NewNum = (tonumber(GENERICA_RANKS)+1)
	sql.Query( "INSERT INTO apple_deathmatch_ranks ( `ID`, `RankName`, `Req`, `Material`) VALUES ( '"..tostring(NewNum).."', "..(sql.SQLStr(RankName))..", '"..RankKill.."', "..(sql.SQLStr(RankMaterial))..")" )
	end
	FixTheOrderOfAllRanks()
end)


function FixTheOrderOfAllRanks()
	local FixOrderForRanks = sql.Query( "SELECT * FROM apple_deathmatch_ranks ORDER BY Req ASC" )
	if FixOrderForRanks == nil then return end
	for k, v in pairs(FixOrderForRanks) do
--	MsgN("~~ ~~ "..v['RankName'].." ~~ ~~")
--	MsgN(v['ID'].. " will be ".. k)
--	MsgN(v['Req'])
		sql.Query( "UPDATE apple_deathmatch_ranks SET ID = '"..k.."' WHERE Req = '"..v['Req'].."' " )
	end
end


net.Receive( "f3_menu_apple_remove_rank", function( len, ply )
	local ID = net.ReadString()
	sql.Query( "DELETE FROM apple_deathmatch_ranks WHERE ID = '"..ID.."'" )
	FixTheOrderOfAllRanks()
end)


net.Receive( "f3_menu_apple_fill_ranks", function( len, ply )
	local GetRanks = sql.Query( "SELECT * FROM apple_deathmatch_ranks ORDER BY ID ASC;" )
	if GetRanks == nil then return end
	for k, v in pairs(GetRanks) do
		umsg.Start( "f3_menu_apple_fill_ranks", ply )
			umsg.Short(v['ID'])
			umsg.String(v['RankName'])
			umsg.Short(v['Req'])
			umsg.String(v['Material'])
		umsg.End()
	end
end)


function CreateRanksDB()
	if sql.TableExists( "apple_deathmatch_ranks" ) == false then
		sql.Query( "CREATE TABLE apple_deathmatch_ranks ( ID int, RankName varchar(255), Req int, Material varchar(255))" )
		sql.Query( "INSERT INTO apple_deathmatch_ranks ( `ID`, `RankName`, `Req`, `Material`) VALUES ( '1', 'Private', '5', 'apple_ranks/1.png')" )
		sql.Query( "INSERT INTO apple_deathmatch_ranks ( `ID`, `RankName`, `Req`, `Material`) VALUES ( '2', 'Private First Class', '10', 'apple_ranks/2.png')" )
		sql.Query( "INSERT INTO apple_deathmatch_ranks ( `ID`, `RankName`, `Req`, `Material`) VALUES ( '3', 'Corporal', '20', 'apple_ranks/3.png')" )
		sql.Query( "INSERT INTO apple_deathmatch_ranks ( `ID`, `RankName`, `Req`, `Material`) VALUES ( '4', 'Sergeant', '40', 'apple_ranks/4.png')" )
		sql.Query( "INSERT INTO apple_deathmatch_ranks ( `ID`, `RankName`, `Req`, `Material`) VALUES ( '5', 'Staff Sergeant', '80', 'apple_ranks/5.png')" )
		sql.Query( "INSERT INTO apple_deathmatch_ranks ( `ID`, `RankName`, `Req`, `Material`) VALUES ( '6', 'Gunnery Sergeant', '160', 'apple_ranks/6.png')" )
		sql.Query( "INSERT INTO apple_deathmatch_ranks ( `ID`, `RankName`, `Req`, `Material`) VALUES ( '7', 'Master Sergeant', '240', 'apple_ranks/7.png')" )
		sql.Query( "INSERT INTO apple_deathmatch_ranks ( `ID`, `RankName`, `Req`, `Material`) VALUES ( '8', 'Sergeant Major', '320', 'apple_ranks/8.png')" )
		sql.Query( "INSERT INTO apple_deathmatch_ranks ( `ID`, `RankName`, `Req`, `Material`) VALUES ( '9', '2nd Lieutenant', '400', 'apple_ranks/9.png')" )
		sql.Query( "INSERT INTO apple_deathmatch_ranks ( `ID`, `RankName`, `Req`, `Material`) VALUES ( '10', '1st Lieutenant', '500', 'apple_ranks/10.png')" )
		sql.Query( "INSERT INTO apple_deathmatch_ranks ( `ID`, `RankName`, `Req`, `Material`) VALUES ( '11', 'Captain', '625', 'apple_ranks/11.png')" )
		sql.Query( "INSERT INTO apple_deathmatch_ranks ( `ID`, `RankName`, `Req`, `Material`) VALUES ( '12', 'Major', '775', 'apple_ranks/12.png')" )
		sql.Query( "INSERT INTO apple_deathmatch_ranks ( `ID`, `RankName`, `Req`, `Material`) VALUES ( '13', 'Lt. Colonel', '950', 'apple_ranks/13.png')" )
		sql.Query( "INSERT INTO apple_deathmatch_ranks ( `ID`, `RankName`, `Req`, `Material`) VALUES ( '14', 'Colonel', '1150', 'apple_ranks/14.png')" )
		sql.Query( "INSERT INTO apple_deathmatch_ranks ( `ID`, `RankName`, `Req`, `Material`) VALUES ( '15', 'Brigadier General', '1375', 'apple_ranks/15.png')" )
		sql.Query( "INSERT INTO apple_deathmatch_ranks ( `ID`, `RankName`, `Req`, `Material`) VALUES ( '16', 'Major General', '1500', 'apple_ranks/16.png')" )
		sql.Query( "INSERT INTO apple_deathmatch_ranks ( `ID`, `RankName`, `Req`, `Material`) VALUES ( '17', 'Lieutenant General', '1750', 'apple_ranks/17.png')" )
		sql.Query( "INSERT INTO apple_deathmatch_ranks ( `ID`, `RankName`, `Req`, `Material`) VALUES ( '18', 'Commander', '2000', 'apple_ranks/18.png')" )
		resource.AddSingleFile( "materials/apple_ranks/1.png" )
		resource.AddSingleFile( "materials/apple_ranks/2.png" )
		resource.AddSingleFile( "materials/apple_ranks/3.png" )
		resource.AddSingleFile( "materials/apple_ranks/4.png" )
		resource.AddSingleFile( "materials/apple_ranks/5.png" )
		resource.AddSingleFile( "materials/apple_ranks/6.png" )
		resource.AddSingleFile( "materials/apple_ranks/7.png" )
		resource.AddSingleFile( "materials/apple_ranks/8.png" )
		resource.AddSingleFile( "materials/apple_ranks/9.png" )
		resource.AddSingleFile( "materials/apple_ranks/10.png" )
		resource.AddSingleFile( "materials/apple_ranks/11.png" )
		resource.AddSingleFile( "materials/apple_ranks/12.png" )
		resource.AddSingleFile( "materials/apple_ranks/13.png" )
		resource.AddSingleFile( "materials/apple_ranks/14.png" )
		resource.AddSingleFile( "materials/apple_ranks/15.png" )
		resource.AddSingleFile( "materials/apple_ranks/16.png" )
		resource.AddSingleFile( "materials/apple_ranks/17.png" )
		resource.AddSingleFile( "materials/apple_ranks/18.png" )
		resource.AddSingleFile( "materials/apple_ranks/test.png" )
	else
		local GENERICA_RANKSM102 = sql.Query( "SELECT * FROM apple_deathmatch_ranks;" )
		if GENERICA_RANKSM102 == nil then return end
		for k, v in pairs(GENERICA_RANKSM102) do
			resource.AddSingleFile( "materials/"..v['Material'] )
		end
	end
end

CreateRanksDB()

util.AddNetworkString( "f3_menu_apple_fill_ranks" )
util.AddNetworkString( "f3_menu_apple_remove_rank" )
util.AddNetworkString( "f3_menu_apple_edit_rank_submit" )
util.AddNetworkString( "f3_menu_apple_add_rank_submit" )
end






