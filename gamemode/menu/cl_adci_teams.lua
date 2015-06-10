-- CLIENT SIDE

function CreateNewTeam_adci(ply)
	MainMenuCreationMenu = vgui.Create( "DFrame" ) -- The menu
	MainMenuCreationMenu:SetSize(600, 500)
	MainMenuCreationMenu:SetTitle( "Team Creation Menu" )
	MainMenuCreationMenu:SetDraggable( true )
	MainMenuCreationMenu:Center()
	MainMenuCreationMenu:MakePopup()
	MainMenuCreationMenu.OnClose = function()
		if IsValid(TeamAddButton) == true then
			TeamAddButton:SetDisabled(false)
		end
		if IsValid(TeamDeleteButton) == true then
			TeamDeleteButton:SetDisabled(false)
		end
		if IsValid(TeamEditButton) == true then
			TeamEditButton:SetDisabled(false)
		end
		if IsValid(TeamInfoButton) == true then
			TeamInfoButton:SetDisabled(false)
		end
		RunConsoleCommand("stopsound")
	end
	
	TeamColorW = vgui.Create( "DColorMixer", MainMenuCreationMenu )
	TeamColorW:SetSize(255, 150)
	--TeamColor:Dock( FILL )
	TeamColorW:SetPos(335, 35)
	TeamColorW:SetPalette( false ) 		--Show/hide the palette			DEF:true
	TeamColorW:SetAlphaBar( true ) 		--Show/hide the alpha bar		DEF:true
	TeamColorW:SetWangs( true )			--Show/hide the R G B A indicators 	DEF:true
	TeamColorW:SetColor( Color( 0, 0, 0 ) )
	
	local TeamNameLabel = vgui.Create("DLabel", MainMenuCreationMenu )
	TeamNameLabel:SetPos(10,37)
	TeamNameLabel:SetColor( Color( 0, 0, 0, 255 ) )
	TeamNameLabel:SetFont( "DebugFixed2" )
	TeamNameLabel:SetText("Name:")
	TeamNameLabel:SizeToContents()
	
	local TeamWinSoundEdPlay = vgui.Create( "DImageButton", MainMenuCreationMenu )
	TeamWinSoundEdPlay:SetPos( 309, 66 )
	TeamWinSoundEdPlay:SetSize( 20, 20 )
	TeamWinSoundEdPlay:SetImage( "icon16/control_play.png" )
	TeamWinSoundEdPlay:SetDisabled(false)
	TeamWinSoundEdPlay.DoClick = function()
		RunConsoleCommand("stopsound")
		timer.Simple(0.1, function() surface.PlaySound( TeamWinSound:GetValue() ) end)
	end
	
	TeamNameE = vgui.Create( "DTextEntry", MainMenuCreationMenu )
	TeamNameE:SetSize(200, 20)
	TeamNameE:SetPos(50, 35)
	TeamNameE:SetText("Name of Team")
	TeamNameE.OnChange = function(ply)
		if string.len(TeamNameE:GetValue()) != 0 then
			TeamAddButtonSub:SetDisabled(false)
		else
			TeamAddButtonSub:SetDisabled(true)
		end
	end
	
	local TeamWinSoundLabel = vgui.Create("DLabel", MainMenuCreationMenu )
	TeamWinSoundLabel:SetPos(10,67)
	TeamWinSoundLabel:SetColor( Color( 0, 0, 0, 255 ) )
	TeamWinSoundLabel:SetFont( "DebugFixed2" )
	TeamWinSoundLabel:SetText("Sound:")
	TeamWinSoundLabel:SizeToContents()
	
	TeamWinSound = vgui.Create( "DTextEntry", MainMenuCreationMenu )
	TeamWinSound:SetSize(200, 20)
	TeamWinSound:SetPos(50, 65)
	TeamWinSound:SetText("Winning Sound for Team")
	TeamWinSound.OnChange = function(ply)
		if string.len(TeamWinSound:GetValue()) != 0 then
			TeamAddButtonSub:SetDisabled(false)
		else
			TeamAddButtonSub:SetDisabled(true)
		end
	end
	
	local TeamWinSoundButton = vgui.Create( "DButton", MainMenuCreationMenu ) -- Creates a button
	TeamWinSoundButton:SetPos( 255, 65 )
	TeamWinSoundButton:SetText( "Browse" )
	TeamWinSoundButton:SetSize( 50, 20 )
	TeamWinSoundButton.DoClick = function()
		SoundMenu()
	end
	
	
	local Scroll = vgui.Create( "DScrollPanel", MainMenuCreationMenu ) //Create the Scroll panel
	Scroll:SetSize( 355, 270 )
	Scroll:SetPos( 12, 225 )
	
	local List	= vgui.Create( "DIconLayout", Scroll )
	List:SetSize( 340, 200 )
	List:SetPos( 0, 0 )
	List:SetSpaceY( 5 )
	List:SetSpaceX( 5 )
	
	local GetAListForNewTeamModels = {}
	for k, v in pairs(player_manager.AllValidModels()) do
		local ListItem = List:Add( "DPanel" )
		ListItem:SetSize( 64, 64 )
		
		local SpawnI = vgui.Create( "SpawnIcon" , ListItem ) -- SpawnIcon
		SpawnI:SetPos( 0, 0 )
		SpawnI:SetModel( v )
		SpawnI.DoClick = function( SpawnI )
			GetAListForNewTeamModels[k]=v
			TeamAddList:Clear()
			for l, p in pairs(GetAListForNewTeamModels) do
				TeamAddList:AddLine( l, p )
			end
		end
	end
	
	TeamAddList = vgui.Create("DListView",MainMenuCreationMenu)
	TeamAddList:SetPos(375, 225)
	TeamAddList:SetSize(215, 270)
	TeamAddList:SetMultiSelect(true)
	TeamAddList:AddColumn("Name")
	TeamAddList:AddColumn("Model")
	
	TeamAddButtonSub = vgui.Create( "DImageButton", MainMenuCreationMenu )
	TeamAddButtonSub:SetPos( 480, 190 )
	TeamAddButtonSub:SetSize( 64, 32 )
	TeamAddButtonSub:SetImage( "icon16/bullet_go.png" )
	TeamAddButtonSub.DoClick = function()
		if TeamWinSound:GetValue() == "Winning Sound for Team" then
			Derma_Message("You need to choose a winning sound, or type the word NULL in the entry for no sound.", "Sound Error", "OK" )
		return end
		net.Start( "adci_add_new_team" )
			net.WriteTable(GetAListForNewTeamModels)
			net.WriteString(TeamNameE:GetValue())
			net.WriteString(TeamWinSound:GetValue())
			net.WriteTable(TeamColorW:GetColor())
		net.SendToServer( ply )
		
		if IsValid(TeamGenListing) == true then
			TeamGenListing:Clear()
		end
		
		RunConsoleCommand("stopsound")
		
		net.Start( "f2_menu_apple_fill_gen" )
		net.SendToServer( ply )
		net.Start( "f2_menu_apple_fill_gen_players" )
		net.SendToServer( ply )
	end
	TeamAddButtonSub:SetDisabled(true)
