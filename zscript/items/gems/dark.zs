
class DarkGem : Inventory {
	default {
		Inventory.Amount 1;
		Inventory.MaxAmount 99;
		Inventory.PickupSound "gem/get";
		Inventory.PickupMessage "Dark Gem";
		Inventory.Icon "IDGMA0";
		Tag "Dark Gem - Terrorizes enemies with darkness.";
		Scale 0.7;
		+Inventory.INVBAR;
		+FLOORCLIP;
	}

	states {
		Spawn:
			DGEM A 12;
			TNT1 A 0 A_SpawnItem("GemShine",0,0,0);
			Loop;
	}

	override bool use (bool pickup) {
		owner.A_ThrowGrenade("DarkGemSet", 2, 8, 3, 0);
		return true;
	}
}

class DarkGemSet : Actor {
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
			DGEM A 1 Bright;
			Loop;
		Death:
			DGEM A 1 Bright;
			TNT1 A 0 A_SpawnItem("DarkGemPrepare",0,0,0);
			Stop;
	}
}

class DarkGemPrepare : Actor {
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
			DGEM A 1;
			TNT1 A 0 ThrustThingZ(0,10,0,0);
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			TNT1 A 0 A_SpawnItemEx("DarkGemActive",0,0,0,0,0,0,0,32);
			Stop;
	}
}

class DarkGemActive : Actor {
	default {
		Radius 3;
		Height 5;
		Speed 0;
		Scale 0.5;
		PROJECTILE;
		Reactiontime 28;
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
			TNT1 A 0 A_SpawnItem("DarkVortexProjRise",0,5,0);
			TNT1 A 0 A_AlertMonsters;
			DGEM A 17;
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			TNT1 A 0;
			TNT1 A 0 A_PlaySound("gem/break",5,2,0);
			TNT1 AAAAAA 0 A_SpawnItemEx("GemShardBlack",0,0,3,random(-2,2),random(-2,2),random(3,9),random(0,359),32);
			Stop;
	}
}

class DarkVortexProjRise : Actor {
	default {
		Radius 10;
		Height 6;
		Speed 4;
		Alpha 0.8;
		Scale 0.8;
		RenderStyle "Add";
		PROJECTILE;
		+THRUACTORS;
		+FORCERADIUSDMG;
		+FORCEPAIN;
		+BRIGHT;
		+DONTBLAST;
		Reactiontime 4;
	}

	states {
		Spawn: 
			DVRT ABC 2 ThrustThingZ(0,8,0,0);
			TNT1 AA 0 A_SpawnProjectile("DarkVortexProjSmall", random(-5,10), 0, random(0,360), CMF_AIMDIRECTION, random(-5,18));
			TNT1 A 0 A_Explode(6,75,0,1,75);
			TNT1 A 0 A_RadiusThrust(-500,60,2);
			TNT1 A 0 A_PlaySound("gem/dark/vortex",5,2,1);
			TNT1 A 0 A_Explode(6,75,0,1,75);
			TNT1 A 0 A_RadiusThrust(-500,60,2);
			TNT1 AA 0 A_SpawnProjectile("DarkVortexProjSmall", random(-5,10), 0, random(0,360), CMF_AIMDIRECTION, random(-5,18));
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			TNT1 A 0 A_SpawnProjectile("DarkVortexProj", 0, 0, random(0,360), CMF_AIMDIRECTION, random(-5,18));
			Stop;
	}
}

class DarkVortexProj : Actor {
	default {
		Radius 10;
		Height 6;
		Speed 12;
		Alpha 0.8;
		Scale 0.8;
		RenderStyle "Add";
		PROJECTILE;
		Reactiontime 2;
		+THRUACTORS;
		+FORCERADIUSDMG;
		+FORCEPAIN;
		+BRIGHT;
		+DONTBLAST;
	}

	states {
		Spawn: 
			DVRT AB 2;
			TNT1 AA 0 A_SpawnProjectile("DarkVortexProjSmall", random(-5,10), 0, random(0,360), CMF_AIMDIRECTION, random(-5,18));
			DVRT C 2	 ;
			TNT1 A 0 A_Explode(6,75,0,1,75);
			TNT1 A 0 A_RadiusThrust(-500,60,2);
			TNT1 A 0 A_Jump(80,9); //Jump to cause the projectile to some times destroy faster.;
			DVRT ABC 2;
			TNT1 A 0 A_PlaySound("gem/dark/vortex",5,2,1);
			TNT1 A 0 A_Explode(6,75,0,1,75);
			TNT1 A 0 A_RadiusThrust(-500,60,2);
			TNT1 AA 0 A_SpawnProjectile("DarkVortexProjSmall", random(-5,10), 0, random(0,360), CMF_AIMDIRECTION, random(-5,18));
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			TNT1 A 0 A_SpawnItem("DarkVortexProjDrop",0,0,0);
			Stop;
	}
}

