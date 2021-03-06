-- The F1 Menu

if CLIENT then
	local function f1_menu_apple(data)
	local PlayerKills = data:ReadShort()
	local PlayerDeaths = data:ReadShort()
	local PlayerScore = data:ReadShort()
	local PlayerRatio = data:ReadString()
		if (PlayerRatio == "inf") then
			if(PlayerKills == 0) then
				PlayerRatio = (PlayerDeaths*-1)
			else
				PlayerRatio = PlayerKills
			end
		end
	local FavGunNiceName = data:ReadString()
	local FavGunName = data:ReadString()
	local FavGunKills = data:ReadShort()
	local PlayerJoined = data:ReadShort()
	local PlayerDisconnected = data:ReadShort()
	for k,v in pairs(weapons.GetList()) do
		if FavGunName == v.ClassName then
			FavGunNamePicture = v.WorldModel
		end
	end
	
	
		-- Main Menu
		local MainMenu = vgui.Create( "DFrame" )
		--DermaPanel:SetPos(ScrW() / 4, ScrH() / 4)
		MainMenu:SetSize(750, 500)
		MainMenu:SetTitle( "Player Information Menu" )
		MainMenu:SetDraggable( false )
		MainMenu:Center()
		MainMenu:MakePopup()
		
		
		-- Greeting notification on top
		local Greetings = vgui.Create( "DLabel", MainMenu )
		Greetings:SetPos( 20, 40 )
		Greetings:SetFont("TargetID2")
		Greetings:SetColor(Color(255,255,255,255))
		Greetings:SetText( "Hello "..LocalPlayer():Nick()..", welcome to "..GetHostName().."!" )
		Greetings:SizeToContents()
		
		
		-- Somehow this shows friendlyness, so I'll be giving the player the ability to look at their avatar in menu!!1
		local AvatarBG = vgui.Create( "DPanel", MainMenu )
		AvatarBG:SetPos( 658, 38 )
		AvatarBG:SetSize( 68, 68 )
		local Avatar = vgui.Create( "AvatarImage", MainMenu )
		Avatar:SetSize( 64, 64 )
		Avatar:SetPos( 660, 40 )
		Avatar:SetPlayer( LocalPlayer(), 64 )
		
		-- What team are you on, if you are even on a team?
		local CurTeamYPos = 55
		local CurTeam = vgui.Create( "DLabel", MainMenu )
		CurTeam:SetPos( 20, CurTeamYPos )
		CurTeam:SetFont("TargetID2")
		CurTeam:SetColor(Color(255,255,255,255))
		if LocalPlayer():GetMoveType() == 0 || LocalPlayer():GetMoveType() == 10 then
			CurTeam:SetText( "You're currently in spectator mode, please wait!" )
		elseif LocalPlayer():GetMoveType() == 2 then
			CurTeam:SetText( "You're on team: " )
			local CurTeamColor = vgui.Create( "DLabel", MainMenu )
			CurTeamColor:SetPos( 130, CurTeamYPos )
			CurTeamColor:SetFont("TargetID2")
			CurTeamColor:SetColor( team.GetColor(LocalPlayer():Team()) )
			local TeamName = team.GetName(LocalPlayer():Team())
			local TeamName = string.gsub(TeamName, "_", " ")
			CurTeamColor:SetText( TeamName.. " ("..LocalPlayer():Team()..")" )
			CurTeamColor:SizeToContents()
		end
		CurTeam:SizeToContents()
		
		
		-- Total Kills of Player
		local PlayerInfos = 95
		local PlayerKillsInfo = vgui.Create( "DLabel", MainMenu )
		PlayerKillsInfo:SetPos( 20, PlayerInfos )
		--CurTeamKills:SetFont("BudgetLabel")
		PlayerKillsInfo:SetFont("TargetID2")
		PlayerKillsInfo:SetText( "Your Kills: "..PlayerKills )
		PlayerKillsInfo:SetColor(Color(255,255,255,255))
		PlayerKillsInfo:SizeToContents()
		 
		local WhatClassesLabel = vgui.Create("DLabel", MainMenu )
		WhatClassesLabel:SetPos(640,335)
		WhatClassesLabel:SetColor( Color( 0, 0, 0, 255 ) )
		WhatClassesLabel:SetFont( "DebugFixed2" )
		WhatClassesLabel:SetText("Current Class")
		WhatClassesLabel:SizeToContents()
		 
		List_Classes_f1 = vgui.Create( "DComboBox", MainMenu)
		List_Classes_f1:SetPos(630,350)
		List_Classes_f1:SetSize( 110, 20 )
		List_Classes_f1.OnSelect = function( panel, index, value )
			if IsValid(ClassesWeaponListing2) == true then
				ClassesWeaponListing2:Clear()
			end
			
			net.Start( "f1_menu_apple_class_list22" )
				net.WriteString(value)
			net.SendToServer( LocalPlayer() )
			
			
			net.Start( "f1_menu_apple_edit_class_submit_go" )
				net.WriteString(value)
			net.SendToServer( LocalPlayer() )

		end
		
		net.Start( "f1_menu_apple_class_list" )
		net.SendToServer( LocalPlayer() )

		ClassesWeaponListing2 = vgui.Create("DListView",MainMenu) -- Shows a list of all available teams
		ClassesWeaponListing2:SetPos(630, 375)
		ClassesWeaponListing2:SetSize(110, 115)
		ClassesWeaponListing2:SetMultiSelect(false)
		ClassesWeaponListing2:AddColumn("Name")
		
	
		-- Total Deaths of Player
		local PlayerDeathsInfo = vgui.Create( "DLabel", MainMenu )
		PlayerDeathsInfo:SetPos( 20, PlayerInfos + 14 )
		--PlayerDeathsInfo:SetFont("BudgetLabel")
		PlayerDeathsInfo:SetFont("TargetID2")
		PlayerDeathsInfo:SetText( "Your Deaths: "..PlayerDeaths )
		PlayerDeathsInfo:SetColor(Color(255,255,255,255))
		PlayerDeathsInfo:SizeToContents()
		
		
		-- Total Ratio of Player
		local PlayerRatioInfo = vgui.Create( "DLabel", MainMenu )
		PlayerRatioInfo:SetPos( 20, PlayerInfos + 28 )
		--PlayerRatioInfo:SetFont("BudgetLabel")
		PlayerRatioInfo:SetFont("TargetID2")
		PlayerRatioInfo:SetText( "Your Ratio: " )
		PlayerRatioInfo:SetColor(Color(255,255,255,255))
		PlayerRatioInfo:SizeToContents()
		if PlayerRatio < 0.99 then
			-- Total Ratio of Player Colour
			local PlayerRatioInfoColour = vgui.Create( "DLabel", MainMenu )
			PlayerRatioInfoColour:SetPos( 99, PlayerInfos + 28 )
			PlayerRatioInfoColour:SetFont("TargetID2")
			PlayerRatioInfoColour:SetText( PlayerRatio )
			PlayerRatioInfoColour:SetColor(Color(255,0,0,255))
			PlayerRatioInfoColour:SizeToContents()
		else
			-- Total Ratio of Player Colour
			local PlayerRatioInfoColour = vgui.Create( "DLabel", MainMenu )
			PlayerRatioInfoColour:SetPos( 99, PlayerInfos + 28 )
			PlayerRatioInfoColour:SetFont("TargetID2")
			PlayerRatioInfoColour:SetText( PlayerRatio )
			PlayerRatioInfoColour:SetColor(Color(0,255,0,255))
			PlayerRatioInfoColour:SizeToContents()
		end
		
		
		-- Total Score of Player
		local PlayerScoreInfo = vgui.Create( "DLabel", MainMenu )
		PlayerScoreInfo:SetPos( 20, PlayerInfos + 42 )
		--PlayerScoreInfo:SetFont("BudgetLabel")
		PlayerScoreInfo:SetFont("TargetID2")
		PlayerScoreInfo:SetText( "Your Score: " )
		PlayerScoreInfo:SetColor(Color(255,255,255,255))
		PlayerScoreInfo:SizeToContents()
		if PlayerScore < 0 then
			-- Total Score of Player Colour
			local PlayerScoreInfoColour = vgui.Create( "DLabel", MainMenu )
			PlayerScoreInfoColour:SetPos( 103, PlayerInfos + 42 )
			PlayerScoreInfoColour:SetFont("TargetID2")
			PlayerScoreInfoColour:SetText( PlayerScore )
			PlayerScoreInfoColour:SetColor(Color(255,0,0,255))
			PlayerScoreInfoColour:SizeToContents()
		else
			-- Total Score of Player Colour
			local PlayerScoreInfoColour = vgui.Create( "DLabel", MainMenu )
			PlayerScoreInfoColour:SetPos( 103, PlayerInfos + 42 )
			PlayerScoreInfoColour:SetFont("TargetID2")
			PlayerScoreInfoColour:SetText( PlayerScore )
			PlayerScoreInfoColour:SetColor(Color(0,255,0,255))
			PlayerScoreInfoColour:SizeToContents()
		end
		
		
		-- Times Joined
		local PlayerJoinedInfo = vgui.Create( "DLabel", MainMenu )
		PlayerJoinedInfo:SetPos( 20, PlayerInfos + 62 )
		--PlayerJoinedInfo:SetFont("BudgetLabel")
		PlayerJoinedInfo:SetFont("TargetID2")
		PlayerJoinedInfo:SetText( "Times Joined: " )
		PlayerJoinedInfo:SetColor(Color(255,255,255,255))
		PlayerJoinedInfo:SizeToContents()
		if PlayerJoined < PlayerDisconnected then
			-- Times Joined of Player Colour
			local PlayerJoinedInfoColour = vgui.Create( "DLabel", MainMenu )
			PlayerJoinedInfoColour:SetPos( 113, PlayerInfos + 62 )
			PlayerJoinedInfoColour:SetFont("TargetID2")
			PlayerJoinedInfoColour:SetText( PlayerJoined )
			PlayerJoinedInfoColour:SetColor(Color(255,0,0,255))
			PlayerJoinedInfoColour:SizeToContents()
		else
			-- Times Joined of Player Colour
			local PlayerJoinedInfoColour = vgui.Create( "DLabel", MainMenu )
			PlayerJoinedInfoColour:SetPos( 113, PlayerInfos + 62 )
			PlayerJoinedInfoColour:SetFont("TargetID2")
			PlayerJoinedInfoColour:SetText( PlayerJoined )
			PlayerJoinedInfoColour:SetColor(Color(0,255,0,255))
			PlayerJoinedInfoColour:SizeToContents()
		end
		
		
		-- Times Leave
		local PlayerLeftInfo = vgui.Create( "DLabel", MainMenu )
		PlayerLeftInfo:SetPos( 20, PlayerInfos + 76 )
		--PlayerLeftInfo:SetFont("BudgetLabel")
		PlayerLeftInfo:SetFont("TargetID2")
		PlayerLeftInfo:SetText( "Times Disconnected: " )
		PlayerLeftInfo:SetColor(Color(255,255,255,255))
		PlayerLeftInfo:SizeToContents()
		if PlayerJoined < PlayerDisconnected then
			-- Times Joined of Player Colour
			local PlayerLeftInfoColour = vgui.Create( "DLabel", MainMenu )
			PlayerLeftInfoColour:SetPos( 158, PlayerInfos + 76 )
			PlayerLeftInfoColour:SetFont("TargetID2")
			PlayerLeftInfoColour:SetText( PlayerDisconnected )
			PlayerLeftInfoColour:SetColor(Color(255,0,0,255))
			PlayerLeftInfoColour:SizeToContents()
		else
			-- Times Joined of Player Colour
			local PlayerLeftInfoColour = vgui.Create( "DLabel", MainMenu )
			PlayerLeftInfoColour:SetPos( 158, PlayerInfos + 76 )
			PlayerLeftInfoColour:SetFont("TargetID2")
			PlayerLeftInfoColour:SetText( PlayerDisconnected )
			PlayerLeftInfoColour:SetColor(Color(0,255,0,255))
			PlayerLeftInfoColour:SizeToContents()
		end
		
		
		-- Favorite Weapon of Player
		local PlayerFavGunInfo = vgui.Create( "DLabel", MainMenu )
		PlayerFavGunInfo:SetPos( 20, PlayerInfos + 122 )
		--PlayerFavGunInfo:SetFont("BudgetLabel")
		PlayerFavGunInfo:SetFont("TargetID2")
		PlayerFavGunInfo:SetText( "Favourite Weapon: " )
		PlayerFavGunInfo:SetColor(Color(255,255,255,255))
		PlayerFavGunInfo:SizeToContents()
		
		-- Favorite Weapon of Player Colour
		local PlayerFavGunInfoColour = vgui.Create( "DLabel", MainMenu )
		PlayerFavGunInfoColour:SetPos( 148, PlayerInfos + 122 )
		--PlayerFavGunInfoColour:SetFont("BudgetLabel")
		PlayerFavGunInfoColour:SetFont("TargetID2")
		PlayerFavGunInfoColour:SetText( FavGunNiceName.." ("..FavGunKills..")" )
		PlayerFavGunInfoColour:SetColor(Color(255,215,0,255))
		PlayerFavGunInfoColour:SizeToContents()
		
		-- Picutre of Favorite Weapon
		if FavGunNamePicture != nil then
			PlayerFavGunInfoPic = vgui.Create( "DModelPanel", MainMenu )
			PlayerFavGunInfoPic:SetModel( FavGunNamePicture )
			PlayerFavGunInfoPic:SetPos( -150, PlayerInfos + 10 )
			PlayerFavGunInfoPic:SetSize( 450, 450 )
			PlayerFavGunInfoPic:SetCamPos( Vector( 0, 55, 25 ) )
			PlayerFavGunInfoPic:SetLookAt( Vector( 05, 0, 0 ) )
		else
			PlayerFavGunInfoColour:SetText( FavGunNiceName.." ("..FavGunKills..") {WEAPON HAS BEEN REMOVED FROM THE SERVER!}" )
			PlayerFavGunInfoColour:SizeToContents()
		end
		
	end
	usermessage.Hook("f1_menu_apple", f1_menu_apple)
	
	
	function f1_menu_apple_class_list(data)
		local name = data:ReadString()
		if IsValid(List_Classes_f1) == true then
			List_Classes_f1:AddChoice(name)
		end
	end
	usermessage.Hook("f1_menu_apple_class_list", f1_menu_apple_class_list)
	
	function f1_menu_apple_class_list22(data)
		local name = data:ReadString()
		if IsValid(ClassesWeaponListing2) == true then
			ClassesWeaponListing2:AddLine(name)
		end
	end
	usermessage.Hook("f1_menu_apple_class_list22", f1_menu_apple_class_list22)
	
	
	function f1_menu_apple_class_list_okl(data)
		local id = data:ReadShort()
		if IsValid(List_Classes_f1) == true then
			List_Classes_f1:ChooseOptionID( id )
		end
	end
	usermessage.Hook("f1_menu_apple_class_list_okl", f1_menu_apple_class_list_okl)
