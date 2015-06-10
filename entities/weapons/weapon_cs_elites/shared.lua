

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then

	SWEP.PrintName			= ".40 Dual Elites"			
	SWEP.Author				= "Fonix"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 5
	SWEP.IconLetter			= "s"
	
	killicon.AddFont( "weapon_cs_elites", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
end

SWEP.HoldType			= "revolver"
SWEP.Base				= "btw_cs_base"
SWEP.Category			= "Counter-Strike"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_pist_elite.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_elite.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_elite.Single" )
SWEP.Primary.Recoil			= 0.5
SWEP.Primary.Damage			= 40
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 20
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

/*---------------------------------------------------------
   Name: SWEP:CSShootBullet( )
---------------------------------------------------------*/
function SWEP:CSShootBullet( dmg, recoil, numbul, cone )

	numbul 	= numbul 	or 1
	cone 	= cone 		or 0.01

	local bullet = {}
	bullet.Num 		= numbul
	bullet.Src 		= self.Owner:GetShootPos()			// Source
	bullet.Dir 		= self.Owner:GetAimVector()			// Dir of bullet
	bullet.Spread 	= Vector( cone, cone, 0 )			// Aim Cone
	bullet.Tracer	= 4									// Show a tracer on every x bullets 
	bullet.Force	= 5									// Amount of force to give to phys objects
	bullet.Damage	= dmg
	
	self.Owner:FireBullets( bullet )
	
	animation = not animation
	if animation then
		self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
	else
		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	end
	self.Owner:MuzzleFlash()
	self.Owner:SetAnimation( PLAYER_ATTACK1 )				// 3rd Person Animation
	
	if ( self.Owner:IsNPC() ) then return end
	
	// CUSTOM RECOIL !
	if ( (game.SinglePlayer() and SERVER) || ( !game.SinglePlayer() and CLIENT && IsFirstTimePredicted() ) ) then
	
		local eyeang = self.Owner:EyeAngles()
		eyeang.pitch = eyeang.pitch - 0.2
		self.Owner:SetEyeAngles( eyeang )
	
	end

end