class DarkVortexProjDrop : Actor {
	default {
		Radius 10;
		Height 6;
		Speed 4;
		Alpha 0.8;
		Scale 0.8;
		RenderStyle "Add";
		PROJECTILE;
		+THRUACTORS;
		+FORCERADIUSDMG;
		+FORCEPAIN;
		+BRIGHT;
		+DONTBLAST;
	}

	states {
		Spawn: 
			DVRT ABC 2 ThrustThingZ(0,-8,0,0);
			TNT1 AA 0 A_SpawnProjectile("DarkVortexProjSmall", random(-5,10), 0, random(0,360), CMF_AIMDIRECTION, random(-5,18));
			TNT1 A 0 A_Explode(6,75,0,1,90);
			TNT1 A 0 A_RadiusThrust(-500,60,2);
			DVRT ABC 2 ThrustThingZ(0,-8,0,0);
			TNT1 A 0 A_PlaySound("gem/dark/vortex",5,2,1);
			TNT1 A 0 A_Explode(6,75,0,1,90);
			TNT1 A 0 A_RadiusThrust(-500,60,2);
			TNT1 AA 0 A_SpawnProjectile("DarkVortexProjSmall", random(-5,10), 0, random(0,360), CMF_AIMDIRECTION, random(-5,18));
			Loop;
		Death:
			TNT1 A 0 A_SpawnItem("DarkVortexNova",0,0,0);
			Stop;
	}
}

class DarkVortexNova : Actor {
	default {
		Radius 10;
		Height 6;
		Speed 0;
		Alpha 0.6;
		Scale 0.8;
		RenderStyle "Add";
		PROJECTILE;
		+THRUACTORS;
		+FORCERADIUSDMG;
		+FORCEPAIN;
		+BRIGHT;
		+DONTBLAST;
	}

	states {
		Spawn: 
			TNT1 A 0;
			TNT1 A 0 A_PlaySound("gem/dark/hit",5,0.7,0);
			BVDP A 1 A_SetScale(0.9);
			TNT1 A 0 A_Explode(10,150,0,1,90)  ;
			BVDP B 1 A_SetScale(1.0);
			TNT1 A 0 A_Explode(10,150,0,1,90)	  ;
			BVDP C 1 A_SetScale(1.1);
			TNT1 A 0 A_Explode(10,150,0,1,90)	  ;
			BVDP A 1 A_SetScale(1.2);
			TNT1 A 0 A_Explode(10,150,0,1,90)	  ;
			BVDP B 1 A_SetScale(1.3);
			TNT1 A 0 A_Explode(10,150,0,1,90)	  ;
			BVDP C 1 A_SetScale(1.4);
			TNT1 A 0 A_Explode(10,150,0,1,90);
			BVDP A 1 A_SetScale(1.5);
			TNT1 A 0 A_Explode(10,150,0,1,90);
			BVDP B 1 A_SetScale(1.7);
			TNT1 A 0 A_Explode(15,200,0,1,90);
			BVDP C 1 A_SetScale(1.9);
			TNT1 A 0 A_Explode(15,200,0,1,90);
			BVDP A 1 A_SetScale(2.1);
			TNT1 A 0 A_Explode(15,200,0,1,90);
			BVDP B 1 A_SetScale(2.3);
			TNT1 A 0 A_Explode(15,200,0,1,90);
			TNT1 A 0 A_SpawnItemEx("GemDarkOrb",0,0,3,random(-2,2),random(-2,2),random(2,5),random(0,359),32);
			Stop;
		Death:
			TNT1 A 0;
			Stop;
	}
}

class DarkVortexProjSmall : Actor {
	default {
		Radius 10;
		Height 6;
		Speed 5;
		Alpha 0.8;
		Scale 0.5;
		RenderStyle "Add";
		PROJECTILE;
		+THRUACTORS;
		+FORCERADIUSDMG;
		+FORCEPAIN;
		+BRIGHT;
		+DONTBLAST;
	}

