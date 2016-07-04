-- Read the weapon_real_base if you really want to know what each action does

if (SERVER) then
	AddCSLuaFile("shared.lua")
end

if (CLIENT) then
	SWEP.PrintName 		= "UTG L96 AWP SNIPER"
	SWEP.ViewModelFOV		= 60
	SWEP.Slot 			= 3
	SWEP.SlotPos 		= 1
	SWEP.IconLetter 		= "r"

	killicon.AddFont("weapon_real_cs_awp", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
end

/*---------------------------------------------------------
Muzzle Effect + Shell Effect
---------------------------------------------------------*/
SWEP.MuzzleEffect			= "rg_muzzle_highcal" -- This is an extra muzzleflash effect
-- Available muzzle effects: rg_muzzle_grenade, rg_muzzle_highcal, rg_muzzle_hmg, rg_muzzle_pistol, rg_muzzle_rifle, rg_muzzle_silenced, none

SWEP.ShellEffect			= "rg_shelleject_rifle" -- This is a shell ejection effect
-- Available shell eject effects: rg_shelleject, rg_shelleject_rifle, rg_shelleject_shotgun, none

SWEP.MuzzleAttachment		= "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment	= "2" -- Should be "2" for CSS models or "1" for hl2 models

SWEP.EjectDelay			= 0.6
/*-------------------------------------------------------*/

SWEP.Instructions 		= "Damage: 96% \nRecoil: 80% \nPrecision: 99.9% \nType: Bolt Action"

SWEP.Category			= "CS:S Realistic Weapons"		-- Swep Categorie (You can type what your want)

SWEP.Base 				= "weapon_real_base_snip"

SWEP.HoldType 		= "ar2"

SWEP.Spawnable 			= true
SWEP.AdminSpawnable 		= true

SWEP.ViewModel 			= "models/weapons/cstrike/c_snip_awp.mdl"
SWEP.WorldModel 			= "models/weapons/w_snip_awp.mdl"

SWEP.Primary.Sound 		= Sound("Weapon_AWP.Single")
SWEP.Primary.Damage 		= 96
SWEP.Primary.Recoil 		= 8
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Cone 		= 0.0001
SWEP.Primary.ClipSize 		= 10
SWEP.Primary.Delay 		= 1
SWEP.Primary.DefaultClip 	= 10
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 		= "smg1"

---------------------------
-- Ironsight/Scope --
---------------------------
-- IronSightsPos and IronSightsAng are model specific paramaters that tell the game where to move the weapon viewmodel in ironsight mode.

SWEP.IronSightsPos = Vector(-7.481, -5.64, 2.279)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightZoom			= 1.3 -- How much the player's FOV should zoom in ironsight mode. 
SWEP.UseScope				= true -- Use a scope instead of iron sights.
SWEP.ScopeScale 				= 0.4 -- The scale of the scope's reticle in relation to the player's screen size.
SWEP.ScopeZooms				= {14} -- The possible magnification levels of the weapon's scope.   If the scope is already activated, secondary fire will cycle through each zoom level in the table.
SWEP.DrawParabolicSights		= false -- Set to true to draw a cool parabolic sight (helps with aiming over long distances)