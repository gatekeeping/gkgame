
class Fists : GKWeapon {

	default {
		+BLOODSPLATTER;
		+WEAPON.MELEEWEAPON;
		Weapon.KickBack 150;
		Weapon.SlotNumber 1;
		Obituary "$OB_MPFWEAPFIST";
		Tag "$TAG_FWEAPFIST";
	}

	states
	{
		Select:
			FPCH A 1 A_Raise;
			Loop;
		Deselect:
			FPCH A 1 A_Lower;
			Loop;
		Ready:
			FPCH A 1 A_WeaponReady;
			Loop;
		Fire:
			TNT1 A 0 GiveInventory("StopMoveState", 1);
			TNT1 A 8;
			Goto Hold;
		Hold:
			FPCH B 3;
			FPCH C 3;
			FPCH D 3 A_CustomPunch(75, 1, 0, "", 96);
			FPCH E 3;
			FPCH D 3;
			FPCH C 3;
			FPCH B 3 A_ReFire("Hold2");
			TNT1 A 0 TakeInventory("StopMoveState", 1);
			Goto Ready;
		Hold2:
			FPCH F 3;
			FPCH G 3;
			FPCH H 3 A_CustomPunch(75, 1, 0, "", 96);
			FPCH I 3;
			FPCH H 3;
			FPCH G 3;
			FPCH F 3 A_ReFire("Hold");
			TNT1 A 0 TakeInventory("StopMoveState", 1);
			Goto Ready;
	}

}