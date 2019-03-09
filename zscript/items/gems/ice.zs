
class IceGem : Inventory {
	default {
		Inventory.Amount 1;
		Inventory.MaxAmount 99;
		Inventory.PickupSound "gem/get";
		Inventory.PickupMessage "Ice Gem";
		Inventory.Icon "IIGMA0";
		Tag "Ice Gem - Freezes enemies with shards of ice.";
		Scale 0.7;
		+Inventory.INVBAR;
		+FLOORCLIP;
	}

	states {
		Spawn:
			IGEM A 12;
			TNT1 A 0 A_SpawnItem("GemShine",0,0,0);
			Loop;
	}

	override bool use (bool pickup) {
		owner.A_ThrowGrenade("IceGemSet", 2, 8, 3, 0);
		return true;
	}
}

class IceGemSet : Actor {
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
			IGEM A 1 Bright;
			Loop;
		Death:
			IGEM A 1 Bright;
			TNT1 A 0 A_SpawnItem("IceGemPrepare",0,0,0);
			Stop;
	}
}

class IceGemPrepare : Actor {
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
			IGEM A 1;
			TNT1 A 0 ThrustThingZ(0,10,0,0);
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			TNT1 A 0 A_SpawnItemEx("IceGemActive",0,0,0,0,0,0,0,32);
			Stop;
	}
}

class IceGemActive : Actor {
	default {
		Radius 3;
		Height 5;
		Speed 0;
		Scale 0.5;
		PROJECTILE;
		Reactiontime 50;
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
			TNT1 A 0 A_SpawnItemEx("IceStarFX",0,0,4);
			TNT1 A 0 A_AlertMonsters;
			TNT1 A 0 A_PlaySound("gem/ice/shard");
			TNT1 AAA 0 A_CustomMissile("IceShardMissile", 3, 0, random(0,360), CMF_AIMDIRECTION, random(-5,18));
			IGEM A 2;
			TNT1 A 0 A_PlaySound("gem/ice/shard");
			TNT1 AAA 0 A_CustomMissile("IceShardMissile", 3, 0, random(0,360), CMF_AIMDIRECTION, random(-5,18));
			IGEM A 2;
			TNT1 A 0 A_PlaySound("gem/ice/shard");
			TNT1 AAA 0 A_CustomMissile("IceShardMissile", 3, 0, random(0,360), CMF_AIMDIRECTION, random(-5,18));
			IGEM A 2;
			TNT1 A 0 A_PlaySound("gem/ice/shard");
			TNT1 AAA 0 A_CustomMissile("IceShardMissile", 3, 0, random(0,360), CMF_AIMDIRECTION, random(-5,18));
			IGEM A 2;
			TNT1 A 0 A_PlaySound("gem/ice/shard");
			TNT1 AAA 0 A_CustomMissile("IceShardMissile", 3, 0, random(0,360), CMF_AIMDIRECTION, random(-5,18));
			IGEM A 2;
			TNT1 A 0 A_CountDown;
			Goto Spawn+2;
		Death:
			TNT1 A 0;
			TNT1 A 0 A_PlaySound("gem/break",5,2,0);
			TNT1 AAAAAA 0 A_SpawnItemEx("GemShardLightBlue",0,0,3,random(-2,2),random(-2,2),random(3,9),random(0,359),32);
			Stop;
	}
}

class IceStarFX : Actor {
	default {
		Radius 10;
		Height 6;
		Speed 0;
		Alpha 0.6;
		Scale 0.5;
		RenderStyle "Add";
		PROJECTILE;
		Reactiontime 45;
		+THRUACTORS;
		+BRIGHT;
		+NOCLIP;
		+DONTBLAST;
	}

   states
   {
		Spawn: 
			ISTR A 1 A_SetTranslucent(0.55);
			ISTR A 1 A_SetTranslucent(0.5);
			ISTR A 1 A_SetTranslucent(0.45);
			ISTR A 1 A_SetTranslucent(0.4);
			ISTR A 1 A_SetTranslucent(0.35);
			ISTR A 1 A_SetTranslucent(0.3);
			ISTR A 1 A_SetTranslucent(0.35);
			ISTR A 1 A_SetTranslucent(0.4);
			ISTR A 1 A_SetTranslucent(0.45);
			ISTR A 1 A_SetTranslucent(0.5);
			ISTR A 1 A_SetTranslucent(0.55);
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			ISTR A 1 A_SetTranslucent(0.5);
			ISTR A 1 A_SetTranslucent(0.45);
			ISTR A 1 A_SetTranslucent(0.4);
			ISTR A 1 A_SetTranslucent(0.35);
			ISTR A 1 A_SetTranslucent(0.3);
			ISTR A 1 A_SetTranslucent(0.25);
			ISTR A 1 A_SetTranslucent(0.2);
			ISTR A 1 A_SetTranslucent(0.15);
			ISTR A 1 A_SetTranslucent(0.10);
			Stop;
	} 
}

class IceShardMissile : Actor {
	default {
		Speed 12;
		Damage 2;
		Radius 8;
		Height 5;
		RenderStyle "Add";
		Alpha 0.6;
		Scale 0.5;
		DamageType "Ice";
		PROJECTILE;
		+BRIGHT;
		+DONTBLAST;
		+FORCERADIUSDMG;
	}

	states {
		Spawn:
			ICRD A 1;
			Loop;
		Death:
			TNT1 A 0;
			TNT1 A 0 A_PlaySound("gem/ice/impact");
			TNT1 A 0 A_Jump(125,2);
			TNT1 A 0 A_SpawnItem("IceShardBreaker",0,0,0);
			TNT1 AAA 0 A_SpawnItemEx("IceShardDebris",0,0,3,random(-2,2),random(-2,2),random(3,9),random(0,359),32);
			Stop;
	}
}

class IceShardBreaker : Actor {
	default {
		Speed 2;
		Damage 1;
		Radius 10;
		Height 10;
		PROJECTILE;
		+NOEXTREMEDEATH;
		+DONTBLAST;
		+STRIFEDAMAGE;
	}

	states {
		Spawn:
			TNT1 A 1;
			Stop;
    	Death:
    		TNT1 A 0;
    		Stop;
	}
}

class IceShardDebris : Actor {
	default {
		Speed 8;
		Radius 2;
		Height 2;
		Scale 0.2;
		Gravity 0.6;
		PROJECTILE;
		+BRIGHT;
		-NOGRAVITY;
		+DONTSPLASH;
		+DONTBLAST;
	}

	states {
		Spawn:
			ICHN A 1;  
			Loop;
		Death:
			TNT1 A 0;
			Stop;
	}
}

class GemShardLightBlue : Actor {
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
			GISD ABCD 1;
			Loop;
		Death:
			TNT1 A 0;
			Stop;
	}
}