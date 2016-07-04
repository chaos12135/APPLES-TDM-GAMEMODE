-- Read the weapon_real_base if you really want to know what each action does

if (SERVER) then
	AddCSLuaFile("shared.lua")
end

if (CLIENT) then
	SWEP.PrintName 		= "INGRAM MAC M10"
	SWEP.Slot 			= 2
	SWEP.SlotPos 		= 1
	SWEP.IconLetter 		= "l"

	killicon.AddFont("weapon_real_cs_mac10", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ))
end

SWEP.Instructions 		= "Damage: 20% \nRecoil: 7% \nPrecision: 76% \nType: Automatic \nRate of Fire: 1000 rounds per minute \n\nChange Mode: E + Right Click"

SWEP.Category			= "CS:S Realistic Weapons"		-- Swep Categorie (You can type what your want)

SWEP.Base 				= "weapon_real_base_smg"

SWEP.HoldType 		= "smg"

SWEP.Spawnable 			= true
SWEP.AdminSpawnable 		= true

SWEP.ViewModel 			= "models/weapons/cstrike/c_smg_mac10.mdl"
SWEP.WorldModel 			= "models/weapons/w_smg_mac10.mdl"

SWEP.Primary.Sound 		= Sound("Weapon_MAC10.Single")
SWEP.Primary.Recoil 		= 0.7
SWEP.Primary.Damage 		= 20
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Cone 		= 0.024
SWEP.Primary.ClipSize 		= 30
SWEP.Primary.Delay 		= 0.055
SWEP.Primary.DefaultClip 	= 30
SWEP.Primary.Automatic 		= true
SWEP.Primary.Ammo 		= "pistol"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

SWEP.IronSightsPos = Vector(-9.2, -7.12, 2.66)
SWEP.IronSightsAng = Vector(1.5, -5.301, -7.2)