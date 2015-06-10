//Clientside file only

local fileLimit = CreateClientConVar("SoundMenu_fileLimit", "1000") //Limit of files in a folder before we start cutting it off
local SM
local binds = {}
local soundPlaying = false
local formats = {".wav", ".ogg", ".mp3"}

function SoundMenu()

    local keyDown = false
    
    hook.Add("Think", "SM_PressedSpace", function()
        if input.IsKeyDown(KEY_SPACE) and !keyDown then
            SM.Btn1.DoClick()
            keyDown = true
            timer.Simple(0.1, function() keyDown = false end)
        end
    end)
    
    if SM then SM.Frame:SetVisible(true) return end
    
    SM = {}
    
    SM.Frame = vgui.Create("DFrame")
    SM.Frame:SetTitle("Sound Browser")
    SM.Frame:SetSize(ScrW()/3, 2/3 * ScrH() + 30)
    SM.Frame:SetPos(ScrW()/2 - SM.Frame:GetWide()/2, ScrH()/2 - SM.Frame:GetTall()/2)
    SM.Frame:SetDraggable(true)
    SM.Frame:ShowCloseButton(true)
    SM.Frame:SetDeleteOnClose(false)
    SM.Frame:MakePopup()
    
    SM.Tree = vgui.Create("DTree", SM.Frame)
    SM.Tree:SetPos(15, 40)
    SM.Tree:SetSize(SM.Frame:GetWide() - 30, SM.Frame:GetTall() - 131)
    SM.Tree:SetPadding(5)
    
    SM.Btn1 = vgui.Create("DButton", SM.Frame)
    SM.Btn1:SetPos(15, SM.Frame:GetTall() - 73)
    SM.Btn1:SetSize(SM.Tree:GetWide()/3 - 2, 28)
    SM.Btn1:SetText("Play Sound")
    SM.Btn1:SetTooltip("Use the spacebar as a hotkey!")
    
    SM.Btn2 = vgui.Create("DButton", SM.Frame)
    SM.Btn2:SetPos(SM.Tree:GetWide()/3 + 17, SM.Frame:GetTall() - 73)
    SM.Btn2:SetSize(SM.Tree:GetWide()/3 - 2, 28)
    SM.Btn2:SetText("Stop Sound")

    SM.Btn3 = vgui.Create("DButton", SM.Frame)
    SM.Btn3:SetPos(SM.Tree:GetWide()*2/3 + 18, SM.Frame:GetTall() - 73)
    SM.Btn3:SetSize(SM.Tree:GetWide()/3 - 2, 28)
    SM.Btn3:SetText("Use Sound")

    SM.Btn4 = vgui.Create("DButton", SM.Frame)
    SM.Btn4:SetPos(15, SM.Frame:GetTall() - 90)
    SM.Btn4:SetSize(SM.Tree:GetWide(), 15)
    SM.Btn4:SetText("Refresh List")
    
	/*
    -- SM.Btn5 = vgui.Create("DBinder", SM.Frame)
    -- SM.Btn5:SetPos(15, SM.Frame:GetTall() - 43)
    -- SM.Btn5:SetSize(SM.Tree:GetWide()/3 - 2, 28)
    -- SM.Btn5:SetTooltip("Bind this sound to a key")
    -- SM.Btn5:SetDisabled(true)
    
    -- SM.Btn6 = vgui.Create("DButton", SM.Frame)
    -- SM.Btn6:SetPos(SM.Tree:GetWide()/3 + 17, SM.Frame:GetTall() - 43)
    -- SM.Btn6:SetSize(SM.Tree:GetWide()/3 - 2, 28)
    -- SM.Btn6:SetText("Unbind")
    -- SM.Btn6:SetDisabled(true)
		
    SM.ChkBox = vgui.Create("DCheckBoxLabel", SM.Frame)
    SM.ChkBox:SetText("Disable All Bindings")
    SM.ChkBox:SizeToContents()
    SM.ChkBox:SetPos(SM.Tree:GetWide()*2/3 + 18, SM.Frame:GetTall() + SM.ChkBox:GetTall()/2 - 43)
	*/
    
    SM.TreeNode = SM.Tree:AddNode("sound")
    SM.TreeNode.dir  = "sound/"
    SM.TreeNode.gen = false

    //
    local function FindSounds(node, dir)
        local files, dirs = file.Find(dir.."*", "GAME")
    
        for _,v in pairs(dirs) do
            local newNode = node:AddNode(v)
            newNode.dir = dir..v
            newNode.gen = false
        
            newNode.DoClick = function()
                if !newNode.gen then
                    FindSounds(newNode, dir..v.."/")
                    newNode.gen = true
                end
            end
        end
    
        local function GenerateNodes()
            local fileCount = 0

            for k,v in pairs(files) do
                if fileCount > fileLimit:GetInt() then break end
                local format = string.sub(v, -4)
                if format and table.HasValue(formats, format) then
                    fileCount = fileCount + 1

                    local newNode = node:AddNode(v)
                    newNode.file   = v
                    newNode.dir    = dir
                    newNode.IsFile = true
                    newNode.format = format
                    newNode.Icon:SetImage("icon16/sound.png")

                    files[k] = ""
                end
            end
        
            if fileCount > fileLimit:GetInt() then
                local newNode = node:AddNode("Click to load more files...")
                newNode.Icon:SetImage("icon16/sound_add.png")
                newNode.DoClick = function() 
                    newNode:Remove()
                    GenerateNodes()
                end
            end
        end
        GenerateNodes()
    end
    FindSounds(SM.TreeNode, "sound/")
    //
    
    SM.Btn1.DoClick = function()
        local item = SM.Tree:GetSelectedItem()
        if !item or !item.IsFile then return end
        local file = string.sub(item.dir, 7)..item:GetText()
        RunConsoleCommand("stopsound")
        timer.Simple(0.1, function() surface.PlaySound(file) end)
    end
    
    SM.Btn2.DoClick = function()
        RunConsoleCommand("stopsound")
    end

    SM.Btn3.DoClick = function()
        local item = SM.Tree:GetSelectedItem()
        if !item or !item.IsFile then return end
        local file = string.sub(item.dir, 7)..item:GetText()
		SM.Frame:Close()
		if IsValid(TeamWinSound) then
			TeamWinSound:SetText(file)
		elseif IsValid(TeamWinSoundEd) then
			TeamWinSoundEd:SetText(file)
		else
		SetClipboardText(file)
		end
    end
    
    SM.Btn4.DoClick = function()
        SM.TreeNode:Remove()
        SM.TreeNode = SM.Tree:AddNode("sound")
        SM.TreeNode.dir  = "sound/"
        SM.TreeNode.gen = false
    
        FindSounds(SM.TreeNode, "sound/")
    end
    
    --local oldClick = -- SM.Btn5.DoClick
    
	/*
    -- SM.Btn5.DoClick = function()
        oldClick(-- SM.Btn5)
        local item = SM.Tree:GetSelectedItem()
        local value = -- SM.Btn5:GetValue()
        hook.Add("Think", "SM_CheckValue", function()
            if -- SM.Btn5:GetValue() != value then
                hook.Remove("Think", "SM_CheckValue")
                local file = string.sub(item.dir, 7)..item:GetText()
                binds[file] = -- SM.Btn5:GetValue()
                -- SM.Btn6:SetDisabled(false)
            end
        end)
    end
	*/
    
	/*
    -- SM.Btn6.DoClick = function()
        local item = SM.Tree:GetSelectedItem()
        local file = string.sub(item.dir, 7)..item:GetText()
        if binds[file] then binds[file] = nil end
        -- SM.Btn5:SetValue(0)
        -- SM.Btn6:SetDisabled(true)
    end
	*/
    
    SM.Tree.DoClick = function()
        local item = SM.Tree:GetSelectedItem()
        if !item then return end
        if item.IsFile then
            local file = string.sub(item.dir, 7)..item:GetText()
            -- SM.Btn5:SetDisabled(false)
            if binds[file] and binds[file] != 0 then 
                -- SM.Btn5:SetValue(binds[file])
                -- SM.Btn6:SetDisabled(false)
            else
                -- SM.Btn5:SetValue(0)
            end
        else
        --    -- SM.Btn5:SetDisabled(true)
        end
    end
    
    SM.Frame.OnClose = function()
        hook.Remove("Think", "SM_PressedSpace")
        hook.Remove("Think", "SM_CheckValue")
    end 
    
	/*
    hook.Add("Think", "SM_CheckBind", function()
    --    if SM.ChkBox:GetChecked() then return end
        for k,v in pairs(binds) do
            if input.IsKeyDown(v) and !soundPlaying then
                soundPlaying = true
                timer.Simple(0.25, function() soundPlaying = false end)
                surface.PlaySound(k)
            end
        end
    end)
	*/
    
end
