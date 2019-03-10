
class Battleaxe : GKWeapon {

	default {
		Weapon.SlotNumber 1;
		+WEAPON.MELEEWEAPON;
		Weapon.KickBack 150;
		Inventory.PickupMessage "$TXT_WEAPON_F2";
		Obituary "$OB_MPFWEAPAXE";
		Tag "$TAG_FWEAPAXE";
	}

	states {
		Spawn:
			WFAX A -1;
			Stop;
		Select:
			FAXE A 1 A_Raise;
			Loop;
		Deselect:
			FAXE A 1 A_Lower;
			Loop;
		Ready:
			FAXE A 1 A_WeaponReady;
			Loop;
		Fire:
			TNT1 A 8 GiveInventory("StopMoveState", 1);
			FAXE B 2 A_PlaySound("hatchet/swing", CHAN_WEAPON);
			FAXE C 2;
			FAXE D 2 A_CustomPunch(175, 1, 0);
			FAXE E 2;
			TNT1 A 8 TakeInventory("StopMoveState", 1);
			Goto Ready;
	}
}