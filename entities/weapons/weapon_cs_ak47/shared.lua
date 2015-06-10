

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "CV-47"			
	SWEP.Author				= "Fonix"
	SWEP.Slot				= 2
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "b"
	
	killicon.AddFont( "weapon_cs_ak47", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "btw_cs_base"
SWEP.Category			= "Counter-Strike"
SWEP.ViewModelFlip		= true

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_rif_ak47.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_ak47.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= true
SWEP.AutoSwitchFrom		= true

SWEP.Primary.Sound			= Sound( "weapon_ak47.single" )
SWEP.Primary.Recoil			= 1
SWEP.Primary.Damage			= 34
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.1
SWEP.Primary.DefaultClip	= 60
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

-- Accuracy
SWEP.CrouchCone				= 0.01 -- Accuracy when we're crouching
SWEP.CrouchWalkCone			= 0.02 -- Accuracy when we're crouching and walking
SWEP.WalkCone				= 0.025 -- Accuracy when we're walking
SWEP.AirCone				= 0.1 -- Accuracy when we're in air
SWEP.StandCone				= 0.015 -- Accuracy when we're standing still
