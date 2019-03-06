
class Pole : Weapon {

	default {
		+Weapon.MELEEWEAPON;
		+Weapon.NoAlert;
		Weapon.SlotNumber 1;
		Obituary "Pole";
		Tag "Pole";
	}

	states {
		Ready:
			STFF A 1 A_WeaponReady;
			Loop;
		Deselect:
			STFF A 1 A_Lower;
			Loop;
		Select:
			STFF A 1 A_Raise;
			Loop;
		Fire:
			TNT1 A 0 GiveInventory("StopMoveState", 1);
			STFF D 4;
			TNT1 A 4;
			STFF D 3 A_PlaySound("hatchet/swing", CHAN_WEAPON);
			STFF B 3;
			STFF C 3 A_CustomPunch(20+random(4, 16), 1, 0, "", 96);
			STFF B 3 A_ReFire;
			TNT1 A 0 TakeInventory("StopMoveState", 1);
			Goto Ready;
	}

}