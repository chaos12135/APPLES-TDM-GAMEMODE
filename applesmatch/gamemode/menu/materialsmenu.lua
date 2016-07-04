//Clientside file only
local fileLimit = CreateClientConVar("MaterialMenu_fileLimit", "1000")  //Limit of files in a folder before we start cutting it off
local selMat, MM

function MaterialsMenu()
    
    if MM then MM.Frame:SetVisible(true) return end

    MM = {}
    
    MM.Frame = vgui.Create("DFrame")
    MM.Frame:SetTitle("Material Browser")
    MM.Frame:SetSize(ScrW()/2, 2/3 * ScrH())
    MM.Frame:SetPos(ScrW()/2 - MM.Frame:GetWide()/2, ScrH()/2 - MM.Frame:GetTall()/2)
    MM.Frame:SetDraggable(true)
    MM.Frame:ShowCloseButton(true)
    MM.Frame:SetDeleteOnClose(false)
    MM.Frame:MakePopup()
    
    MM.Tree = vgui.Create("DTree", MM.Frame)
    MM.Tree:SetPos(15, 40)
    MM.Tree:SetSize(MM.Frame:GetWide()/2 - 30, MM.Frame:GetTall() - 71)
    MM.Tree:SetPadding(5)

    MM.MatPnl = vgui.Create("DPanel", MM.Frame)
    MM.MatPnl:SetPos(MM.Frame:GetWide()/2 + 15, 40)
    MM.MatPnl:SetSize(MM.Frame:GetWide()/2 - 30, MM.Frame:GetWide()/2 - 30)
    
    MM.Mat = vgui.Create("DImage", MM.MatPnl)
    MM.Mat:SetPos(3,3)
    MM.Mat:SetSize(MM.MatPnl:GetWide() - 6, MM.MatPnl:GetTall() - 6)

    MM.TreeNode = MM.Tree:AddNode("materials")
    MM.TreeNode.dir  = "materials/"
    MM.TreeNode.gen = false

    local btnSpace = MM.Frame:GetTall() - MM.MatPnl:GetTall() - 60
    local btnH = btnSpace/4

    MM.Btn1 = vgui.Create("DButton", MM.Frame)
    MM.Btn1:SetPos(MM.Frame:GetWide()/2 + 15, MM.MatPnl:GetTall() + 45)
    MM.Btn1:SetSize(MM.Frame:GetWide()/2 - 30, btnH)
    MM.Btn1:SetText("Use Material")

    MM.Btn4 = vgui.Create("DButton", MM.Frame)
    MM.Btn4:SetPos(15, MM.Frame:GetTall() - 30)
    MM.Btn4:SetSize(MM.Tree:GetWide(), 15)
    MM.Btn4:SetText("Refresh List")

    MM.ChkBox = vgui.Create("DCheckBoxLabel", MM.Frame)
    MM.ChkBox:SetText("Show original size")
    MM.ChkBox:SizeToContents()
    MM.ChkBox:SetPos(MM.Frame:GetWide()/2 + 15, MM.MatPnl:GetTall() + 45 + btnH*3 + btnH/2 - MM.ChkBox:GetTall()/2)
    
    //
    local function FindMaterials(node, dir)
        local files, dirs = file.Find(dir.."*", "GAME")
        
        for _,v in pairs(dirs) do
            local newNode = node:AddNode(v)
            newNode.dir = dir..v
            newNode.gen = false
        
            newNode.DoClick = function()
                if !newNode.gen then
                    FindMaterials(newNode, dir..v.."/")
                    newNode.gen = true
                end
            end
        end

        local function GenerateNodes(stop)
            local fileCount = 0

            for k,v in pairs(files) do
                if fileCount > fileLimit:GetInt() then break end
                local format = string.sub(v, -4)
                if format == ".vmt" or format == ".png" then
                    fileCount = fileCount + 1

                    local newNode = node:AddNode(v)
                    newNode.file   = v
                    newNode.dir    = dir
                    newNode.IsFile = true
                    newNode.format = format
                    newNode.Icon:SetImage("icon16/picture.png")

                    files[k] = ""
                end
            end
    
            if fileCount > fileLimit:GetInt() then
                local newNode = node:AddNode("Click to load more files...")
                newNode.Icon:SetImage("icon16/picture_add.png")
                newNode.DoClick = function() 
                    newNode:Remove()
                    GenerateNodes()
                end
            end
        end
        GenerateNodes()
    end
    FindMaterials(MM.TreeNode, "materials/")
    //

    local function ResizeMat()
        if !MM.ChkBox:GetChecked() then
            MM.Mat:SetPos(3,3)
            MM.Mat:SetSize(MM.MatPnl:GetWide() - 6, MM.MatPnl:GetTall() - 6)
        else
            MM.Mat:SizeToContents()
            MM.Mat:SetPos(MM.MatPnl:GetWide()/2 - MM.Mat:GetWide()/2, MM.MatPnl:GetTall()/2 - MM.Mat:GetTall()/2)
        end
    end
    
    MM.ChkBox.OnChange = ResizeMat
    
    MM.Tree.DoClick = function()
        local mat = MM.Tree:GetSelectedItem()
        if mat and mat.IsFile then
			MsgN(mat:GetText())
            selMat = string.sub(mat.dir .. mat:GetText(), 11, -5)
            selMat2 = string.sub(mat.dir, 11)
			selMat3 = mat:GetText()
           -- MM.Btn2:SetDisabled(mat.format != ".vmt")
            --MM.Btn3:SetDisabled(mat.format != ".vmt")
            MM.Mat:SetImage(selMat..mat.format)
            ResizeMat()
        end
    end
    
    MM.Btn1.DoClick = function()
        if !selMat then return end
		if IsValid(RankMaterial) == true then
			RankMaterial:SetText(selMat2..selMat3)
			RankMaterial:SizeToContents()
		end
		if IsValid(RankMaterial2) == true then
			RankMaterial2:SetText(selMat2..selMat3)
			RankMaterial2:SizeToContents()
		end

		if IsValid(RankImageL2) == true then
			RankImageL2:SetImage( selMat2..selMat3 )
			RankImageL2:SizeToContents()
		end
		if IsValid(RankImageL) == true then
			RankImageL:SetImage( selMat2..selMat3 )
			RankImageL:SizeToContents()
		end

		MM.Frame:Close()
    end
    

    MM.Btn4.DoClick = function()
        MM.TreeNode:Remove()
        MM.TreeNode = MM.Tree:AddNode("materials")
        MM.TreeNode.dir  = "materials/"
        MM.TreeNode.gen = false
        
        FindMaterials(MM.TreeNode, "materials/")
    end
    
end
