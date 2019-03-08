
class EarthGem : Inventory {
	default {
		Inventory.Amount 1;
		Inventory.MaxAmount 99;
		Inventory.PickupSound "gem/get";
		Inventory.PickupMessage "Earth Gem";
		Inventory.Icon "IEGMA0";
		Tag "Earth Gem - Launches boulders at foes.";
		Scale 0.7;
		+Inventory.INVBAR;
		+FLOORCLIP;
	}

	states {
		Spawn:
			EGEM A 1;
			TNT1 A 0 A_SpawnItem("GemShine");
			Loop;
	}

	override bool use (bool pickup) {
		owner.A_ThrowGrenade("EarthGemSet", 2, 8, 3, 0);
		return true;
	}
}

class EarthGemSet : Actor {
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
			EGEM A 1 Bright;
			Loop;
		Death:
			EGEM A 1 Bright;
			TNT1 A 0 A_SpawnItem("EarthGemPrepare", 0, 0, 0);
			Stop;
	}
}

class EarthGemPrepare : Actor {
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
			EGEM A 1;
			TNT1 A 0 ThrustThingZ(0,10,0,0);
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			TNT1 A 0 A_SpawnItemEx("EarthGemActive",0,0,0,0,0,0,0,32);
			Stop;
	}
}

class EarthGemActive : Actor {
	default {
		Radius 3;
		Height 5;
		Speed 0;
		Scale 0.6;
		PROJECTILE;
		Reactiontime 35;
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
			EGEM A 1;
			TNT1 A 0 A_PlaySound("gem/rumble",5,3,1);
			TNT1 AA 0 A_SpawnItemEx("GemBoulder",0,0,0,random(-2,2),random(-2,2),random(3,9),random(0,359),32);
			TNT1 A 0 A_SpawnItemEx("GemBoulder",0,0,0,random(-2,2),random(-2,2),random(3,9),random(0,359),32);
			EGEM A 20;
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			TNT1 A 0;
			TNT1 A 0 A_PlaySound("gem/break",5,2,0);
			TNT1 AAAAAA 0 A_SpawnItemEx("GemShardBrown",0,0,3,random(-2,2),random(-2,2),random(3,9),random(0,359),32);
			Stop;
	}
}

class GemBoulder : Actor {
	default {
		DamageFunction (4*random(3,6));
		Speed 5;
		Radius 10;
		Height 6;
		Gravity 0.7	;
		Scale 0.6;
		PROJECTILE;
		-NOGRAVITY;
		+DROPOFF;
		+CANBOUNCEWATER;
		+DONTBLAST;
		+USEBOUNCESTATE;
		BounceSound "gem/stone/break2";
		DeathSound "gem/stone/break";
		BounceType "Hexen";
		BounceCount 4 ;
		BounceFactor 1.2;
		ReactionTime 14;
		ProjectileKickBack 800;
	}

	states {
		Spawn:   
			EBLD ABCD 2;
			TNT1 A 0 A_CountDown;
			Loop;
		Bounce:
			TNT1 A 0;
			TNT1 A 0 ThrustThing(random(0,360), 5, 0, 0);
			EBLD ABCD 2;
			Goto Spawn;
		Death:
			TNT1 AA 0 A_SpawnItemEx("EGemRock",0,0,3,random(-1,1),random(-1,1),random(2,4),random(0,359),32);
			TNT1 AAAA 0 A_SpawnItemEx("EGemRockSmall",0,0,3,random(-1,1),random(-1,1),random(2,4),random(0,359),32);
			Stop;
	}
}

class EGemRock : Actor {
	default {
		Damage 3;
		Speed 12;
		Radius 6;
		Height 3;
		Scale 0.5;
		Gravity 0.6;
		PROJECTILE;
		+BRIGHT;
		-NOGRAVITY;
		+DONTBLAST;
		DeathSound "gem/stone/break";
	}

	states {
		Spawn:
			ESTN A 1;
			Loop;
		Death:
			ESTN B 3;
			TNT1 AAA 0 A_SpawnItemEx("EGemRockSmall",0,0,3,random(-1,1),random(-1,1),random(2,4),random(0,359),32);
			Stop;
	}
}

class EGemRockSmall : Actor {
	default {
		Speed 8;
		Radius 2;
		Height 2;
		Scale 0.2;
		Gravity 0.6;
		PROJECTILE;
		+BRIGHT;
		-NOGRAVITY;
		+DONTBLAST;
	}

	states {
		Spawn:
			ESTN C 1;  
			Loop;
		Death:
			TNT1 A 0;
			Stop;
	}
}

class GemShardBrown : Actor {
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
			GBRD ABCD 1;
			Loop;
		Death:
			TNT1 A 0;
			Stop;
	}
}