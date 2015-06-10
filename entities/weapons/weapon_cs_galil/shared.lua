if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "IDF Defender"			
	SWEP.Author				= "Fonix"
	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "v"
	
	killicon.AddFont( "weapon_cs_galil", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "btw_cs_base"
SWEP.Category			= "Counter-Strike"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/v_rif_galil.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_galil.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_galil.Single" )
SWEP.Primary.Recoil			= 1
SWEP.Primary.Damage			= 27
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.017
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.08
SWEP.Primary.DefaultClip	= 60
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

-- Accuracy
SWEP.CrouchCone				= 0.01 -- Accuracy when we're crouching
SWEP.CrouchWalkCone			= 0.02 -- Accuracy when we're crouching and walking
SWEP.WalkCone				= 0.025 -- Accuracy when we're walking
SWEP.AirCone				= 0.1 -- Accuracy when we're in air
SWEP.StandCone				= 0.015 -- Accuracy when we're standing still
SWEP.IronsightsCone			= 0.015



