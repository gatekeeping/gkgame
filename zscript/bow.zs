
class Bow : Weapon {
	default {
		Inventory.PickUpMessage "Bow";
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 10;
		Weapon.AmmoType "ArrowAmmo";
		+Weapon.NoAlert;
	}
	states {
		Select:
			DBOW A 1 A_Raise;
			Loop;
		Deselect:
			DBOW A 1 A_Lower;
			Loop;
		Ready:
			DBOW A 1 A_WeaponReady;
			Loop;
		Spawn:
			BWPU A -1;
			Stop;
		Fire:
			DBOW B 6 A_PlayWeaponSound("bow/ready");
			DBOW C 6;
			Goto Hold;
		Hold:
			DBOW D 5;
			TNT1 A 0 A_Refire;
			TNT1 A 0 A_FireCustomMissile("ArrowProj", 0, 1, 5, 0);
			TNT1 A 0 A_PlayWeaponSound("bow/arrow");
			DBOW E 3;
			DBOW FBA 3;
			Goto Ready;
	}
}

class ArrowProj : Actor {
	default {
		Radius 2;
		Height 2;
		Damage 5;
		Speed 72;
		PROJECTILE;
		+THRUGHOST;
		+DONTREFLECT;
		+RIPPER;
		Obituary "%o was perforated by one of %k's arrows";
		Scale 0.8;
	}
	states {
		Spawn:
			ARR0 A 1;
			Loop;
		Death:
			TNT1 A 1;
			Stop;
	}
}

class ArrowAmmo : Ammo {
	default {
		Inventory.PickupMessage "Arrows";
		Inventory.Amount 3;
		Inventory.MaxAmount 50;
		Ammo.BackpackAmount 6;
		Ammo.BackpackMaxAmount 100;
		Inventory.Icon "ARRWIMG";
	}
	states {
		Spawn:
			ARAM A -1;
			Stop;
	}
}

class Quiver : ArrowAmmo {
	default {
		Inventory.PickupMessage "Quiver";
		Inventory.Amount 10;
	}
	states {
		Spawn:
			ARA2 A -1;
			Stop;
	}
}
