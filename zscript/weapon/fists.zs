
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
			FPCH B 1;
			FPCH C 1;
			FPCH D 1 A_Punch();
			FPCH E 5;
			FPCH D 1;
			FPCH C 1;
			FPCH B 1 A_ReFire("Hold2");
			TNT1 A 0 TakeInventory("StopMoveState", 1);
			Goto Ready;
		Hold2:
			FPCH F 1;
			FPCH G 1;
			FPCH H 1 A_Punch();
			FPCH I 5;
			FPCH H 1;
			FPCH G 1;
			TNT1 A 8;
			TNT1 A 0 A_ReFire("Hold");
			TNT1 A 0 TakeInventory("StopMoveState", 1);
			Goto Ready;
	}

	private action bool TryPunch(double angle, int damage, int power)
	{
		Class<Actor> pufftype;
		FTranslatedLineTarget t;

		double slope = AimLineAttack (angle, 2*DEFMELEERANGE, t, 0., ALF_CHECK3D);
		if (t.linetarget != null)
		{
			if (++weaponspecial >= 3)
			{
				damage <<= 1;
				power *= 3;
				pufftype = "HammerPuff";
			}
			else
			{
				pufftype = "PunchPuff";
			}
			LineAttack (angle, 2*DEFMELEERANGE, slope, damage, 'Melee', pufftype, true, t);
			if (t.linetarget != null)
			{
				// The mass threshold has been changed to CommanderKeen's value which has been used most often for 'unmovable' stuff.
				if (t.linetarget.player != null || 
					(t.linetarget.Mass < 10000000 && (t.linetarget.bIsMonster)))
				{
					if (!t.linetarget.bDontThrust)
						t.linetarget.Thrust(power, t.attackAngleFromSource);
				}
				AdjustPlayerAngle(t);
				return true;
			}
		}
		return false;
	}

	action void A_Punch()
	{
		if (player == null)
		{
			return;
		}

		float vx = cos(self.Angle) * 2.0;
		float vy = sin(self.Angle) * 2.0;
		self.Vel.X = vx;
		self.Vel.Y = vy;

		int damage = random[FighterAtk](40, 55);
		for (int i = 0; i < 16; i++)
		{
			if (TryPunch(angle + i*(45./16), damage, 2) ||
				TryPunch(angle - i*(45./16), damage, 2))
			{ // hit something
				if (weaponspecial >= 3)
				{
					weaponspecial = 0;
				}
				return;
			}
		}
		// didn't find any creatures, so try to strike any walls
		weaponspecial = 0;

		double slope = AimLineAttack (angle, DEFMELEERANGE, null, 0., ALF_CHECK3D);
		LineAttack (angle, DEFMELEERANGE, slope, damage, 'Melee', "PunchPuff", true);
	}

}
