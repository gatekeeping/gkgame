
class GKWeapon : Weapon {
	states {
		AltFire:
			TNT1 A 0 {
				StateLabel current = GKPlayer(self).getCurrentSpell();
				if (!current) {
					return ResolveState("Ready");
				}
				else {
					return ResolveState(current);
				}
			}

		FireSpell:
			TNT1 A 0 {
				A_SpawnProjectile("GemFlameSpawnerNear", 0, 0, random(0,360), CMF_AIMDIRECTION);
				return ResolveState("Ready");
			}
	}
}
