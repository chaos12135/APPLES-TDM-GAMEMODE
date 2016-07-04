-- Read the weapon_real_base if you really want to know what each action does

if (SERVER) then
	AddCSLuaFile("shared.lua")
end

if (CLIENT) then
	SWEP.PrintName 		= "SIG-SAUER P228"
	SWEP.ViewModelFOV		= 70
	SWEP.Slot 			= 1
	SWEP.SlotPos 		= 1
	SWEP.IconLetter 		= "y"

	killicon.AddFont("weapon_real_cs_p228", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ))
end

SWEP.EjectDelay			= 0.05

SWEP.Instructions 		= "Damage: 15% \nRecoil: 8% \nPrecision: 87.5% \nType: Semi-Automatic"

SWEP.Category			= "CS:S Realistic Weapons"		-- Swep Categorie (You can type what your want)

SWEP.Base 				= "weapon_real_base_pistol"

SWEP.HoldType 		= "pistol"

SWEP.Spawnable 			= true
SWEP.AdminSpawnable 		= true

SWEP.ViewModel 			= "models/weapons/cstrike/c_pist_p228.mdl"
SWEP.WorldModel 			= "models/weapons/w_pist_p228.mdl"

SWEP.Primary.Sound 		= Sound("Weapon_P228.Single")
SWEP.Primary.Recoil 		= 0.8
SWEP.Primary.Damage 		= 15
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Cone 		= 0.0125
SWEP.Primary.ClipSize 		= 12
SWEP.Primary.Delay 		= 0.12
SWEP.Primary.DefaultClip 	= 12
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 		= "pistol"

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

SWEP.IronSightsPos = Vector(-5.961, -10.48, 2.759)
SWEP.IronSightsAng = Vector(0, 0, 0)