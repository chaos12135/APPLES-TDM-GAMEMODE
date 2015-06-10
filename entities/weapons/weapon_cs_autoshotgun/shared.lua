

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Leone YG1265 Auto Shotgun"			
	SWEP.Author				= "Fonix"
	SWEP.Slot				= 4
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "B"
	
	killicon.AddFont( "weapon_cs_autoshotgun", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
end

SWEP.HoldType			= "shotgun"
SWEP.Base				= "btw_shotgun_base"
SWEP.Category			= "Counter-Strike"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_shot_xm1014.mdl"
SWEP.WorldModel			= "models/weapons/w_shot_xm1014.mdl"

SWEP.Weight				= 10
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_xm1014.Single" )
SWEP.Primary.Recoil			= 3
SWEP.Primary.Damage			= 10
SWEP.Primary.NumShots		= 8
SWEP.Primary.Cone			= 0.05
SWEP.Primary.ClipSize		= 8
SWEP.Primary.Delay			= 0.2
SWEP.Primary.DefaultClip	= 16
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "buckshot"
