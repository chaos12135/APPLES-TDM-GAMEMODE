-- The F4 Menu

if CLIENT then
function LeaderboardsSB(data)
local IsAdminQ = data:ReadShort()
local TotalNumbers = data:ReadString()
	SBNextPageNum = 0
	SBPageNum = 1
	SBFrame = vgui.Create( "DFrame" )
	SBFrame:SetSize( 350, 400 ) 
	SBFrame:Center()
	SBFrame:SetTitle( "Leaderboards Page: "..SBPageNum ) 
	SBFrame:SetSizable(false)
	SBFrame:SetDraggable(false)
	SBFrame:ShowCloseButton( true ) 
	SBFrame:MakePopup() 
	
	SBListView = vgui.Create("DListView",SBFrame)
	SBListView:SetPos(10, 30)
	SBListView:SetSize(330, 320)
	SBListView:SetMultiSelect(false)
	SBListView:AddColumn("Rank")
	SBListView:AddColumn("Name"):SetFixedWidth(150)
	SBListView:AddColumn("Kills")
	SBListView:AddColumn("Deaths")
	SBListView:AddColumn("Ratio")
	
	local Next = vgui.Create("DButton", SBFrame)
	Next:SetSize(ScrW() * 0.050, ScrH() * 0.025)
	Next:Center()
	Next:SetPos(185,365)
	Next:SetText("Next")
	Next.DoClick = function()
	SBNextPageNum = SBNextPageNum + 17
	SBPageNum = SBPageNum + 1
	SBFrame:SetTitle( "Leaderboards Page: "..SBPageNum ) 
		SBListView:Clear()
		net.Start( "ScoreboardLeaderBoardClient" )
			net.WriteString(SBNextPageNum)
		net.SendToServer()
	surface.PlaySound( "garrysmod/content_downloaded.wav" )
	end
	
	local Last = vgui.Create("DButton", SBFrame)
	Last:SetSize(ScrW() * 0.020, ScrH() * 0.025)
	Last:Center()
	Last:SetPos(270,365)
	Last:SetText("Last")
	Last.DoClick = function()
	SBListView:Clear()
		net.Start( "ScoreboardLeaderBoardCount" )
		net.SendToServer()
	surface.PlaySound( "garrysmod/content_downloaded.wav" )
	end
	
	local First = vgui.Create("DButton", SBFrame)
	First:SetSize(ScrW() * 0.020, ScrH() * 0.025)
	First:Center()
	First:SetPos(47,365)
	First:SetText("First")
	First.DoClick = function()
	SBListView:Clear()
		net.Start( "ScoreboardLeaderBoardCount2" )
		net.SendToServer()
	surface.PlaySound( "garrysmod/content_downloaded.wav" )
	end
	
	local Back = vgui.Create("DButton", SBFrame)
	Back:SetSize(ScrW() * 0.050, ScrH() * 0.025)
	Back:Center()
	Back:SetPos(85,365)
	Back:SetText("Back")
	Back.DoClick = function()
	if SBNextPageNum - 17 < 0 then
		Derma_Message( "You are on the first page, you can not go back!", "Error", "OK" )
		surface.PlaySound( "garrysmod/ui_click.wav" )
	else
	SBNextPageNum = SBNextPageNum - 17
	SBPageNum = SBPageNum - 1
	SBFrame:SetTitle( "Leaderboards Page: "..SBPageNum ) 
		SBListView:Clear()
		net.Start( "ScoreboardLeaderBoardClient" )
			net.WriteString(SBNextPageNum)
		net.SendToServer()
	surface.PlaySound( "garrysmod/content_downloaded.wav" )
	end
	end		
	
	SBFrame.OnClose = function() 
	if NewFrameIsOpen == 1 then
		NewFrameIsOpen = 0
		SBFrame2:Close()
	end
	end
	
	local FLabel2 = vgui.Create( "DLabel", SBFrame )
	FLabel2:Center()
	FLabel2:SetPos( 130, 350 )
	--FLabel2:SetColor(Color(255,255,255,255)) // Color
	--FLabel2:SetFont("default")
	FLabel2:SetText("Total Players: "..TotalNumbers)
	FLabel2:SizeToContents()
	
