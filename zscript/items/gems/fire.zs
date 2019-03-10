
class FireGem : Inventory {
	default {
		Inventory.Amount 1;
		Inventory.MaxAmount 99;
		Inventory.PickupSound "gem/get";
		Inventory.PickupMessage "Fire Gem";
		Inventory.Icon "IFGMA0";
		Tag "Fire Gem";
		Scale 0.7;
		+Inventory.INVBAR;
		+FLOORCLIP;
	}

	states {
		Spawn:
			FGEM A 1;
			TNT1 A 0 A_SpawnItem("GemShine", 0, 0, 0);
			Loop;
	}

	override bool use (bool pickup) {
		owner.A_ThrowGrenade("FireGemSet", 2, 8, 3, 0);
		return true;
	}
}

class FireGemSet : Actor {
	default {
		Radius 3;
		Height 5;
		Speed 22;
		Scale 0.6;
		+MISSILE;
		+DROPOFF;
		+CANBOUNCEWATER;
		+BOUNCEONWALLS;
		+THRUACTORS;
		+DONTBLAST;
		BounceType "Doom";
		BounceCount 4;
		WallBounceFactor 1.5;
		BounceFactor 0.25;
		BounceSound "gem/bounce";
	}

	states {
		Spawn:
			FGEM A 1 Bright;
			Loop;
		Death:
			FGEM A 1 Bright;
			TNT1 A 0 A_SpawnItem("FireGemPrepare", 0, 0, 0);
			Stop;
	}
}

class FireGemPrepare : Actor {
	default {
		Radius 3;
		Height 5;
		Speed 0;
		Reactiontime 12;
		Scale 0.6;
		PROJECTILE;
		+BRIGHT;
		+THRUACTORS;
		+NOTARGET;
		+DONTBLAST;
	}

	states {
		Spawn:
			FGEM A 1;
			TNT1 A 0 ThrustThingZ(0, 10, 0, 0);
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			TNT1 A 0 A_SpawnItemEx("FireGemActive", 0, 0, 0, 0, 0, 0, 0, 32);
			Stop;
	}
}

class FireGemActive : Actor {
	default {
		Radius 3;
		Height 5;
		Speed 0;
		Scale 0.6;
		PROJECTILE;
		Reactiontime 75;
		RenderStyle "Add";
		Alpha 1;
		+THRUACTORS;
		-SHOOTABLE;
		+BRIGHT;
		+VISIBILITYPULSE;
		+DONTBLAST;
	}

