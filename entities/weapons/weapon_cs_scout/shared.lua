if (SERVER) then
	AddCSLuaFile("shared.lua")
end

if (CLIENT) then
	SWEP.PrintName 			= "Schmidt Scout"
	SWEP.ViewModelFOV		= 80
	SWEP.Slot 				= 3
	SWEP.SlotPos 			= 1
	SWEP.IconLetter 		= "n"

	killicon.AddFont("weapon_cs_scout", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ))
end

SWEP.Category			= "Counter-Strike"

SWEP.Base				= "btw_scoped_base"

SWEP.HoldType 		= "ar2"

SWEP.Spawnable 			= true
SWEP.AdminSpawnable 		= true

SWEP.ViewModel 			= "models/weapons/v_snip_scout.mdl"
SWEP.WorldModel 			= "models/weapons/w_snip_scout.mdl"

SWEP.Primary.Sound 		= Sound("Weapon_SCOUT.Single")
SWEP.Primary.Damage 		= 70
SWEP.Primary.Recoil 		= 5
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Cone 		= 0.0001
SWEP.Primary.ClipSize 		= 5
SWEP.Primary.Delay 		= 1.2
SWEP.Primary.DefaultClip 	= 15
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 		= "smg1"

-- Weapon Variations
SWEP.UseScope				= true -- Use a scope instead of iron sights.
SWEP.ScopeScale 			= 0.55 -- The scale of the scope's reticle in relation to the player's screen size.
SWEP.ScopeZoom				= 8
-- Accuracy
SWEP.CrouchCone				= 0.001 -- Accuracy when we're crouching
SWEP.CrouchWalkCone			= 0.005 -- Accuracy when we're crouching and walking
SWEP.WalkCone				= 0.025 -- Accuracy when we're walking
SWEP.AirCone				= 0.1 -- Accuracy when we're in air
SWEP.StandCone				= 0.001 -- Accuracy when we're standing still