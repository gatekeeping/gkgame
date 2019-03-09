
class PoisonGem : Inventory {
	default {
 		Inventory.Amount 1;
 		Inventory.MaxAmount 99;
 		Inventory.PickupSound "gem/get";
 		Inventory.PickupMessage "Poison Gem";
 		Inventory.Icon "IPGMA0";
 		Tag "Poison Gem - Poisonous pools sprout forth from the gem to act as traps.";
 		Scale 0.7;
 		+Inventory.INVBAR;
 		+FLOORCLIP;
	}

	states {
		Spawn:
			POGM A 12;
			TNT1 A 0 A_SpawnItem("GemShine",0,0,0);
			Loop;
		Use:
			TNT1 A 0 A_ThrowGrenade("PoisonGemSet",2,8,3,0);
			Stop;
	}

	override bool use (bool pickup) {
		owner.A_ThrowGrenade("PoisonGemSet", 2, 8, 3, 0);
		return true;
	}
}

class PoisonGemSet : Actor {
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
			POGM A 1 Bright;
			Loop;
		Death:
			POGM A 1 Bright;
			TNT1 A 0 A_SpawnItem("PoisonGemPrepare",0,0,0);
			Stop;
	}
}

class PoisonGemPrepare : Actor {
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
			POGM A 1;
			TNT1 A 0 ThrustThingZ(0,10,0,0);
			TNT1 A 0 A_CountDown;
			Loop;
   		Death:
			TNT1 A 0 A_SpawnItemEx("PoisonGemActive",0,0,0,0,0,0,0,32);
			Stop;
	}
}

class PoisonGemActive : Actor {
	default {
		Radius 3;
		Height 5;
		Speed 0;
		Scale 0.6;
		PROJECTILE;
		Reactiontime 7;
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
			TNT1 A 0;
			TNT1 A 0 A_AlertMonsters;
			POGM A 4;
			TNT1 A 0 A_PlaySound("gem/poison/puff");
			TNT1 AAA 0 A_CustomMissile("GemPoisonMist", random(-2,4), 0, random(0,360), CMF_AIMDIRECTION);
			TNT1 AA 0 A_CustomMissile("GemPoisonCloud", random(0,4), 0, random(0,360), CMF_AIMDIRECTION);
			POGM A 4;
			TNT1 A 0 A_PlaySound("gem/poison/puff");
			TNT1 AAA 0 A_CustomMissile("GemPoisonMist", random(-2,4), 0, random(0,360), CMF_AIMDIRECTION);
			TNT1 AA 0 A_CustomMissile("GemPoisonCloud", random(0,4), 0, random(0,360), CMF_AIMDIRECTION);
			POGM A 4;
			TNT1 A 0 A_PlaySound("gem/poison/puff");
			TNT1 AAA 0 A_CustomMissile("GemPoisonMist", random(-2,4), 0, random(0,360), CMF_AIMDIRECTION);
			TNT1 AA 0 A_CustomMissile("GemPoisonCloud", random(0,4), 0, random(0,360), CMF_AIMDIRECTION);
			POGM A 4;
			TNT1 A 0 A_PlaySound("gem/poison/puff");
			TNT1 AAA 0 A_CustomMissile("GemPoisonMist", random(-2,4), 0, random(0,360), CMF_AIMDIRECTION);
			TNT1 AA 0 A_CustomMissile("GemPoisonCloud", random(0,4), 0, random(0,360), CMF_AIMDIRECTION);
			POGM A 4;
			TNT1 A 0 A_PlaySound("gem/poison/puff");
			TNT1 AAA 0 A_CustomMissile("GemPoisonMist", random(-2,4), 0, random(0,360), CMF_AIMDIRECTION);
			TNT1 AA 0 A_CustomMissile("GemPoisonCloud", random(0,4), 0, random(0,360), CMF_AIMDIRECTION);
			POGM A 4;
			TNT1 AAA 0 A_CustomMissile("GemPoisonMist", random(-2,4), 0, random(0,360), CMF_AIMDIRECTION);
			POGM A 4;
			TNT1 AAA 0 A_CustomMissile("GemPoisonMist", random(-2,4), 0, random(0,360), CMF_AIMDIRECTION);
			POGM A 4;
			TNT1 AAA 0 A_CustomMissile("GemPoisonMist", random(-2,4), 0, random(0,360), CMF_AIMDIRECTION);
			TNT1 A 0 A_PlaySound("gem/poison/burst",5,1.5,0);
			TNT1 AAA 0 A_SpawnItemEx("GemPoisonCloudLaunched",0,0,8,random(-2,2),random(-2,2),random(5,15),random(0,359),32);
			POGM A 4;
			TNT1 AAA 0 A_CustomMissile("GemPoisonMist", random(-2,4), 0, random(0,360), CMF_AIMDIRECTION);
			POGM A 4;
			TNT1 AAA 0 A_CustomMissile("GemPoisonMist", random(-2,4), 0, random(0,360), CMF_AIMDIRECTION);
			POGM A 4;
			TNT1 AAA 0 A_CustomMissile("GemPoisonMist", random(-2,4), 0, random(0,360), CMF_AIMDIRECTION);
			POGM A 4;
			TNT1 AAA 0 A_CustomMissile("GemPoisonMist", random(-2,4), 0, random(0,360), CMF_AIMDIRECTION);
			POGM A 4;
			TNT1 AAA 0 A_CustomMissile("GemPoisonMist", random(-2,4), 0, random(0,360), CMF_AIMDIRECTION);
			POGM A 4;
			TNT1 AAA 0 A_CustomMissile("GemPoisonMist", random(-2,4), 0, random(0,360), CMF_AIMDIRECTION);
			POGM A 4;
			TNT1 AAA 0 A_CustomMissile("GemPoisonMist", random(-2,4), 0, random(0,360), CMF_AIMDIRECTION);
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			TNT1 A 0;
			TNT1 A 0 A_PlaySound("gem/break",5,2,0);
			TNT1 AAAAAA 0 A_SpawnItemEx("GemShardPurple",0,0,3,random(-2,2),random(-2,2),random(3,9),random(0,359),32);
			Stop;
	}
}