end



function EditTeam_adci(ply,WhatTeam)
GetAListForNewTeamModelsEdit = {}
GetNewNumbersForTotal = 0

	MainMenuCreationMenuEd = vgui.Create( "DFrame" ) -- The menu
	MainMenuCreationMenuEd:SetSize(600, 500)
	MainMenuCreationMenuEd:SetTitle( "Team Creation Menu" )
	MainMenuCreationMenuEd:SetDraggable( true )
	MainMenuCreationMenuEd:Center()
	MainMenuCreationMenuEd:MakePopup()
	MainMenuCreationMenuEd.OnClose = function()
		if IsValid(TeamAddButton) == true then
			TeamAddButton:SetDisabled(false)
		end
		if IsValid(TeamDeleteButton) == true then
			TeamDeleteButton:SetDisabled(false)
		end
		if IsValid(TeamEditButton) == true then
			TeamEditButton:SetDisabled(false)
		end
		if IsValid(TeamInfoButton) == true then
			TeamInfoButton:SetDisabled(false)
		end
		RunConsoleCommand("stopsound")
	end
	
	TeamColorWEd = vgui.Create( "DColorMixer", MainMenuCreationMenuEd )
	TeamColorWEd:SetSize(255, 150)
	--TeamColorWEd:Dock( FILL )
	TeamColorWEd:SetPos(335, 35)
	TeamColorWEd:SetPalette( false ) 		--Show/hide the palette			DEF:true
	TeamColorWEd:SetAlphaBar( true ) 		--Show/hide the alpha bar		DEF:true
	TeamColorWEd:SetWangs( true )			--Show/hide the R G B A indicators 	DEF:true
	TeamColorWEd:SetColor( Color( 0, 0, 0 ) )
	
	local TeamNameLabel = vgui.Create("DLabel", MainMenuCreationMenuEd )
	TeamNameLabel:SetPos(10,37)
	TeamNameLabel:SetColor( Color( 0, 0, 0, 255 ) )
	TeamNameLabel:SetFont( "DebugFixed2" )
	TeamNameLabel:SetText("Name:")
	TeamNameLabel:SizeToContents()
	
	local TeamWinSoundLabel = vgui.Create("DLabel", MainMenuCreationMenuEd )
	TeamWinSoundLabel:SetPos(10,67)
	TeamWinSoundLabel:SetColor( Color( 0, 0, 0, 255 ) )
	TeamWinSoundLabel:SetFont( "DebugFixed2" )
	TeamWinSoundLabel:SetText("Sound:")
	TeamWinSoundLabel:SizeToContents()
	
	local TeamWinSoundEdPlay = vgui.Create( "DImageButton", MainMenuCreationMenuEd )
	TeamWinSoundEdPlay:SetPos( 309, 66 )
	TeamWinSoundEdPlay:SetSize( 20, 20 )
	TeamWinSoundEdPlay:SetImage( "icon16/control_play.png" )
	TeamWinSoundEdPlay:SetDisabled(false)
	TeamWinSoundEdPlay.DoClick = function()
		RunConsoleCommand("stopsound")
		timer.Simple(0.1, function() surface.PlaySound( TeamWinSoundEd:GetValue() ) end)
	end
	
	TeamWinSoundEd = vgui.Create( "DTextEntry", MainMenuCreationMenuEd )
	TeamWinSoundEd:SetSize(200, 20)
	TeamWinSoundEd:SetPos(50, 65)
	TeamWinSoundEd:SetText("Winning Sound for Team")
	TeamWinSoundEd.OnChange = function(ply)
		if string.len(TeamWinSoundEd:GetValue()) != 0 then
			TeamEditButtonSub:SetDisabled(false)
		else
			TeamEditButtonSub:SetDisabled(true)
		end
	end
	
	local TeamWinSoundButton = vgui.Create( "DButton", MainMenuCreationMenuEd ) -- Creates a button
	TeamWinSoundButton:SetPos( 255, 65 )
	TeamWinSoundButton:SetText( "Browse" )
	TeamWinSoundButton:SetSize( 50, 20 )
	TeamWinSoundButton.DoClick = function()
		SoundMenu()
	end
	
	TeamNameEEd = vgui.Create( "DTextEntry", MainMenuCreationMenuEd )
	TeamNameEEd:SetSize(200, 20)
	TeamNameEEd:SetPos(50, 35)
	TeamNameEEd:SetText("Name of Team")
	TeamNameEEd.OnChange = function(ply)
		if string.len(TeamNameEEd:GetValue()) != 0 then
			TeamEditButtonSub:SetDisabled(false)
		else
			TeamEditButtonSub:SetDisabled(true)
		end
	end
	
	local Scroll = vgui.Create( "DScrollPanel", MainMenuCreationMenuEd ) //Create the Scroll panel
	Scroll:SetSize( 355, 270 )
	Scroll:SetPos( 12, 225 )
	
	local List	= vgui.Create( "DIconLayout", Scroll )
	List:SetSize( 340, 200 )
	List:SetPos( 0, 0 )
	List:SetSpaceY( 5 )
	List:SetSpaceX( 5 )
	
	for k, v in pairs(player_manager.AllValidModels()) do
		local ListItem = List:Add( "DPanel" )
		ListItem:SetSize( 64, 64 )
		
		local SpawnI = vgui.Create( "SpawnIcon" , ListItem ) -- SpawnIcon
		SpawnI:SetPos( 0, 0 )
		SpawnI:SetModel( v )
		SpawnI.DoClick = function( SpawnI )
			if (GetAListForNewTeamModelsEdit[k]) == nil then
			GetNewNumbersForTotal = GetNewNumbersForTotal + 1
			GetAListForNewTeamModelsEdit[k]=v
				TeamAddListEd:AddLine( GetNewNumbersForTotal, k, v )
			end
		end
	end
	
	TeamAddListEd = vgui.Create("DListView",MainMenuCreationMenuEd)
	TeamAddListEd:SetPos(375, 225)
	TeamAddListEd:SetSize(215, 246)
	TeamAddListEd:SetMultiSelect(true)
	TeamAddListEd:AddColumn("ID"):SetMaxWidth(25)
	TeamAddListEd:AddColumn("Name")
	TeamAddListEd:AddColumn("Model")
	
	TeamEditButtonRemoveModSub = vgui.Create( "DImageButton", MainMenuCreationMenuEd )
	TeamEditButtonRemoveModSub:SetPos( 470, 474 )
	TeamEditButtonRemoveModSub:SetSize( 20, 20 )
	TeamEditButtonRemoveModSub:SetImage( "icon16/delete.png" )
	TeamEditButtonRemoveModSub:SetDisabled(true)
	TeamEditButtonRemoveModSub.DoClick = function()
		TeamEditButtonRemoveModSub:SetDisabled(true)
			GetAListForNewTeamModelsEdit[WhatModelAmIRemoving]="nil"
			TeamAddListEd:Clear()
			GetNewNumbersForTotal = 0
			for k, v in pairs(GetAListForNewTeamModelsEdit) do
				if v != "nil" then
					GetNewNumbersForTotal = GetNewNumbersForTotal + 1
					TeamAddListEd:AddLine( GetNewNumbersForTotal, k, v )
				end
			end
		WhatModelAmIRemoving = nil
	end
	
	TeamAddListEd.OnRowSelected = function( panel, line )
		TeamEditButtonRemoveModSub:SetDisabled(false)
		WhatModelAmIRemoving = TeamAddListEd:GetLine(line):GetValue(2)
	end
	
	TeamEditButtonSub = vgui.Create( "DImageButton", MainMenuCreationMenuEd )
	TeamEditButtonSub:SetPos( 480, 190 )
	TeamEditButtonSub:SetSize( 64, 32 )
	TeamEditButtonSub:SetImage( "icon16/bullet_go.png" )
	TeamEditButtonSub.DoClick = function()
		if TeamWinSoundEd:GetValue() == "Winning Sound for Team" then
			Derma_Message("You need to choose a winning sound, or type the word NULL in the entry for no sound.", "Sound Error", "OK" )
		return end
		net.Start( "adci_edit_team" )
			net.WriteString(WhatTeam)
			net.WriteTable(GetAListForNewTeamModelsEdit)
			net.WriteString(TeamNameEEd:GetValue())
			net.WriteString(TeamWinSoundEd:GetValue())
			net.WriteTable(TeamColorWEd:GetColor())
		net.SendToServer( ply )
		
		if IsValid(TeamGenListing) == true then
			TeamGenListing:Clear()
		end
		
		RunConsoleCommand("stopsound")
		
		net.Start( "f2_menu_apple_fill_gen" )
		net.SendToServer( ply )
		net.Start( "f2_menu_apple_fill_gen_players" )
		net.SendToServer( ply )
	end
	TeamEditButtonSub:SetDisabled(false)
	
	net.Start( "FillEditTeamInformation" )
		net.WriteString(WhatTeam)
	net.SendToServer( ply )
