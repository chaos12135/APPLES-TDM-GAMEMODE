-- Read the weapon_real_base if you really want to know what each action does

if (SERVER) then
	AddCSLuaFile("shared.lua")
end

if (CLIENT) then
	SWEP.PrintName 		= "DESERT EAGLE .50"
	SWEP.ViewModelFOV		= 70
	SWEP.Slot 			= 1
	SWEP.SlotPos 		= 1
	SWEP.IconLetter 		= "f"

	killicon.AddFont("weapon_real_cs_desert_eagle", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ))
end

/*---------------------------------------------------------
Muzzle Effect + Shell Effect
---------------------------------------------------------*/
SWEP.MuzzleEffect			= "rg_muzzle_highcal" -- This is an extra muzzleflash effect
-- Available muzzle effects: rg_muzzle_grenade, rg_muzzle_highcal, rg_muzzle_hmg, rg_muzzle_pistol, rg_muzzle_rifle, rg_muzzle_silenced, none

SWEP.ShellEffect			= "rg_shelleject" -- This is a shell ejection effect
-- Available shell eject effects: rg_shelleject, rg_shelleject_rifle, rg_shelleject_shotgun, none

SWEP.MuzzleAttachment		= "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment	= "2" -- Should be "2" for CSS models or "1" for hl2 models

SWEP.EjectDelay			= 0.05
/*-------------------------------------------------------*/

SWEP.Instructions 		= "Damage: 50% \nRecoil: 60% \nPrecision: 86% \nType: Semi-Automatic"

SWEP.Category			= "CS:S Realistic Weapons"		-- Swep Categorie (You can type what your want)

SWEP.Base 				= "weapon_real_base_pistol"

SWEP.HoldType 		= "pistol"

SWEP.Spawnable 			= true
SWEP.AdminSpawnable 		= true

SWEP.ViewModel 			= "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel 			= "models/weapons/w_pist_deagle.mdl"

SWEP.Primary.Sound 		= Sound("Weapon_Deagle.Single")
SWEP.Primary.Recoil 		= 6
SWEP.Primary.Damage 		= 50
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Cone 		= 0.014
SWEP.Primary.ClipSize 		= 7
SWEP.Primary.Delay 		= 0.3
SWEP.Primary.DefaultClip 	= 7
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 		= "357"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 		= "none"

SWEP.IronSightsPos = Vector(-6.361, -10.961, 2.2)
SWEP.IronSightsAng = Vector(0, 0, 0)