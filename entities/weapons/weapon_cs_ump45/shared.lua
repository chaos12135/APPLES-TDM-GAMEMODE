

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "KM UMP45"			
	SWEP.Author				= "Fonix"
	SWEP.Slot				= 2
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "q"
	
	killicon.AddFont( "weapon_cs_ump45", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
end

SWEP.HoldType			= "smg"
SWEP.Base				= "btw_cs_base"
SWEP.Category			= "Counter-Strike"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_smg_ump45.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_ump45.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_ump45.Single" )
SWEP.Primary.Recoil			= 0.6
SWEP.Primary.Damage			= 25
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.025	
SWEP.Primary.ClipSize		= 15
SWEP.Primary.Delay			= 0.1
SWEP.Primary.DefaultClip	= 45
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

-- Accuracy
SWEP.CrouchCone				= 0.02 -- Accuracy when we're crouching
SWEP.CrouchWalkCone			= 0.022 -- Accuracy when we're crouching and walking
SWEP.WalkCone				= 0.025 -- Accuracy when we're walking
SWEP.AirCone				= 0.1 -- Accuracy when we're in air
SWEP.StandCone				= 0.025 -- Accuracy when we're standing still
SWEP.IronsightsCone			= 0.015