end

function FillEditTeamInforModels(data)
	if IsValid(TeamAddListEd) == true then
	GetNewNumbersForTotal = nil
	local ID = data:ReadShort()
	local Name = data:ReadString()
	local Dir = data:ReadString()
		GetNewNumbersForTotal = ID
		GetAListForNewTeamModelsEdit[Name]=Dir
		TeamAddListEd:AddLine( ID, Name, Dir )
	end
end
usermessage.Hook("FillEditTeamInforModels", FillEditTeamInforModels)



function FillEditTeamInformation(data)
	local TeamName = data:ReadString()
	local Red = data:ReadString()
	local Green = data:ReadString()
	local Blue = data:ReadString()
	local Alpha = data:ReadString()
	local WinSound = data:ReadString()
	if IsValid(TeamWinSoundEd) == true then
		TeamWinSoundEd:SetText(WinSound)
	end
	if IsValid(TeamNameEEd) == true then
	local TeamName = string.gsub(TeamName, "_", " ")
		TeamNameEEd:SetText(TeamName)
	end
	if IsValid(TeamColorWEd) == true then
		TeamColorWEd:SetColor( Color( tonumber(Red),tonumber(Green),tonumber(Blue),tonumber(Alpha)) )
	end
end
usermessage.Hook("FillEditTeamInformation", FillEditTeamInformation)