	states {
		Spawn:  
			TNT1 A 0 A_AlertMonsters;
			FGEM A 1;
			TNT1 A 0 A_SpawnProjectile("GemFlameSpawnerNear", 0, 0, random(0,360), CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("GemFlameSpawnerFar", 0, 0, random(0,360), CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("GemFlameSpawnerFurthest", 0, 0, random(0,360), CMF_AIMDIRECTION);
			FGEM A 5;
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			TNT1 A 0;
			TNT1 A 0 A_PlaySound("gem/break", 5, 2, 0);
			TNT1 AAAAAA 0 A_SpawnItemEx("GemShardRed",0,0,3,random(-2,2),random(-2,2),random(3,9),random(0,359),32);
			Stop;
	}
}

class GemFlameSpawnerNear : Actor {
	default {
		Speed 4;
		Radius 3;
		Height 3;
		RenderStyle "Add";
		Alpha 0.4;
		Scale 0.3;
		PROJECTILE;
		+BRIGHT;
		+THRUACTORS;
		+MOVEWITHSECTOR;
		+FLOORHUGGER;
		+DONTBLAST;
	}

	states {
		Spawn:
			TNT1 A 1;
			TNT1 A 0 A_Jump(30,"SpawnFlame");
			TNT1 A 1;
			TNT1 A 0 A_Jump(50,"SpawnFlame");
			TNT1 A 1;
			TNT1 A 0 A_Jump(80,"SpawnFlame");
			TNT1 A 1;
			TNT1 A 0 A_Jump(120,"SpawnFlame");
			TNT1 A 1;
			TNT1 A 0 A_Jump(160,"SpawnFlame");
			TNT1 A 1;
			TNT1 A 0 A_Jump(190,"SpawnFlame");
			Stop;
		SpawnFlame:
			TNT1 A 0 A_SpawnItem("FireGemFlame",0,0,0);
			Stop;
		Death:
			TNT1 A 0;
			Stop;
	}
}

class GemFlameSpawnerFar : Actor {
	default {
		Speed 7;
		Radius 3;
		Height 3;
		RenderStyle "Add";
		Alpha 0.4;
		Scale 0.3;
		ReactionTime 4;
		PROJECTILE;
		+BRIGHT;
		+THRUACTORS;
		+MOVEWITHSECTOR;
		+FLOORHUGGER;
		+DONTBLAST;
	}

	states {
		Spawn:
			TNT1 AAAAA 1;
			TNT1 A 0 A_Jump(120,"SpawnFlame");
			TNT1 A 0 A_Countdown;
			Loop;
		SpawnFlame:
			TNT1 A 0 A_SpawnItem("FireGemFlame",0,0,0);
			Stop;
		Death:
			TNT1 A 0;
			Stop;
	}
}

class GemFlameSpawnerFurthest : Actor {
	default {
		Speed 10;
		Radius 3;
		Height 3;
		RenderStyle "Add";
		Alpha 0.4;
		Scale 0.3;
		ReactionTime 4;
		PROJECTILE;
		+BRIGHT;
		+THRUACTORS;
		+MOVEWITHSECTOR;
		+FLOORHUGGER;
		+DONTBLAST;
	}

	states {
		Spawn:
			TNT1 AAAAAAA 1;
			TNT1 A 0 A_Jump(120,"SpawnFlame");
			TNT1 A 0 A_Countdown;
			Loop;
		SpawnFlame:
			TNT1 A 0 A_SpawnItem("FireGemFlame",0,0,0);
			Stop;
		Death:
			TNT1 A 0;
			Stop;
	}
}

class FireGemFlame : Actor {
	default {
		Radius 12;
		Height 8;
		Speed 0;
		Scale 0.7;
		RenderStyle "Add";
		Alpha 0.6;
		PROJECTILE;
		+THRUACTORS;
		+RANDOMIZE;
		+DONTBLAST;
		+BRIGHT;
		DeathSound "gem/flame";
	}

	states {
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Jump(255,"Normal","Small");
			Loop;
		Normal:
			TNT1 A 0 A_PlaySound("gem/flame",5,2,0);
			FFIR A 1;
			TNT1 A 0 A_SpawnItem("FlameGemFDMG",0,25,0);
			FFIR B 1;
			TNT1 A 0 A_SpawnItem("FlameGemFDMG",0,25,0);
			FFIR C 1;
			TNT1 A 0 A_SpawnItem("FlameGemFDMG",0,25,0);
			FFIR D 1;
			TNT1 A 0 A_SpawnItem("FlameGemFDMG",0,25,0);
			FFIR E 1;
			TNT1 A 0 A_SpawnItem("FlameGemFDMG",0,25,0);
			FFIR F 1;
			TNT1 A 0 A_SpawnItem("FlameGemFDMG",0,25,0);
			FFIR G 1;
			TNT1 A 0 A_SpawnItem("FlameGemFDMG",0,25,0);
			FFIR H 1;
			TNT1 A 0 A_SpawnItem("FlameGemFDMG",0,25,0);
		Small:
			TNT1 A 0 A_SetScale(0.4);
			TNT1 A 0 A_PlaySound("gem/flame",5,2,0);
			FFIR A 1;
			TNT1 A 0 A_SpawnItem("FlameGemFDMG",0,20,0);
			FFIR B 1;
			TNT1 A 0 A_SpawnItem("FlameGemFDMG",0,20,0);
			FFIR C 1;
			TNT1 A 0 A_SpawnItem("FlameGemFDMG",0,20,0);
			FFIR D 1;
			TNT1 A 0 A_SpawnItem("FlameGemFDMG",0,20,0);
			FFIR E 1;
			TNT1 A 0 A_SpawnItem("FlameGemFDMG",0,20,0);
			FFIR F 1;
			TNT1 A 0 A_SpawnItem("FlameGemFDMG",0,20,0);
			FFIR G 1;
			TNT1 A 0 A_SpawnItem("FlameGemFDMG",0,20,0);
			FFIR H 1;
			TNT1 A 0 A_SpawnItem("FlameGemFDMG",0,20,0);
			Stop;
		Death:
			TNT1 A 0;
			Stop;
	}
}

class FlameGemFDMG : Actor {
	default {
		Radius 12;
		Height 15;
		DamageFunction (1*random(2,6));
		PROJECTILE;
		+NOEXTREMEDEATH;
		+DONTBLAST;
		DamageType "Fire";
	}

	states {
		Spawn:
	    	TNT1 A 1;
			Stop;
	}
}

class GemShardRed : Actor {
	default {
		Radius 1;
		Height 1;
		Speed 15;
		PROJECTILE;
		-NOGRAVITY;
		+THRUACTORS;
		Gravity 0.6;
		RenderStyle "Add";
		Alpha 0.8;
		Scale 0.4;
	}

	states {
		Spawn:
			GRSD ABCD 1;
			Loop;
		Death:
			TNT1 A 0;
			Stop;
	}
}