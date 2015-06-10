if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Shotteh"			
	SWEP.Author				= "Fonix"
	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= ""
	SWEP.IconLetterCSS		= ""
	
	killicon.AddFont( "weapon_cs_ak47", "TextKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	surface.CreateFont("TextKillIcons", { font="Roboto-Medium", weight="500", size=ScreenScale(13),antialiasing=true,additive=true })
	surface.CreateFont("TextSelectIcons", { font="Roboto-Medium", weight="500", size=ScreenScale(20),antialiasing=true,additive=true })
	surface.CreateFont("CSKillIcons", { font="csd", weight="500", size=ScreenScale(30),antialiasing=true,additive=true })
	surface.CreateFont("CSSelectIcons", { font="csd", weight="500", size=ScreenScale(60),antialiasing=true,additive=true })
end


SWEP.HoldType			= "shotgun"
SWEP.Base				= "btw_cs_base"
SWEP.Category			= "lel"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.ViewModel			= "models/weapons/v_shot_war_md.mdl"
SWEP.WorldModel			= "models/weapons/w_shot_war_md.mdl"
SWEP.ViewModelFlip		= true
SWEP.ViewModelFOV		= 70

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= true
SWEP.AutoSwitchFrom		= true

SWEP.Primary.Sound			= Sound( "sound_fire.single" )
SWEP.Primary.Recoil			= 4
SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 10
SWEP.Primary.Cone			= 0.05
SWEP.Primary.ClipSize		= 8
SWEP.Primary.Delay			= 0.3
SWEP.Primary.DefaultClip	= 64
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "buckshot"

-- Accuracy
SWEP.Delay				= 0.4	-- Delay For Not Zoom
SWEP.Recoil				= 4	-- Recoil For not Aimed
SWEP.RecoilZoom				= 0.3	-- Recoil For Zoom


/*---------------------------------------------------------
	Reload does nothing
---------------------------------------------------------*/
function SWEP:Reload()
	
	//if ( CLIENT ) then return end
		
		
		if ( self.Weapon:Clip1() < 1) and self.Owner:KeyPressed(IN_ATTACK) then return end
		
	    self.Weapon:SetNetworkedBool("Ironsights", false)
		self.Owner:SetFOV(0, 0.15)
		self.Primary.Recoil = self:GetNWInt("recoil")
	
	// Already reloading
	if ( self.Weapon:GetNetworkedBool( "reloading", false ) ) then return end
	
	// Start reloading if we can
	if ( self.Weapon:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
		
		self.Weapon:SetNetworkedBool( "reloading", true )
		self.Weapon:SetVar( "reloadtimer", CurTime() + 0.1 )
		self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
	end
end

/*---------------------------------------------------------
   Think does nothing
---------------------------------------------------------*/
function SWEP:Think()
	
	if self.Owner:KeyPressed(IN_ATTACK) then 
	self.Weapon:SetNetworkedBool( "reloading", false )
	end
	
	if ( self.Weapon:GetNetworkedBool( "reloading", false ) ) then
	
		if ( self.Weapon:GetVar( "reloadtimer", 0 ) < CurTime() ) then
			
			// Finsished reload -
			if ( self.Weapon:Clip1() >= self.Primary.ClipSize || self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 ) then
				self.Weapon:SetNetworkedBool( "reloading", false )
				return
			end
			
			// Next cycle
			self.Weapon:SetVar( "reloadtimer", CurTime() + 0.5 )
			self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
			
			// Add ammo
			self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
			self.Weapon:SetClip1(  self.Weapon:Clip1() + 1 )
			
			// Finish filling, final pump
			if (self.Weapon:Clip1() >= self.Primary.ClipSize || self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 ) then
				self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
			else
			
			end
			
		end
	
	end
	
end
