
class Bow : GKWeapon {
	default {
		Inventory.PickUpMessage "Bow";
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 10;
		Weapon.AmmoType "ArrowAmmo";
		Weapon.SlotNumber 1;
		+Weapon.NoAlert;
		+Weapon.NoAutoFire;
	}

	states {
		Select:
			TNT1 A 0 A_NoArrows("SelectNoAmmo");
			DBOW A 1 A_Raise;
			Loop;
		SelectNoAmmo:
			DBOW G 1 A_Raise;
			Loop;
		Deselect:
			TNT1 A 0 {
				TakeInventory("ReadyShot", 1);
				TakeInventory("StopMoveState", 1);
			}
			TNT1 A 0 A_NoArrows("DeselectNoAmmo");
			DBOW A 1 A_Lower;
			Loop;
		DeselectNoAmmo:
			DBOW G 1 A_Lower;
			Loop;
		Ready:
			TNT1 A 0 A_NoArrows("ReadyNoAmmo");
			TNT1 A 0 A_JumpIfInventory("ReadyShot", 1, "ReadyShot");
			DBOW A 1 A_WeaponReady;
			Loop;
		ReadyNoAmmo:
			DBOW G 1 A_WeaponReady;
			Goto Ready;
		ReadyShot:
			DBOW D 1 A_WeaponReady;
			Goto Ready;
		Spawn:
			BWPU A -1;
			Stop;
		Fire:
			TNT1 A 0 A_JumpIfInventory("ReadyShot", 1, "ReadyFire");
			Goto Ready;
		ReadyFire:
			TNT1 A 0 {
				A_FireCustomMissile("ArrowProj", 0, 1, 5, 0);
				self.TakeInventory("StopMoveState", 1);
				A_PlayWeaponSound("bow/arrow");
				A_AlertMonsters();
			}
			DBOW EF 3;
			TNT1 A 0 TakeInventory("ReadyShot", 1);
			TNT1 A 0 A_NoArrows("Ready");
			DBOW BA 3;
			Goto Ready;
		AltFire:
			TNT1 A 0 A_NoArrows("Ready");
			TNT1 A 0 A_JumpIfInventory("ReadyShot", 1, "CancelShot");
			TNT1 A 0 GiveInventory("StopMoveState", 1);
			DBOW B 6 A_PlayWeaponSound("bow/ready");
			DBOW C 6;
			DBOW D 5 GiveInventory("ReadyShot", 1);
			Goto Ready;
		CancelShot:
			TNT1 A 0 {
				TakeInventory("ReadyShot", 1);
				TakeInventory("StopMoveState", 1);
			}
			DBOW CBA 3;
			Goto Ready;
	}

	action state A_NoArrows(statelabel label) {
		if(self.CountInv("ArrowAmmo")) {
			return null;
		}
		return ResolveState(label);
	}
}

class ReadyShot : Inventory {
	default { Inventory.MaxAmount 1; }
}

class ArrowProj : Actor {
	default {
		Radius 2;
		Height 2;
		DamageFunction 90;
		Speed 100;
		PROJECTILE;
		+THRUGHOST;
		+DONTREFLECT;
		Obituary "%o was perforated by one of %k's arrows";
		Scale 2.2;
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
		Inventory.MaxAmount 99;
		Ammo.BackpackAmount 6;
		Ammo.BackpackMaxAmount 99;
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