class GemPoisonCloud : Actor {
	default {
		Speed 6;
		Damage 3;
		Radius 8;
		Height 5;
		RenderStyle "Add";
		Alpha 0.3;
		Scale 0.8;
		DamageType "Poison";
		PoisonDamage 5,80,10;
		ReactionTime 4;
		PROJECTILE;
		+BRIGHT;
		+FLOATBOB;
		+ADDITIVEPOISONDURATION;
		+DONTBLAST;
	}

	states {
		Spawn:
			POPF A 2 A_SetScale(0.65);
			TNT1 A 0 A_SpawnItem("PoisonMTrailSmall",0,0,0);
			POPF B 2 A_SetScale(0.7);
			POPF C 2 A_SetScale(0.75);
			TNT1 A 0 A_SpawnItem("PoisonMTrailSmall",0,0,0);
			POPF D 2 A_SetScale(0.8);
			POPF A 2 A_SetScale(0.75);
			TNT1 A 0 A_SpawnItem("PoisonMTrailSmall",0,0,0);
			POPF B 2 A_SetScale(0.7);
			POPF C 2 A_SetScale(0.65);
			TNT1 A 0 A_SpawnItem("PoisonMTrailSmall",0,0,0);
			POPF D 2 A_SetScale(0.6);
			TNT1 A 0 A_Jump(60,"Death");
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			TNT1 A 0 A_PlaySound("gem/poison/puddle",5,0.5,0);
			TNT1 A 0 A_SetScale(0.6);
			TNT1 A 0 A_CustomMissile("GemPoisonBubble",0,0,random(0,360),CMF_AIMDIRECTION,random(-2,7));
			TNT1 A 0 A_Jump(80,4);
			TNT1 A 0 A_CustomMissile("GemPoisonBubble",0,0,random(0,360),CMF_AIMDIRECTION,random(-2,7));
			TNT1 A 0 A_Jump(80,2);
			TNT1 A 0 A_CustomMissile("GemPoisonBubble",0,0,random(0,360),CMF_AIMDIRECTION,random(-2,7));
			POPD AB 1;
			POPD C 2;
			POPD DE 1;
			Stop;
	}
}

class GemPoisonCloudLaunched : Actor {
	default {
		Speed 8;
		Damage 2;
		Radius 8;
		Height 5;
		Gravity 0.6	;
		RenderStyle "Add";
		Alpha 0.3;
		Scale 0.8;
		DamageType "Poison";
		PoisonDamage 5,80,10;
		ReactionTime 15;
		PROJECTILE;
		+BRIGHT;
		-NOGRAVITY;
		+BOUNCEONCEILINGS;
		+ADDITIVEPOISONDURATION;
		+DONTBLAST;
		MissileType "PoisonMTrail";
		MissileHeight 8;
	}

