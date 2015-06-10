

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "M249"			
	SWEP.Author				= "Fonix"
	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "z"
	
	SWEP.ViewModelFlip		= false
	
	killicon.AddFont( "weapon_cs_para", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "btw_cs_base"
SWEP.Category			= "Counter-Strike"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_mach_m249para.mdl"
SWEP.WorldModel			= "models/weapons/w_mach_m249para.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_m249.Single" )
SWEP.Primary.Recoil			= 2
SWEP.Primary.Damage			= 40
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.05
SWEP.Primary.ClipSize		= 1000
SWEP.Primary.Delay			= 0.09
SWEP.Primary.DefaultClip	= 10000000
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

-- Accuracy
SWEP.CrouchCone				= 0.02 -- Accuracy when we're crouching
SWEP.CrouchWalkCone			= 0.05 -- Accuracy when we're crouching and walking
SWEP.WalkCone				= 0.09 -- Accuracy when we're walking
SWEP.AirCone				= 0.1 -- Accuracy when we're in air
SWEP.StandCone				= 0.07 -- Accuracy when we're standing still
SWEP.IronsightsCone			= 0.015