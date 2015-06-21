-- Read the weapon_real_base if you really want to know what each action does

if (SERVER) then
	AddCSLuaFile("shared.lua")
end

if (CLIENT) then
	SWEP.PrintName 		= "HK UMP-45"
	SWEP.Slot 			= 2
	SWEP.SlotPos 		= 1
	SWEP.IconLetter 		= "q"

	killicon.AddFont("weapon_real_cs_ump_45", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ))
end

SWEP.Instructions 		= "Damage: 22% \nRecoil: 5% \nPrecision: 81% \nType: Automatic \nRate of Fire: 650 rounds per minute \n\nChange Mode: E + Right Click"

SWEP.Base 				= "weapon_real_base_smg"

SWEP.Category			= "CS:S Realistic Weapons"		-- Swep Categorie (You can type what your want)

SWEP.HoldType 		= "ar2"

SWEP.Spawnable 			= true
SWEP.AdminSpawnable 		= true

SWEP.ViewModel 			= "models/weapons/cstrike/c_smg_ump45.mdl"
SWEP.WorldModel 			= "models/weapons/w_smg_ump45.mdl"

SWEP.Primary.Sound 		= Sound("Weapon_UMP45.Single")
SWEP.Primary.Recoil 		= 0.5
SWEP.Primary.Damage 		= 22
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Cone 		= 0.019
SWEP.Primary.ClipSize 		= 25
SWEP.Primary.Delay 		= 0.09
SWEP.Primary.DefaultClip 	= 25
SWEP.Primary.Automatic 		= true
SWEP.Primary.Ammo 		= "pistol"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

SWEP.IronSightsPos = Vector(-8.761, -8.961, 4.119)
SWEP.IronSightsAng = Vector(-1.201, -0.301, -2.1)

SWEP.data 				= {}
SWEP.mode 				= "auto"

SWEP.data.semi 			= {}

SWEP.data.auto 			= {}