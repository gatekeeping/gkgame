
class WaterGem : Inventory {
	default {
		Inventory.Amount 1;
		Inventory.MaxAmount 99;
		Inventory.PickupSound "gem/get";
		Inventory.PickupMessage "Water Gem";
		Inventory.Icon "IWAGA0";
		Tag "Water Gem - Summons droplets of water to damage enemies and heal allies.";
		Scale 0.7;
		+Inventory.INVBAR;
		+FLOORCLIP;
	}

	states {
		Spawn:
			WAGM A 12;
			TNT1 A 0 A_SpawnItem("GemShine",0,0,0);
			Loop;
	}

	override bool use (bool pickup) {
		if (TexMan.GetName(owner.ceilingpic) == "F_SKY") {
			owner.A_ThrowGrenade("WaterGemSet", 2, 8, 3, 0);
			return true;
		}
		return false;
	}
}

class WaterGemSet : Actor {
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
    		WAGM A 1 Bright;
			Loop;
		Death:
      		WAGM A 1 Bright;
			TNT1 A 0 A_SpawnItem("WaterGemPrepare",0,0,0);
      		Stop;
	}
}

class WaterGemPrepare : Actor {
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
			WAGM A 1;
			TNT1 A 0 ThrustThingZ(0,10,0,0);
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			TNT1 A 0 A_SpawnItemEx("WaterGemActive",0,0,0,0,0,0,0,32);
			Stop;
	}
}

class WaterGemActive : Actor {
	default {
		Radius 3;
		Height 5;
		Speed 0;
		Scale 0.6;
		PROJECTILE;
		Reactiontime 24;
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
			TNT1 A 0 A_CustomMissile("WaterDropSpawnerNear", 0, 0, random(0,360), CMF_AIMDIRECTION);
			TNT1 A 0 A_CustomMissile("WaterDropSpawnerFar", 0, 0, random(0,360), CMF_AIMDIRECTION);
			TNT1 A 0 A_CustomMissile("RainFXSpawnerA", 0, 0, random(0,360), CMF_AIMDIRECTION);
			TNT1 A 0 A_CustomMissile("RainFXSpawnerB", 0, 0, random(0,360), CMF_AIMDIRECTION);
			TNT1 A 0 A_CustomMissile("RainFXSpawnerC", 0, 0, random(0,360), CMF_AIMDIRECTION);
			WAGM A 12;
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			TNT1 A 0;
			TNT1 A 0 A_PlaySound("gem/break",5,2,0);
			TNT1 AAAAAA 0 A_SpawnItemEx("GemShardBlue",0,0,3,random(-2,2),random(-2,2),random(3,9),random(0,359),32);
			Stop;
	}
}

class WaterDropSpawnerNear : Actor {
	default {
		Speed 2;
		Radius 8;
		Height 5;
		PROJECTILE;
		+BRIGHT;
		+MOVEWITHSECTOR;
		+THRUACTORS;
		+CEILINGHUGGER;
		+DONTBLAST;
		ReactionTime 2;
	}

	states {
		Spawn:
			TNT1 A 5	;
			TNT1 A 0 A_Jump(20,2);
			TNT1 A 0 A_SpawnItemEx("GemWater",0,0,0);
			TNT1 A 0 A_Countdown;
			Loop;
		Death:
			TNT1 A 0;
			Stop;
	}
}

class WaterDropSpawnerFar : Actor {
	default {
		Speed 6;
		Radius 8;
		Height 5;
		PROJECTILE;
		+BRIGHT;
		+MOVEWITHSECTOR;
		+THRUACTORS;
		+CEILINGHUGGER;
		+DONTBLAST;
		ReactionTime 2;
	}

	states {
		Spawn:
			TNT1 A 5	;
			TNT1 A 0 A_Jump(20,2);
			TNT1 A 0 A_SpawnItemEx("GemWater",0,0,0);
			TNT1 A 0 A_Countdown;
			Loop;
		Death:
      		TNT1 A 0;
      		Stop;
	}
}