function InfoTeam_adci(ply,whatteamid)
	MainMenuCreationMenuI = vgui.Create( "DFrame" )
	MainMenuCreationMenuI:SetSize(250, 250)
	MainMenuCreationMenuI:SetTitle( "Team Creation Menu" )
	MainMenuCreationMenuI:SetDraggable( true )
	MainMenuCreationMenuI:ShowCloseButton( true )
	MainMenuCreationMenuI:Center()
	MainMenuCreationMenuI:MakePopup()
	MainMenuCreationMenuI.OnClose = function()
		if IsValid(TeamDeleteButton) == true then
			TeamDeleteButton:SetDisabled(false)
		end
		if IsValid(TeamEditButton) == true then
			TeamEditButton:SetDisabled(false)
		end
		if IsValid(TeamInfoButton) == true then
			TeamInfoButton:SetDisabled(false)
		end
	end
	
	local TeamNameLabel = vgui.Create("DLabel", MainMenuCreationMenuI )
	TeamNameLabel:SetPos(10,37)
	TeamNameLabel:SetColor( Color( 0, 0, 0, 255 ) )
	TeamNameLabel:SetFont( "DebugFixed2" )
	TeamNameLabel:SetText("Name: ")
	TeamNameLabel:SizeToContents()
	
	TeamNameLabelColour = vgui.Create("DLabel", MainMenuCreationMenuI )
	TeamNameLabelColour:SetPos(46,37)
	TeamNameLabelColour:SetColor( Color( 0, 0, 0, 255 ) )
	TeamNameLabelColour:SetFont( "DebugFixed2" )
	TeamNameLabelColour:SetText(team.GetName(whatteamid))
	TeamNameLabelColour:SizeToContents()
	
	TeamCreatedLabel = vgui.Create("DLabel", MainMenuCreationMenuI )
	TeamCreatedLabel:SetPos(10,50)
	TeamCreatedLabel:SetColor( Color( 0, 0, 0, 255 ) )
	TeamCreatedLabel:SetFont( "DebugFixed2" )
	TeamCreatedLabel:SetText("Creator: ")
	
	TeamCreatedLabelID = vgui.Create("DLabel", MainMenuCreationMenuI )
	TeamCreatedLabelID:SetPos(10,63)
	TeamCreatedLabelID:SetColor( Color( 0, 0, 0, 255 ) )
	TeamCreatedLabelID:SetFont( "DebugFixed2" )
	TeamCreatedLabelID:SetText("Creator ID: ")
	
	HowManyWeaponsAreThere = vgui.Create("DLabel", MainMenuCreationMenuI )
	HowManyWeaponsAreThere:SetPos(10,76)
	HowManyWeaponsAreThere:SetColor( Color( 0, 0, 0, 255 ) )
	HowManyWeaponsAreThere:SetFont( "DebugFixed2" )
	HowManyWeaponsAreThere:SetText("Total Amount of Weapons: ")
	
	HowManySpawnsAreThere = vgui.Create("DLabel", MainMenuCreationMenuI )
	HowManySpawnsAreThere:SetPos(10,89)
	HowManySpawnsAreThere:SetColor( Color( 0, 0, 0, 255 ) )
	HowManySpawnsAreThere:SetFont( "DebugFixed2" )
	HowManySpawnsAreThere:SetText("Total Amount of Spawns: ")
	
	CreatedAtTheTimeOf = vgui.Create("DLabel", MainMenuCreationMenuI )
	CreatedAtTheTimeOf:SetPos(10,102)
	CreatedAtTheTimeOf:SetColor( Color( 0, 0, 0, 255 ) )
	CreatedAtTheTimeOf:SetFont( "DebugFixed2" )
	CreatedAtTheTimeOf:SetText("Created At: ")
	
	
	net.Start( "GetWhoCreatedDetails" )
		net.WriteString(whatteamid)
	net.SendToServer( ply )