SBListView.OnRowSelected = function( panel, line )
	local SBListOptions = DermaMenu()		
	for k,v in pairs(SBLclTable) do
		if tonumber(SBNextPageNum)+tonumber(k) == tonumber(SBListView:GetLine(line):GetValue(1)) then
			local PlayersTeamID = tostring(v)
			
			SBListOptions:AddOption(PlayersTeamID, function()
				MsgN(PlayersTeamID) 
				Derma_Message("SteamID has been printed to your console!","Scoreboard","Okay")
			end)
			
			if IsAdminQ == 1 then
				SBListOptions:AddOption("Reset", function()

					NewFrameIsOpen = 1
					SBFrame2 = vgui.Create( "DFrame" )
					SBFrame2:SetSize( 200, 75 ) 
					SBFrame2:Center()
					SBFrame2:SetTitle( "Reset players score! BE CAREFUL!" ) 
					SBFrame2:SetSizable(false)
					SBFrame2:SetDraggable(false)
					SBFrame2:ShowCloseButton( false ) 
					SBFrame2:MakePopup() 
					
					local Yes = vgui.Create("DButton", SBFrame2)
					Yes:SetSize(ScrW() * 0.050, ScrH() * 0.025)
					Yes:Center()
					Yes:SetPos(15,39)
					Yes:SetText("Yes")
					Yes.DoClick = function()
					Derma_Message("The player has been completely reset.. there is no going back now!","Scoreboard","Okay")
						net.Start( "ScoreboardLeaderBoardClientReset" )
							net.WriteString(PlayersTeamID)
							net.WriteString(SBNextPageNum)
						net.SendToServer()
						NewFrameIsOpen = 0
						SBFrame2:Close()
					end
					
					local No = vgui.Create("DButton", SBFrame2)
					No:SetSize(ScrW() * 0.050, ScrH() * 0.025)
					No:Center()
					No:SetPos(105,39)
					No:SetText("No")
					No.DoClick = function()
						NewFrameIsOpen = 0
						SBFrame2:Close()
					end
					
				end)
			end
			
		end
	end
	SBListOptions:Open()
end	
end
usermessage.Hook("LeaderboardsSB",LeaderboardsSB)


function LeaderboardsRSB(data)
local SBNumber = data:ReadString()
local SBKills = data:ReadString()
local SBDeaths = data:ReadString()
	if SBKills == "0" then
		SBRatio = -SBDeaths
	elseif SBDeaths == "0" then
		SBRatio = (tonumber(SBKills)/1)
	else
		SBRatio = (tonumber(SBKills)/tonumber(SBDeaths))
	end
chat.AddText(Color(255,255,0),"Rank Throughout Entire Server (!score): ",Color(255,255,255),SBNumber,Color(255,255,0),"\nKills: ",Color(255,255,255),SBKills,Color(255,255,0),"\nDeaths: ",Color(255,255,255),SBDeaths,Color(255,255,0),"\nRatio: ",Color(255,255,255),tostring(string.format("%.2f",tostring(SBRatio))))
end
usermessage.Hook("LeaderboardsRSB",LeaderboardsRSB)


function ClearLeaderboardsSB()
if SBListView == nil || SBListView == NULL || !SBListView:IsValid() then return end
SBListView:Clear()
end
usermessage.Hook("ClearLeaderboardsSB",ClearLeaderboardsSB)

function LeaderBoardsSBPage(data)
if SBFrame == nil || SBFrame == NULL || !SBFrame:IsValid() then return end
SBPageNum = data:ReadString()
SBNextPageNum = ((SBPageNum*17)-17)
SBFrame:SetTitle( "Leaderboards Page: "..tostring(SBPageNum) ) 
end
usermessage.Hook("LeaderBoardsSBPage",LeaderBoardsSBPage)

function ResetLeaderboardsSB()
SBLclTable = {}
end
usermessage.Hook("ResetLeaderboardsSB",ResetLeaderboardsSB)


