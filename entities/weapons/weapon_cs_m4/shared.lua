

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Maverick M4A1 Carbine"			
	SWEP.Author				= "Fonix"
	SWEP.Slot				= 2
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "w"
	
	killicon.AddFont( "weapon_cs_m4", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "btw_cs_base"
SWEP.Category			= "Counter-Strike"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_rif_m4a1.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_m4a1.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_M4A1.Single" )
SWEP.SilencedSound			= Sound( "Weapon_M4a1.Silenced" )
SWEP.Primary.Recoil			= 1.1
SWEP.Primary.Damage			= 28
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
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

//Silence Timings and Stuff
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
	self.Weapon:SetNextPrimaryFire( CurTime() + 2 )
	self.Weapon:SetNextSecondaryFire( CurTime() + 2 )
	self.Reloadaftershoot = CurTime() + 3 
	self.Weapon:SetNetworkedInt("deploydelay", CurTime() + 3);
end

function SWEP:SecondaryAttack()
	self:Silence()
end