end

function GetWhoCreatedDetails(data)
	local Red = data:ReadString()
	local Green = data:ReadString()
	local Blue = data:ReadString()
	local Alpha = data:ReadString()
	local Creator = data:ReadString()
	local CreatorID = data:ReadString()
	local CreatorTime = data:ReadString()
	local HowManyW = data:ReadString()
	local HowManyS = data:ReadString()
	if IsValid(TeamNameLabelColour) == true then
		TeamNameLabelColour:SetColor( Color( tonumber(Red),tonumber(Green),tonumber(Blue),tonumber(Alpha) ) )
	end
	if IsValid(TeamCreatedLabel) == true then
		TeamCreatedLabel:SetText("Creator: "..Creator)
		TeamCreatedLabel:SizeToContents()
	end
	if IsValid(TeamCreatedLabelID) == true then
		TeamCreatedLabelID:SetText("Creator ID: "..CreatorID)
		TeamCreatedLabelID:SizeToContents()
	end
	if IsValid(HowManyWeaponsAreThere) == true then
		HowManyWeaponsAreThere:SetText("Total Amount of Weapons: "..HowManyW)
		HowManyWeaponsAreThere:SizeToContents()
	end
	if IsValid(HowManySpawnsAreThere) == true then
		HowManySpawnsAreThere:SetText("Total Amount of Spawns: "..HowManyS)
		HowManySpawnsAreThere:SizeToContents()
	end
	if IsValid(CreatedAtTheTimeOf) == true then
		CreatedAtTheTimeOf:SetText("Created At: "..CreatorTime)
		CreatedAtTheTimeOf:SizeToContents()
	end