net.Receive( "ScoreboardLeaderBoard", function( len )
	local SBID = net.ReadString()
	local SBName = net.ReadString()
	local SBKills = net.ReadString()
	local SBDeaths = net.ReadString()
	local SBSTEAMID = net.ReadString()
	table.insert(SBLclTable, SBSTEAMID)
	if tonumber(SBDeaths) == 0 then
		SBRatio = (SBKills)
	elseif tonumber(SBKills) == 0 then
		SBRatio = (-SBDeaths)
	else
		SBRatio = (SBKills/SBDeaths)
	end
	SBListView:AddLine(SBNextPageNum+tonumber(SBID),tostring(SBName),tonumber(SBKills),tonumber(SBDeaths),string.format("%.2f",tostring(SBRatio)))
	SBListView:SortByColumn(1,false)
end)
end







if SERVER then
-- Server Side
if not SERVER then return end


function LBcreateTable()
	local result = sql.Query( "CREATE TABLE scoreboards (uniqueid INTEGER NOT NULL, playername VARCHAR(100) NOT NULL, steamid64 VARCHAR(45) NOT NULL, steamid32 VARCHAR(45) NOT NULL, team VARCHAR(45) NOT NULL, t_red INTEGER NOT NULL, t_green INTEGER NOT NULL, t_blue INTEGER NOT NULL, kills INTEGER NOT NULL, deaths INTEGER NOT NULL, ratio FLOAT NOT NULL, PRIMARY KEY (uniqueid))" )
	--MsgN("13: ".. sql.LastError(result))
end

function Leaderboards_Table_Checker()
	if !(sql.TableExists("scoreboards")) then
		LBcreateTable()
	end
end


function LeaderboardsSystem( ply )
if ply:IsBot() == true then return end
    function LBPaddPly(ply)
		if ply:IsValid() == false || ply:Team() == nil then 
			LBPaddPly(ply)
		return end
		sql.Query("INSERT into scoreboards ( uniqueid, playername, steamid64, steamid32, team, t_red, t_green, t_blue, kills, deaths, ratio) VALUES ( '"..ply:UniqueID().."', "..sql.SQLStr(ply:Nick())..", '"..ply:SteamID64().."', '"..ply:SteamID().."', "..sql.SQLStr(team.GetName( ply:Team() ))..", '"..(team.GetColor(ply:Team()).r).."', '"..(team.GetColor(ply:Team()).g).."', '"..(team.GetColor(ply:Team()).b).."', '0', '0', '0')")
		--MsgN("25: ".. sql.LastError(rwrawrww))
    end

	timer.Simple(5, function()
        local LBProw = sql.Query("SELECT * FROM scoreboards WHERE uniqueid = '"..tonumber(ply:UniqueID()).."'")
		--MsgN("31: ".. sql.LastError(LBProw))
            if (LBProw) then
				ply:SetPData("LeaderBoardsScoreKills",tonumber(LBProw[1]['kills']))
				ply:SetPData("LeaderBoardsScoreDeaths",tonumber(LBProw[1]['deaths']))
				ply:SetPData("LeaderBoardsScoreRatio",tonumber(LBProw[1]['ratio']))
				local LBQc = sql.Query("UPDATE scoreboards SET playername = ".. sql.SQLStr(ply:Nick())..", team = "..sql.SQLStr(team.GetName(ply:Team()))..", t_red = "..team.GetColor(ply:Team()).r..", t_green = "..team.GetColor(ply:Team()).g..", t_blue = "..team.GetColor(ply:Team()).b.." WHERE uniqueid = '"..tonumber(ply:UniqueID()).."';")
			--	MsgN("34: ".. sql.LastError(LBQc))
            else
                LBPaddPly(ply)
				ply:SetPData("LeaderBoardsScoreKills",tonumber(0))
				ply:SetPData("LeaderBoardsScoreDeaths",tonumber(0))
				ply:SetPData("LeaderBoardsScoreRatio",tonumber(0))
            end
    end)
end
hook.Add( "PlayerInitialSpawn", "LeaderboardsSystem", LeaderboardsSystem )


function PDLeaderBoards(vic,wep,ply)
if vic:IsPlayer() == false || ply:IsPlayer() == false || ply:IsValid() == false || vic:IsValid() == false || vic:IsBot() == true then return end