class RainFXSpawnerA : Actor {
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
		+CEILINGHUGGER;
		+DONTBLAST;
	}

	states {
		Spawn:
			TNT1 A 1;
			TNT1 A 0 A_Jump(30,"SpawnRain");
			TNT1 A 1;
			TNT1 A 0 A_Jump(50,"SpawnRain");
			TNT1 A 1;
			TNT1 A 0 A_Jump(80,"SpawnRain");
			TNT1 A 1;
			TNT1 A 0 A_Jump(120,"SpawnRain");
			TNT1 A 1;
			TNT1 A 0 A_Jump(160,"SpawnRain");
			TNT1 A 1;
			TNT1 A 0 A_Jump(190,"SpawnRain");
			Stop;
		SpawnRain:
			TNT1 A 0 A_SpawnItem("RainFX",0,0,0);
			Stop;
		Death:
      		TNT1 A 0;
      		Stop;
	}
}

class RainFXSpawnerB : Actor {
	default {
		Speed 4;
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
		+CEILINGHUGGER;
		+DONTBLAST;
	}

	states {
		Spawn:
			TNT1 AAAAA 1;
			TNT1 A 0 A_Jump(120,"SpawnRain");
			TNT1 A 0 A_Countdown;
			Loop;
		SpawnRain:
			TNT1 A 0 A_SpawnItem("RainFX",0,0,0);
			Stop;
		Death:
			TNT1 A 0;
			Stop;
	}
}

class RainFXSpawnerC : Actor {
	default {
		Speed 8;
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
		+CEILINGHUGGER;
		+DONTBLAST;
	}

	states {
		Spawn:
			TNT1 AAAAAAA 1;
			TNT1 A 0 A_Jump(120,"SpawnRain");
			TNT1 A 0 A_Countdown;
			Loop;
		SpawnRain:
			TNT1 A 0 A_SpawnItem("RainFX",0,0,0);
			Stop;
		Death:
			TNT1 A 0;
			Stop;
	}
}

class RainFX : Actor {
	default {
		Speed 18;
		Radius 3;
		Height 3;
		Scale 0.5;
		RenderStyle "Add";
		Alpha 0.3;
		Gravity 0.6;
		PROJECTILE;
		+BRIGHT;
		+THRUACTORS;
		-NOGRAVITY;
		+DONTBLAST;
	}

	states {
		Spawn:
			WDRP B 1;
			Loop;
		Death:
			TNT1 A 0;
			TNT1 A 0 A_PlaySound("gem/water",5,1.5,0);
			Stop;
	}
}

class GemWater : Actor {
	default {
		Speed 14;
		DamageFunction (2*random(3,6));
		Radius 8;
		Height 5;
		Gravity 0.6;
		RenderStyle "Add";
		Alpha 0.3;
		Scale 0.6;
		PROJECTILE;
		+BRIGHT;
		-NOGRAVITY;
		+DONTBLAST;
	}

	states {
		Spawn:
			WDRP A 1;
			Loop;
		Death:
			TNT1 A 0;
			TNT1 A 0 A_PlaySound("gem/water",5,1.5,0)	;
			TNT1 A 0 A_Explode(1,12,0,1,12);
			TNT1 A 0 A_Jump(120,2); //Chance to jump past the healing so as not to be too overpowered.;
			TNT1 A 0 A_RadiusGive("Health",80,RGF_PLAYERS,1);
		EndWave:
	  		TNT1 A 0;
      		Stop;
      		
	}
}

class GemWaterWave : Actor {
	default {
		Speed 8;
		Radius 8;
		Height 5;
		RenderStyle "Add";
		Alpha 0.2;
		Scale 0.2;
		PROJECTILE;
		+BRIGHT;
		+THRUACTORS;
		+MOVEWITHSECTOR;
		+DONTBLAST;
	}

	states {
		Spawn:
			WTFX AAA 1;
			TNT1 A 0 A_SetTranslucent(0.1);
			WTFX AA 2 A_SetScale(0.2);
			WTFX A 1 A_SetScale(0.1);
		Death:
			TNT1 A 0;
			Stop;
	}
}

class GemShardBlue : Actor {
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
			GBSD ABCD 1;
			Loop;
 		Death:
			TNT1 A 0;
			Stop;
	}
}