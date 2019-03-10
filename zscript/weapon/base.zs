
class GKWeapon : Weapon {
	states {
		AltFire:
			TNT1 A 0 {
				Inventory timedOut = self.FindInventory("Timeout", true);
				GKSpell current = GKPlayer(self).getCurrentSpell();

				// If there is no current spell or a timeout is active
				if (!current || timedOut) {
					return ResolveState("Ready");
				}
				else {
					// Check if player has enough getMana
					int mana = self.CountInv("Mana1");
					if(mana >= current.getManaCost()) {
						self.TakeInventory("Mana1", current.getManaCost());
						return ResolveState(current.getLabel());
					}
					return ResolveState("Ready");
				}
			}

		FireTrail:
			TNT1 A 1 {
				A_SpawnProjectile("GemFlameSpawnerFar", 0, 0, random(0,360), CMF_AIMDIRECTION);
				A_SpawnProjectile("GemFlameSpawnerFar", 0, 0, random(0,360), CMF_AIMDIRECTION);
				A_SpawnProjectile("GemFlameSpawnerFar", 0, 0, random(0,360), CMF_AIMDIRECTION);
				A_SpawnProjectile("GemFlameSpawnerFar", 0, 0, random(0,360), CMF_AIMDIRECTION);
				A_SpawnProjectile("GemFlameSpawnerFar", 0, 0, random(0,360), CMF_AIMDIRECTION);
				A_SpawnProjectile("GemFlameSpawnerFar", 0, 0, random(0,360), CMF_AIMDIRECTION);
				A_SpawnProjectile("GemFlameSpawnerFar", 0, 0, random(0,360), CMF_AIMDIRECTION);
				A_SpawnProjectile("GemFlameSpawnerFar", 0, 0, random(0,360), CMF_AIMDIRECTION);
				A_SpawnProjectile("GemFlameSpawnerFar", 0, 0, random(0,360), CMF_AIMDIRECTION);
				A_SpawnProjectile("GemFlameSpawnerFar", 0, 0, random(0,360), CMF_AIMDIRECTION);
				A_SpawnProjectile("GemFlameSpawnerFar", 0, 0, random(0,360), CMF_AIMDIRECTION);
				A_SpawnProjectile("GemFlameSpawnerFar", 0, 0, random(0,360), CMF_AIMDIRECTION);
				GiveInventory("FireTrailTimeout", 1);
				return ResolveState("Ready");
			}

	}
}