	states {
		Spawn:
			POPF A 2 A_SetScale(0.65);
			TNT1 A 0 A_SpawnItem("PoisonMTrail",0,0,0);
			POPF B 2 A_SetScale(0.7);
			POPF C 2 A_SetScale(0.75);
			TNT1 A 0 A_SpawnItem("PoisonMTrail",0,0,0);
			POPF D 2 A_SetScale(0.8);
			POPF A 2 A_SetScale(0.75);
			TNT1 A 0 A_SpawnItem("PoisonMTrail",0,0,0);
			POPF B 2 A_SetScale(0.7);
			POPF C 2 A_SetScale(0.65);
			TNT1 A 0 A_SpawnItem("PoisonMTrail",0,0,0);
			POPF D 2 A_SetScale(0.6);
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			TNT1 A 0 A_SetScale(0.6);
			TNT1 A 0 A_SpawnItem("GemPoisonPuddle",0,0,0);
			POPD AB 1;
			POPD C 2;
			POPD DE 1;
			Stop;
	}
}

class PoisonMTrail : Actor {
	default {
		Speed 1;
		Radius 3;
		Height 3;
		RenderStyle "Add";
		Alpha 0.5;
		Scale 0.8;
		Gravity 0.6;
		PROJECTILE;
		+BRIGHT;
		-NOGRAVITY;
		+THRUACTORS;
		+DONTBLAST;
	}

	states {
		Spawn:
			POPD ABCDE 1;
			Stop;
		Death:
			TNT1 A 0;
			Stop;
	}
}

class PoisonMTrailSmall : Actor {
	default {
		Speed 1;
		Radius 3;
		Height 3;
		RenderStyle "Add";
		Alpha 0.5;
		Scale 0.5;
		Gravity 0.6;
		PROJECTILE;
		+BRIGHT;
		-NOGRAVITY;
		+THRUACTORS;
		+DONTBLAST;
	}

	states {
		Spawn:
			POPD ABCDE 1;
			Stop;
		Death:
			TNT1 A 0;
			Stop;
	}
}

class GemPoisonBubble : Actor {
	default {
		Speed 4;
		Damage 1;
		Radius 8;
		Height 5;
		RenderStyle "Add";
		Alpha 0.4;
		Scale 0.6;
		Gravity 0.3;
		PROJECTILE;
		+BRIGHT;
		-NOGRAVITY;
		+THRUACTORS;
		+DROPOFF;
		+DONTBLAST;
	}

	states {
		Spawn:
			PORB ABCD 1;
			Loop;
		Death:
			TNT1 A 0 A_SpawnItem("GemPoisonPuddle",0,0,0);
			Stop;
	}
}

class GemPoisonPuddle : Actor {
	default {
		Speed 0;
		Damage 1;
		Radius 8;
		Height 5;
		RenderStyle "Add";
		Alpha 0.4;
		Scale 1.2;
		Gravity 0.6;
		DamageType "Poison";
		PoisonDamage 2,30,8;
		ReactionTime 1300;
		PROJECTILE;
		+BRIGHT;
		+MOVEWITHSECTOR;
		+DROPOFF;
		-NOGRAVITY;
		+ADDITIVEPOISONDURATION;
		+DONTBLAST;
	}

	states {
		Spawn:
			PPUD A 1;
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			PPUD A 1 A_SetTranslucent(0.35);
			PPUD A 1 A_SetTranslucent(0.3);
			PPUD A 1 A_SetTranslucent(0.25);
			PPUD A 1 A_SetTranslucent(0.2);
			PPUD A 1 A_SetTranslucent(0.15);
			PPUD A 1 A_SetTranslucent(0.1);
			Stop;
	}
}

class GemPoisonMist : Actor {
	default {
		Speed 3;
		Damage 2;
		Radius 8;
		Height 5;
		RenderStyle "Add";
		Alpha 0.3;
		Scale 0.6;
		DamageType "Poison";
		PoisonDamage 3,90,8;
		ReactionTime 2;
		SeeSound "gem/poison/mist";
		PROJECTILE;
		+BRIGHT;
		+FLOATBOB;
		+ADDITIVEPOISONDURATION;
		+DONTBLAST;
	}

	states {
		Spawn:
			PMST ABCDE 2;
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			PMST A 1 A_SetTranslucent(0.35);
			PMST B 1 A_SetTranslucent(0.3);
			PMST C 1 A_SetTranslucent(0.25);
			PMST D 1 A_SetTranslucent(0.2);
			PMST E 1 A_SetTranslucent(0.15);
			Stop;
	}
}

class GemShardPurple : Actor {
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
			GPSD ABCD 1;
			Loop;
		Death:
			TNT1 A 0;
			Stop;
	}
}