if ply:GetPData("LeaderBoardsScoreKills") == nil || ply:GetPData("LeaderBoardsScoreDeaths") == nil || vic:GetPData("LeaderBoardsScoreKills") == nil || vic:GetPData("LeaderBoardsScoreDeaths") == nil then return end

if vic == ply then 
	local PlayerDeaths = tonumber(ply:GetPData("LeaderBoardsScoreDeaths"))+1
	local AttackerKill = tonumber(ply:GetPData("LeaderBoardsScoreKills"))
	
	if tonumber(PlayerDeaths) == 0 then
		AttackerRatio = (AttackerKill)
	elseif tonumber(AttackerKill) == 0 then
		AttackerRatio = (-PlayerDeaths)
	else
		AttackerRatio = (AttackerKill/PlayerDeaths)
	end
	
	ply:SetPData("LeaderBoardsScoreDeaths",tonumber(PlayerDeaths))
	local LBQc = sql.Query("UPDATE scoreboards SET deaths = '"..PlayerDeaths.."', playername = ".. sql.SQLStr(ply:Nick())..", team = "..sql.SQLStr(team.GetName(ply:Team()))..", t_red = "..team.GetColor(ply:Team()).r..", t_green = "..team.GetColor(ply:Team()).g..", t_blue = "..team.GetColor(ply:Team()).b..", ratio = '"..AttackerRatio.."' WHERE uniqueid = '"..tonumber(ply:UniqueID()).."';")
	--MsgN("69: ".. sql.LastError(LBQc))
return end

local PlayerKills = tonumber(ply:GetPData("LeaderBoardsScoreKills"))+1
local PlayerDeaths = tonumber(vic:GetPData("LeaderBoardsScoreDeaths"))+1

local VictimsDeath = tonumber(vic:GetPData("LeaderBoardsScoreDeaths"))+1
local VictimsKill = tonumber(vic:GetPData("LeaderBoardsScoreKills"))
local AttackerDeath = tonumber(ply:GetPData("LeaderBoardsScoreDeaths"))
local AttackerKill = tonumber(ply:GetPData("LeaderBoardsScoreKills"))+1

ply:SetPData("LeaderBoardsScoreKills",tonumber(PlayerKills))
vic:SetPData("LeaderBoardsScoreDeaths",tonumber(PlayerDeaths))

if tonumber(VictimsDeath) == 0 then
	VictimsRatio = (VictimsKill)
elseif tonumber(VictimsKill) == 0 then
	VictimsRatio = (-VictimsDeath)
else
	VictimsRatio = (VictimsKill/VictimsDeath)
end

if tonumber(AttackerDeath) == 0 then
	AttackerRatio = (AttackerKill)
elseif tonumber(AttackerKill) == 0 then
	AttackerRatio = (-AttackerDeath)
else
	AttackerRatio = (AttackerKill/AttackerDeath)
end

local LBQc = sql.Query("UPDATE scoreboards SET deaths = '"..PlayerDeaths.."', playername = ".. sql.SQLStr(vic:Nick())..", team = "..sql.SQLStr(team.GetName(vic:Team()))..", t_red = "..team.GetColor(vic:Team()).r..", t_green = "..team.GetColor(vic:Team()).g..", t_blue = "..team.GetColor(vic:Team()).b..", ratio = '"..VictimsRatio.."' WHERE uniqueid = '"..tonumber(vic:UniqueID()).."';")
--MsgN("99: ".. sql.LastError(LBQc))