	states {
		Spawn: 
			DVRS A 2;
			DVRS B 2;
			TNT1 A 0 A_Explode(4,40,0,1,40);
			DVRS C 2	 ;
			TNT1 A 0 A_Explode(4,40,0,1,40);
			DVRS D 2;
			Stop;
		Death:
			BVDP A 1 A_SetTranslucent(0.5);
			BVDP B 1 A_SetTranslucent(0.45);
			BVDP C 1 A_SetTranslucent(0.4);
			BVDP A 1 A_SetTranslucent(0.35);
			BVDP B 1 A_SetTranslucent(0.3);
			BVDP C 1 A_SetTranslucent(0.25);
			BVDP A 1 A_SetTranslucent(0.2);
			BVDP B 1 A_SetTranslucent(0.15);
			BVDP C 1 A_SetTranslucent(0.10);
			Stop;
	}
}

class GemDarkOrb : Actor {
	default {
		Radius 10;
		Height 6;
		Speed 5;
		Alpha 0.8;
		Scale 0.5;
		RenderStyle "Add";
		PROJECTILE;
		+THRUACTORS;
		+FORCERADIUSDMG;
		+FORCEPAIN;
		+BRIGHT;
		+DONTBLAST;
	}

	states {
		Spawn: 
			BVOD A 1 A_SetScale(0.7);
			TNT1 A 0 A_Explode(10,60,0,1,40);
			BVOD B 1 A_SetScale(0.9);
			TNT1 A 0 A_Explode(10,60,0,1,40);
			BVOD C 1 A_SetScale(1.1);
			TNT1 A 0 A_Explode(10,60,0,1,40);
			BVOD A 1 A_SetScale(1.3);
			TNT1 A 0 A_Explode(10,60,0,1,40);
			BVOD B 1	 ;
			TNT1 A 0 A_Explode(10,60,0,1,40);
			BVOD C 1	 ;
			TNT1 A 0 A_Explode(10,60,0,1,40) ;
			BVOD ABC 1 ThrustThingZ(0,20,0,0);
			TNT1 A 0 A_Explode(10,60,0,1,40);
			BVOD ABC 1 ThrustThingZ(0,25,0,0);
			TNT1 A 0 A_Explode(10,60,0,1,40);
			BVOD ABC 1 ThrustThingZ(0,30,0,0);
			TNT1 A 0 A_Explode(10,60,0,1,40);
			BVOD ABC 1 ThrustThingZ(0,35,0,0);
			TNT1 A 0 A_Explode(10,60,0,1,40);
			BVOD ABC 1 ThrustThingZ(0,40,0,0);
			TNT1 A 0 A_Explode(10,60,0,1,40);
			BVOD ABC  1 ;
			BVOD ABC  1 A_Stop;
			BVOD DEF 2 A_SetScale(0.8);
			BVOD DEF 2 A_SetScale(1.0);
			BVOD DEF 2 A_SetScale(1.2);
			BVOD DEF 2 A_SetScale(1.4);
			TNT1 A 0 A_PlaySound("gem/dark/orb",5,1.6,0);
		Death:
			TNT1 A 0;
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 0, CMF_AIMDIRECTION);  //This ring FX method used instead of user variables;
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 10, CMF_AIMDIRECTION); //to prevent heavy lag.;
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 20, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 30, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 40, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 50, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 60, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 70, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 80, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 90, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 100, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 110, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 120, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 130, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 140, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 150, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 160, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 170, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 180, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 190, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 200, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 210, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 220, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 230, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 240, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 250, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 260, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 270, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 280, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 290, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 300, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 310, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 320, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 330, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 340, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 350, CMF_AIMDIRECTION);
			TNT1 A 0 A_SpawnProjectile("DarkEnergyBolt", 0, 0, 360, CMF_AIMDIRECTION);
			Stop;
	}
}

class DarkEnergyBolt : Actor {
	default {
		Speed 12;
		PROJECTILE;
		RenderStyle "Add";
		+BLOODLESSIMPACT;
		+THRUACTORS;
		+RANDOMIZE;
		+DONTBLAST;
		+BRIGHT;
		Scale 0.3;
		Alpha 0.6;
	}

	states {
		Spawn:
			DNRG AB 1;
			TNT1 A 0 A_Explode(5,15,0,1,15);
			DNRG AB 1;
			TNT1 A 0 A_Explode(5,15,0,1,15);
			DNRG AB 1;
			TNT1 A 0 A_Explode(5,15,0,1,15);
			DNRG AB 1;
			TNT1 A 0 A_Explode(5,15,0,1,15);
			DNRG AB 1 A_SetTranslucent(0.4);
		Death:
			DNRG A 2 A_SetTranslucent(0.2);
			Stop;
	}
}

class GemShardBlack : Actor {
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
			GDSD ABCD 1;
			Loop ;
		Death:
			TNT1 A 0;
			Stop;
	}
}