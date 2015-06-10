

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "228 Compact"			
	SWEP.Author				= "Fonix"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "y"
	
	killicon.AddFont( "weapon_cs_p228", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
end

SWEP.HoldType			= "pistol"
SWEP.Base				= "btw_cs_base"
SWEP.Category			= "Counter-Strike"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_pist_p228.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_p228.mdl"

SWEP.Weight				= 2
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_p228.Single" )
SWEP.Primary.Recoil			= 0.5
SWEP.Primary.Damage			= 40
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 10
SWEP.Primary.Delay			= 0.08
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"


-- Accuracy
SWEP.CrouchCone				= 0.02 -- Accuracy when we're crouching
SWEP.CrouchWalkCone			= 0.025 -- Accuracy when we're crouching and walking
SWEP.WalkCone				= 0.03 -- Accuracy when we're walking
SWEP.AirCone				= 0.1 -- Accuracy when we're in air
SWEP.StandCone				= 0.02 -- Accuracy when we're standing still
SWEP.IronsightsCone			= 0.015