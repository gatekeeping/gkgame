
class Hatchet : Weapon {
	default {
		+Weapon.MeleeWeapon;
		+Weapon.NoAlert;
		Inventory.Icon "AXEPA0";
		Inventory.PickupMessage "Hatchet";
		Weapon.SlotNumber 1;
		Tag "Hatchet";
		Obituary "%o killed with the Hatchet";
	}
	states {
		Spawn:
			AXEP A -1;
			Stop;
		Select:
			AXEG A 1 A_Raise;
			Goto Ready;
		Deselect:
			AXEG A 1 A_Lower;
			Wait;
		Ready:
			AXEG A 1 A_WeaponReady;
			Loop;
		Fire:
			TNT1 A 0 GiveInventory("StopMoveState", 1);
			AXEG ABCDE 2;
			TNT1 A 8;
			AXEG H 2 A_PlaySound("hatchet/swing", CHAN_WEAPON);
			AXEG I 2;
			AXEG J 2 A_CustomPunch(175, 1, 0);
			AXEG K 2;
			TNT1 A 8 TakeInventory("StopMoveState", 1);
			AXEG EDCB 2;
			Goto Ready;
	}
}