local LBQc = sql.Query("UPDATE scoreboards SET kills = '"..PlayerKills.."', playername = ".. sql.SQLStr(ply:Nick())..", team = "..sql.SQLStr(team.GetName(ply:Team()))..", t_red = "..team.GetColor(ply:Team()).r..", t_green = "..team.GetColor(ply:Team()).g..", t_blue = "..team.GetColor(ply:Team()).b..", ratio = '"..AttackerRatio.."' WHERE uniqueid = '"..tonumber(ply:UniqueID()).."';")
--MsgN("102: ".. sql.LastError(LBQc))
end
hook.Add("PlayerDeath","PDLeaderBoards",PDLeaderBoards)
 
 
function GM:ShowSpare2( ply )
local LBProw = sql.Query("SELECT COUNT(uniqueid) FROM scoreboards")
	if (LBProw) then
	local TotalNumberofPlayers = tostring(LBProw[1]['COUNT(uniqueid)'])
	local LBProw2 = sql.Query("SELECT * FROM scoreboards ORDER BY ratio DESC LIMIT 17")
		if not (LBProw2 == nil) then
			umsg.Start("LeaderboardsSB",ply)
			if ULib != nil then
				if ULib.ucl.query( ply, "apple gamemode scoreboard" ) == true then
					umsg.Short(1)
				elseif ULib.ucl.query( ply, "apple gamemode scoreboard" ) == false then
					umsg.Short(0)
				end
			else
				if ply:IsSuperAdmin() == true then
					umsg.Short(1)
				else
					umsg.Short(0)
				end
			end
			umsg.String(TotalNumberofPlayers)
			umsg.End()
						
			umsg.Start("ResetLeaderboardsSB",ply)
			umsg.End()
						
			timer.Simple(0.25,function()
				for k, v in pairs(LBProw2) do
					net.Start( "ScoreboardLeaderBoard" )
						net.WriteString( k )
						net.WriteString( v['playername'] )
						net.WriteString( v['kills'] )
						net.WriteString( v['deaths'] )
						net.WriteString( v['steamid32'] )
					net.Send(ply)
				end
			end)
		end
	end
end
 
 

function PSLeaderBoards(ply,say)
local say = string.Explode(" ",say)
if say[1] == "!rank" then
	local LBProw = sql.Query("SELECT * FROM scoreboards ORDER BY ratio DESC")
	--MsgN("145: ".. sql.LastError(LBProw))
            if not (LBProw == nil) then
			GrabRankTable = {}
				for k, v in pairs(LBProw) do
					table.insert(GrabRankTable, v['steamid32'])
				end
				
				for k, v in pairs(GrabRankTable) do
					if tostring(v) == ply:SteamID() then
					local KeepNum = k
		
					local LBProw = sql.Query("SELECT * FROM scoreboards WHERE uniqueid = '"..tonumber(ply:UniqueID()).."';")
					--MsgN("157: ".. sql.LastError(LBProw))
						if (LBProw) then
							umsg.Start("LeaderboardsRSB",ply)
								umsg.String(KeepNum)
								umsg.String(LBProw[1]['kills'])
								umsg.String(LBProw[1]['deaths'])
							umsg.End()
						end
					end
				end
			end
end
end
hook.Add("PlayerSay","PSLeaderBoards",PSLeaderBoards)

net.Receive( "ScoreboardLeaderBoardClient", function( length, client )
	local LBProw = sql.Query("SELECT * FROM scoreboards ORDER BY ratio DESC LIMIT 17 OFFSET "..tonumber(net.ReadString())..";")
	if LBProw == nil then return end
        --MsgN("173: ".. sql.LastError(LBProw))
			umsg.Start("ResetLeaderboardsSB",client)
			umsg.End()
			timer.Simple(0.25,function()
				for k, v in pairs(LBProw) do
				net.Start( "ScoreboardLeaderBoard" )
					net.WriteString( k )
					net.WriteString( v['playername'] )
					net.WriteString( v['kills'] )
					net.WriteString( v['deaths'] )
					net.WriteString( v['steamid32'] )
				net.Send(client)
				end
			end)

end)

