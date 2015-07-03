-- client side apple
if SERVER then return end

-- Default colors
COLOR_WHITE = (Color(255,255,255,255))
COLOR_RED = (Color(255,0,0,255))
COLOR_BLUE = (Color(0,0,255,255))
COLOR_GREEN = (Color(0,255,0,255))
COLOR_BLACK = (Color(0,0,0,255))
COLOR_ORANGE = (Color(240,102,10,255))
COLOR_AQUA = (Color(0,138,184,255))
COLOR_HP = (Color(200,200,140,255))
COLOR_DEATHS = (Color(0,160,230,255))

--function CustomFonts() -- Creates custom fonts
surface.CreateFont( "TargetID2", { font = "TargetID", size = 16, weight = 900 } )
--surface.CreateFont( "Whatever", { font = "UbuntuMono-R" } )
surface.CreateFont( "DebugFixed2", { font = "DebugFixed" } )
surface.CreateFont( "TDM_Ammo_Primary", { font= "MenuLarge", size= 26, weight= 200 } )
surface.CreateFont( "MenuLarge2", { font = "MenuLarge", size = 16, weight = 5000 } )
surface.CreateFont( "TDM_Ammo_Secondary", { font= "HUDNumber", size= 73, weight= 200 } )
surface.CreateFont( "HUDNumber2", { font = "HUDNumber", size = 40, weight = 200 } )
surface.CreateFont( "TDM_Mini", { font = "HUDNumber", size = 34, weight = 200 } )
--end
--hook.Add("Initialize","CustomFonts",CustomFonts)
--CustomFonts()