end
usermessage.Hook("GetWhoCreatedDetails", GetWhoCreatedDetails)

function DeleteTeam_adci(ply,whatteam,whatteamid)
	MainMenuCreationMenuD = vgui.Create( "DFrame" )
	MainMenuCreationMenuD:SetSize(150, 125)
	MainMenuCreationMenuD:SetTitle( "Delete Team: "..whatteam.."?" )
	MainMenuCreationMenuD:SetDraggable( true )
	MainMenuCreationMenuD:ShowCloseButton( false )
	MainMenuCreationMenuD:Center()
	MainMenuCreationMenuD:MakePopup()
	
	local AreYouSure = vgui.Create("DLabel", MainMenuCreationMenuD )
	AreYouSure:SetPos(10,27)
	AreYouSure:SetColor( Color( 0, 0, 0, 255 ) )
	AreYouSure:SetFont( "Default" )
	AreYouSure:SetText("Would you like also like to")
	AreYouSure:SizeToContents()
	
	local AreYouSure2 = vgui.Create("DLabel", MainMenuCreationMenuD )
	AreYouSure2:SetPos(10,40)
	AreYouSure2:SetColor( Color( 0, 0, 0, 255 ) )
	AreYouSure2:SetFont( "Default" )
	AreYouSure2:SetText("hard delete the files?")
	AreYouSure2:SizeToContents()
	
	HardDelete = vgui.Create( "DCheckBox", MainMenuCreationMenuD )
	HardDelete:SetPos( 125, 40 )
	HardDelete:SetValue( 1 )
	
	local HardDeleteQ = vgui.Create( "DImageButton", MainMenuCreationMenuD )
	HardDeleteQ:SetPos( 63, 52 )
	HardDeleteQ:SetSize( 16, 16 )
	HardDeleteQ:SetImage( "icon16/information.png" )
	HardDeleteQ:SetTooltip("Check marking this will make all data; Spawns, Weapons, Models be gone forever. Leaving this unchecked just deletes the team, but keeps the other data just incase you wish to make the teams again.")
	HardDeleteQ.DoClick = function()
		Derma_Message("Check marking this will make all data; Spawns, Weapons, Models be gone forever. Leaving this unchecked just deletes the team, but keeps the other data just incase you wish to make the teams again.", "Information", "OK")
	end
	
	local TeamDeleteButtonSub = vgui.Create( "DImageButton", MainMenuCreationMenuD )
	TeamDeleteButtonSub:SetPos( 25, 80 )
	TeamDeleteButtonSub:SetSize( 32, 32 )
	TeamDeleteButtonSub:SetImage( "icon16/tick.png" )
	TeamDeleteButtonSub.DoClick = function()
		MainMenuCreationMenuD:Close()
		if IsValid(EditTeamListing) == true then
			EditTeamListing:Clear()
		end
		if IsValid(TeamGenListing) == true then
			TeamGenListing:Clear()
		end
		if IsValid(TeamGenListingP) == true then
			TeamGenListingP:Clear()
		end
		
		if HardDelete:GetChecked() == true then
			TheHardDeleteQ = 1
		elseif HardDelete:GetChecked() == false then
			TheHardDeleteQ = 0
		end
		
		net.Start( "adci_delete_team" )
			net.WriteString(whatteamid)
			net.WriteString(TheHardDeleteQ)
		net.SendToServer( ply )
		
		net.Start( "f2_menu_apple_fill_gen" )
		net.SendToServer( ply )
		net.Start( "f2_menu_apple_fill_gen_players" )
		net.SendToServer( ply )
		
		if IsValid(TeamAddButton) == true then
			TeamAddButton:SetDisabled(false)
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
		if IsValid(EditTeamSpawnListing) == true then
			EditTeamSpawnListing:Clear()
		end
		if IsValid(EditTeamWeaponListing) == true then
			EditTeamWeaponListing:Clear()
		end
		if IsValid(EditTeamWeaponListingPot) == true then
			EditTeamWeaponListingPot:Clear()
		end
	end
	
	local TeamDeleteButtonSubC = vgui.Create( "DImageButton", MainMenuCreationMenuD )
	TeamDeleteButtonSubC:SetPos( 95, 80 )
	TeamDeleteButtonSubC:SetSize( 32, 32 )
	TeamDeleteButtonSubC:SetImage( "icon16/cancel.png" )
	TeamDeleteButtonSubC.DoClick = function()
		MainMenuCreationMenuD:Close()
		if IsValid(TeamAddButton) == true then
			TeamAddButton:SetDisabled(false)
		end
		if IsValid(TeamDeleteButton) == true then
			TeamDeleteButton:SetDisabled(false)
		end
		if IsValid(TeamEditButton) == true then
			TeamEditButton:SetDisabled(false)
		end
		if IsValid(TeamInfoButton) == true then
			TeamInfoButton:SetDisabled(false)
		end
	end
	
	local Yes = vgui.Create("DLabel", MainMenuCreationMenuD )
	Yes:SetPos(28,109)
	Yes:SetColor( Color( 0, 0, 0, 255 ) )
	Yes:SetFont( "Default" )
	Yes:SetText("Yes")
	Yes:SizeToContents()
	
	local No = vgui.Create("DLabel", MainMenuCreationMenuD )
	No:SetPos(104,110)
	No:SetColor( Color( 0, 0, 0, 255 ) )
	No:SetFont( "Default" )
	No:SetText("No")
	No:SizeToContents()
end


function creating_teams_not_error()
	if IsValid(TeamAddButton) == true then
		TeamAddButton:SetDisabled(false)
	end
	if IsValid(TeamDeleteButton) == true then
		TeamDeleteButton:SetDisabled(false)
	end
	if IsValid(TeamEditButton) == true then
		TeamEditButton:SetDisabled(false)
	end
	if IsValid(TeamInfoButton) == true then
		TeamInfoButton:SetDisabled(false)
	end

	if IsValid(MainMenuCreationMenu) == true then
		MainMenuCreationMenu:Close()
	end
	
	if IsValid(MainMenuCreationMenuEd) == true then
		MainMenuCreationMenuEd:Close()
	end
	
	if IsValid(EditTeamListing) == true then
		EditTeamListing:Clear()
	end
	net.Start( "f2_menu_apple_fill_edit" )
	net.SendToServer( ply )
end
usermessage.Hook("creating_teams_not_error", creating_teams_not_error)

function creating_teams_error()
	Derma_Message("A team with the same name already exists!", "ERROR", "OK")
end
usermessage.Hook("creating_teams_error", creating_teams_error)