ThisIsAVariableToCountRows = 1
function ScoreboardCountBegin(TotalNums, CurrentVariableRow, client)
	if tonumber(17*CurrentVariableRow) < tonumber(TotalNums) then
		local CurrentVariableRow = CurrentVariableRow + 1
		ScoreboardCountBegin(TotalNums,CurrentVariableRow,client)
	else
		local ReadMyRowsCountOld = ((17*CurrentVariableRow)-17)
		
		local LBProw = sql.Query("SELECT * FROM scoreboards ORDER BY ratio DESC LIMIT 17 OFFSET "..ReadMyRowsCountOld..";")
			--MsgN("199: ".. sql.LastError(LBProw))
			umsg.Start("ResetLeaderboardsSB",client)
			umsg.End()
			timer.Simple(0.25,function()
				for k, v in pairs(LBProw) do
				ReadMyRowsCountOld = ReadMyRowsCountOld + 1
			--	MsgN(ReadMyRowsCountList.." - "..v['playername'])
				net.Start( "ScoreboardLeaderBoard" )
					net.WriteString( k )
					net.WriteString( v['playername'] )
					net.WriteString( v['kills'] )
					net.WriteString( v['deaths'] )
					net.WriteString( v['steamid32'] )
				net.Send(client)
				end
			end)
			umsg.Start("LeaderBoardsSBPage",client)
				umsg.String(CurrentVariableRow)
			umsg.End()
	end	
end

net.Receive( "ScoreboardLeaderBoardCount", function( length, client )
	local LBProw = sql.Query("SELECT COUNT(playername) from scoreboards;")
	--MsgN("223: ".. sql.LastError(LBProw))
			for k, v in pairs(LBProw) do
				local RogerRabbit = 1
				ScoreboardCountBegin(tonumber(v['COUNT(playername)']),RogerRabbit,client)
			end

end )

net.Receive( "ScoreboardLeaderBoardCount2", function( length, client )
	local LBProw = sql.Query("SELECT * FROM scoreboards ORDER BY ratio DESC LIMIT 17 OFFSET 0;")
	--MsgN("233: ".. sql.LastError(LBProw))
	umsg.Start("ResetLeaderboardsSB",client)
	umsg.End()
		timer.Simple(0.25,function()
			for k, v in pairs(LBProw) do
					net.Start( "ScoreboardLeaderBoard" )
						net.WriteString( k )
						net.WriteString( v['playername'] )
						net.WriteString( v['kills'] )
						net.WriteString( v['deaths'] )
						net.WriteString( v['steamid32'] )
					net.Send(client)
			end
		end)
	local CurrentVariableRow = 1
	umsg.Start("LeaderBoardsSBPage",client)
		umsg.String(CurrentVariableRow)
	umsg.End()
end )


net.Receive( "ScoreboardLeaderBoardClientReset", function( length, client )
local SteamIDtoremove = tostring(net.ReadString())
local CurrentPageNum = tonumber(net.ReadString())
	local LBProw = sql.Query("UPDATE scoreboards SET kills = '0', deaths = '0', ratio = '0' WHERE steamid32 = '"..tostring(SteamIDtoremove).."';")
	--MsgN("258: ".. sql.LastError(LBProw))
	
	for k, v in pairs(player.GetAll()) do
		if v:SteamID() == tostring(SteamIDtoremove) then
			v:SetPData("LeaderBoardsScoreKills", 0)
			v:SetPData("LeaderBoardsScoreDeaths", 0)
		end
	end
	
	local LBQc = sql.Query("SELECT * FROM scoreboards ORDER BY ratio DESC LIMIT 17 OFFSET "..tonumber(CurrentPageNum)..";")
	--MsgN("261: ".. sql.LastError(LBQc))
	
	umsg.Start("ClearLeaderboardsSB",client)
	umsg.End()
	
	umsg.Start("ResetLeaderboardsSB",client)
	umsg.End()
	
		timer.Simple(0.25,function()
			for k, v in pairs(LBQc) do
			net.Start( "ScoreboardLeaderBoard" )
				net.WriteString( k )
				net.WriteString( v['playername'] )
				net.WriteString( v['kills'] )
				net.WriteString( v['deaths'] )
				net.WriteString( v['steamid32'] )
			net.Send(client)
			end
		end)
end )

Leaderboards_Table_Checker()

 util.AddNetworkString( "ScoreboardLeaderBoardCount" )
 util.AddNetworkString( "ScoreboardLeaderBoardCount2" )
 util.AddNetworkString( "ScoreboardLeaderBoard" )
 util.AddNetworkString( "ScoreboardLeaderBoardClientReset" )
 util.AddNetworkString( "ScoreboardLeaderBoardClient" )
 
end