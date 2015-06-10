

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "KM .45 Tactical"			
	SWEP.Author				= "Fonix"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "a"
	
	killicon.AddFont( "weapon_cs_usp", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
end

SWEP.HoldType			= "pistol"
SWEP.Base				= "btw_cs_base"
SWEP.Category			= "Counter-Strike"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_pist_usp.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_usp.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_usp.Single" )
SWEP.SilencedSound			= Sound( "Weapon_usp.SilencedShot" )
SWEP.Primary.Recoil			= 0.5
SWEP.Primary.Damage			= 40
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 10
SWEP.Primary.Delay			= 0.08
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"


-- Accuracy
SWEP.CrouchCone				= 0.02 -- Accuracy when we're crouching
SWEP.CrouchWalkCone			= 0.025 -- Accuracy when we're crouching and walking
SWEP.WalkCone				= 0.03 -- Accuracy when we're walking
SWEP.AirCone				= 0.1 -- Accuracy when we're in air
SWEP.StandCone				= 0.02 -- Accuracy when we're standing still
SWEP.IronsightsCone			= 0.015


function SWEP:Silence()
	if  self.Weapon:GetNetworkedBool("Silenced") == false then
		self.Weapon:SetNetworkedBool("Silenced", true)
		self.Weapon:SendWeaponAnim( ACT_VM_ATTACH_SILENCER ) 
		self.CSMuzzleFlashes	= true
	
	else
		self.Weapon:SetNetworkedBool("Silenced", false)
		self.Weapon:SendWeaponAnim( ACT_VM_DETACH_SILENCER ) 
		self.CSMuzzleFlashes	= true
	end
	self:SetIronsights( false )
	self.Weapon:SetNextPrimaryFire( CurTime() + 3 )
	self.Weapon:SetNextSecondaryFire( CurTime() + 3 )
	self.Reloadaftershoot = CurTime() + 3
	self.Weapon:SetNetworkedInt("deploydelay", CurTime() + 3);
end

function SWEP:SecondaryAttack()
	self:Silence()
end