end



if SERVER then

	net.Receive( "f1_menu_apple_edit_class_submit_go", function( len, ply ) -- Add new weapon
	local name = net.ReadString()
		ply:SetPData("AppleTDMGmodClass", name)
	end)

	net.Receive( "f1_menu_apple_class_list22", function( len, ply )
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

	net.Receive( "f1_menu_apple_class_list", function( len, ply ) -- Add new weapon
	local AllClasses = sql.Query( "SELECT * FROM apple_deathmatch_classes;" )
	if AllClasses == nil then return end
	SelectTheCurrentClass = {}
		for k, v in pairs(AllClasses) do
		SelectTheCurrentClass[k] = v['Name']
			umsg.Start( "f1_menu_apple_class_list", ply )
				umsg.String(v['Name'])
			umsg.End()
		end
	if ply:GetPData("AppleTDMGmodClass") != nil then 
		timer.Simple(0.25, function()
			for k, v in pairs(SelectTheCurrentClass) do
				if v == ply:GetPData("AppleTDMGmodClass") then
					umsg.Start( "f1_menu_apple_class_list_okl", ply )
						umsg.Short(k)
					umsg.End()
				end
			end
		end)
	end
	end)

	function GM:ShowHelp( ply ) -- This hook is called every time F1 is pressed.
		local PlayerInfo = sql.Query( "SELECT * from apple_deathmatch_player_103 WHERE SteamID = '"..tostring(ply:UniqueID()).."';" )
		if PlayerInfo == nil then return end
		for k, v in pairs(PlayerInfo) do
			f1_PlayerKills = v['Kills']
			f1_PlayerDeaths = v['Deaths']
			f1_PlayerScore = v['Score']
			f1_PlayerRatio = v['Ratio']
			f1_PlayerJoin = v['cont']
			f1_PlayerDisc = v['dsc']
		end
		local GunInfo = sql.Query( "SELECT * from apple_deathmatch_fav_gun"..tostring(ply:UniqueID()).." ORDER BY Kills DESC LIMIT 1;" )
		if GunInfo != nil then
			for k, v in pairs(GunInfo) do
				f1_GunNiceName = v['weapon_name_nice']
				f1_GunName = v['weapon_name']
				f1_GunKills = v['Kills']
			end
		else
			f1_GunNiceName = "N/A"
			f1_GunName = "weapon_medkit"
			f1_GunKills = "No Kills"
		end
			umsg.Start( "f1_menu_apple", ply )
				umsg.Short(f1_PlayerKills)
				umsg.Short(f1_PlayerDeaths)
				umsg.Short(f1_PlayerScore)
				umsg.String(f1_PlayerRatio)
				umsg.String(f1_GunNiceName)
				umsg.String(f1_GunName)
				umsg.Short(f1_GunKills)
				umsg.Short(f1_PlayerJoin)
				umsg.Short(f1_PlayerDisc)
			umsg.End()
	end
util.AddNetworkString( "f1_menu_apple_class_list" )
util.AddNetworkString( "f1_menu_apple_class_list22" )
util.AddNetworkString( "f1_menu_apple_edit_class_submit_go" )
end
