
class LightningGem : Inventory {
	default {
		Inventory.Amount 1;
		Inventory.MaxAmount 99;
		Inventory.PickupSound "gem/get";
		Inventory.PickupMessage "Lightning Gem";
		Inventory.Icon "ILGMA0";
		Tag "Lightning Gem - Assaults foes on land and in sky with lightning.";
		Scale 0.7;
		+Inventory.INVBAR;
		+FLOORCLIP;
	}

	states {
		Spawn:
			LGEM A 12;
			TNT1 A 0 A_SpawnItem("GemShine",0,0,0);
			Loop;
	}

	override bool use (bool pickup) {
		owner.A_ThrowGrenade("LightningGemSet", 2, 8, 3, 0);
		return true;
	}
}

class LightningGemSet : Actor {
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
			LGEM A 1 Bright;
			Loop;
		Death:
			LGEM A 1 Bright;
			TNT1 A 0 A_SpawnItem("LightningGemPrepare",0,0,0);
			Stop;
	}
}

class LightningGemPrepare : Actor {
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
			LGEM A 1;
			TNT1 A 0 ThrustThingZ(0,10,0,0);
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			TNT1 A 0 A_SpawnItemEx("LightningGemActive",0,0,0,0,0,0,0,32);
			Stop;
	}
}

class LightningGemActive : Actor {
	default {
		Radius 3;
		Height 5;
		Speed 0;
		Scale 0.5;
		PROJECTILE;
		Reactiontime 12;
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
			TNT1 A 0 A_SpawnItemEx("GemLightningOrbFX",0,0,4);
			TNT1 A 0 A_PlaySound("gem/lightning/strike");
			LGEM A 3;
			TNT1 AA 0 A_SpawnItemEx("GemLightningBoltSpawner",random(-120,120),random(-120,120),150);
			TNT1 A 0 A_CustomMissile("LitBolt", 0, 0, random(0,360), CMF_AIMDIRECTION);
			TNT1 A 0 A_CustomMissile("LitBoltChase", 0, 0, random(0,360), CMF_AIMDIRECTION);
			LGEM A 2;
			TNT1 AA 0 A_SpawnItemEx("GemLightningBoltSpawner",random(-120,120),random(-120,120),150);
			TNT1 A 0 A_CustomMissile("LitBolt", 0, 0, random(0,360), CMF_AIMDIRECTION);
			TNT1 A 0 A_CustomMissile("LitBoltChase", 0, 0, random(0,360), CMF_AIMDIRECTION);
			LGEM A 2;
			TNT1 AA 0 A_SpawnItemEx("GemLightningBoltSpawner",random(-120,120),random(-120,120),150);
			TNT1 A 0 A_CustomMissile("LitBolt", 0, 0, random(0,360), CMF_AIMDIRECTION);
			TNT1 A 0 A_CustomMissile("LitBoltChaseEx", 0, 0, random(0,360), CMF_AIMDIRECTION);
			LGEM A 2;
			TNT1 AA 0 A_SpawnItemEx("GemLightningBoltSpawner",random(-120,120),random(-120,120),150);
			TNT1 A 0 A_CustomMissile("LitBolt", 0, 0, random(0,360), CMF_AIMDIRECTION);
			TNT1 A 0 A_CustomMissile("LitBolt", 0, 0, random(0,360), CMF_AIMDIRECTION);
			LGEM A 2;
			TNT1 AA 0 A_SpawnItemEx("GemLightningBoltSpawner",random(-120,120),random(-120,120),150);
			TNT1 A 0 A_CustomMissile("LitBolt", 0, 0, random(0,360), CMF_AIMDIRECTION);
			TNT1 A 0 A_CustomMissile("LitBoltChaseEx", 0, 0, random(0,360), CMF_AIMDIRECTION);
			LGEM A 7;
			LGEM A 25;
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			TNT1 A 0;
			TNT1 A 0 A_PlaySound("gem/break",5,2,0);
			TNT1 AAAAAA 0 A_SpawnItemEx("GemShardYellow",0,0,3,random(-2,2),random(-2,2),random(3,9),random(0,359),32);
			Stop;
	}
}

class GemLightningOrbFX : Actor {
	default {
		Radius 10;
		Height 6;
		Speed 4;
		Alpha 0.6;
		Scale 0.5;
		RenderStyle "Add";
		PROJECTILE;
		Reactiontime 3;
		+THRUACTORS;
		+BRIGHT;
		+NOCLIP;
		+DONTBLAST;
	}

	states {
		Spawn: 
			GLIT ABCDE 1;
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			GLIT A 1 A_SetTranslucent(0.55);
			GLIT B 1 A_SetTranslucent(0.5);
			GLIT C 1 A_SetTranslucent(0.45);
			GLIT D 1 A_SetTranslucent(0.4);
			GLIT E 1 A_SetTranslucent(0.35);
			GLIT B 1 A_SetTranslucent(0.3);
			Stop;
	}
}

class LitBolt : FastProjectile {
	default {
		Speed 14;
		DamageFunction (5*random(2,4));
		Radius 8;
		Height 5;
		RenderStyle "Add";
		Alpha 0.3;
		Scale 0.5;
		MissileHeight 8;
		MissileType "LitBoltFX";
		SeeSound "LightningBolts";
		PROJECTILE;
		+BRIGHT;
		+DONTBLAST;
	}

	states {
		Spawn:
			TNT1 A 0;
 			TNT1 A 0 A_Jump(255,"Var1","Var2","Var3");
			Loop;
		Var1:
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-3,1), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,2), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-4,3), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,3), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-4,2), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-3,4), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-1,2), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-4,2), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,4), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-3,3), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,4), random(-2,2));
			GRLT A 1;
			Loop;
		Var2:
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-3,1), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,2), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-4,3), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,3), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-4,2), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-3,4), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-1,2), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-4,2), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,4), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-3,3), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,4), random(-2,2));
			GRLT A 1;
			Loop;
		Var3:
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-3,1), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,2), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-4,3), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,3), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-4,2), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-3,4), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-1,2), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-4,2), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,4), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-3,3), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,4), random(-2,2));
			GRLT B 1;
			Loop;
		Death:
  			TNT1 A 0;
   			Stop;
	}
}

class LitBoltChase : FastProjectile {
	default {
		Speed 18;
		DamageFunction (3*random(2,5));
		Radius 8;
		Height 5;
		RenderStyle "Add";
		Alpha 0.3;
		Scale 0.5;
		MissileHeight 8;
		MissileType "LitBoltFX";
		SeeSound "LightningBolts";
		PROJECTILE;
		+SEEKERMISSILE;
		+BRIGHT;
		+DONTBLAST;
	}

	states {
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Jump(255,"Var1","Var2","Var3");
			Loop;
		Var1:
			GRLT A 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-3,1), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-2,2), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-4,3), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,3), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-4,2), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-3,4), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-1,2), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-4,2), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,4), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-3,3), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,4), random(-2,2));
			GRLT A 1;
			Goto Var1+8;
		Var2:
			GRLT C 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-3,1), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-2,2), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-4,3), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,3), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-4,2), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-3,4), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-1,2), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-4,2), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,4), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-3,3), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,4), random(-2,2));
			GRLT A 1;
			Goto Var2+8;
		Var3:
			GRLT B 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-3,1), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-2,2), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-4,3), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,3), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-4,2), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-3,4), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-1,2), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-4,2), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,4), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-3,3), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,4), random(-2,2));
			GRLT B 1;
			Goto Var3+8;
		Death:
			TNT1 A 0;
			Stop;
	}
}

class LitBoltChaseEx : FastProjectile {
	default {
		Speed 18;
		DamageFunction (3*random(2,5));
		Radius 8;
		Height 5;
		RenderStyle "Add";
		Alpha 0.3;
		Scale 0.5;
		MissileHeight 8;
		MissileType "LitBoltFX";
		SeeSound "LightningBolts";
		PROJECTILE;
		+SEEKERMISSILE;
		+BRIGHT;
		+DONTBLAST;
	}

	states {
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Jump(255,"Var1","Var2","Var3");
			Loop;
		Var1:
			GRLT A 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-3,1), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-2,2), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-4,3), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-2,3), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-4,2), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-3,4), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-1,2), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-4,2), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,4), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-3,3), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,4), random(-2,2));
			GRLT A 1;
			Goto Var1+22;
		Var2:
			GRLT C 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-3,1), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-2,2), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-4,3), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-2,3), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-4,2), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-3,4), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-1,2), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-4,2), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,4), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-3,3), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,4), random(-2,2));
			GRLT A 1;
			Goto Var2+22;
		Var3:
			GRLT B 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-3,1), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-2,2), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-4,3), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-2,3), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-4,2), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-3,4), random(-2,2));
			GRLT B 1;
			TNT1 A 0 A_SeekerMissile(10,80,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_Weave(3, 3, random(-1,2), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-4,2), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,4), random(-2,2));
			GRLT C 1;
			TNT1 A 0 A_Weave(3, 3, random(-3,3), random(-2,2));
			GRLT A 1;
			TNT1 A 0 A_Weave(3, 3, random(-2,4), random(-2,2));
			GRLT B 1;
			Goto Var3+22;
		Death:
			TNT1 A 0;
			Stop;
	}
}

class LitBoltFX : Actor {
	default {
		Radius 8;
		Height 5;
		RenderStyle "Add";
		Alpha 0.3;
		Scale 0.5;
		PROJECTILE;
		+BRIGHT;
		+THRUACTORS;
		+DONTBLAST;
	}

	states {
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Jump(255,"Var1","Var2","Var3");
			Loop;
		Var1:
			GRLT ABCBA 1;
			Stop;
		Var2:
			GRLT BCABC 1;
			Stop;
		Var3:
			GRLT CABCB 1;
			Stop;
		Death:
			TNT1 A 0;
			Stop;
	}
}

class GemLightningBoltSpawner : Actor {
	default {
		Radius 7;
		Height 5;
		Speed 0;
		Scale 0.6;
		PROJECTILE;
		+THRUACTORS;
		+NOCLIP;
		+BRIGHT;
		+DONTBLAST;
	}

	states {
		Spawn:
			TNT1 A 8;
			TNT1 A 0 A_SpawnItem("GemLightningBoltVar1",0,-50,0);
			GLIT A 1;
			TNT1 A 0 A_SpawnItem("GemLightningBoltVar2",0,-50,0);
			GLIT B 1;
			TNT1 A 0 A_SpawnItem("GemLightningBoltVar3",0,-50,0);
			GLIT C 1;
			TNT1 A 0 A_SpawnItem("GemLightningBoltVar1",0,-50,0);
			GLIT D 1;
			TNT1 A 0 A_SpawnItem("GemLightningBoltVar2",0,-50,0);
			GLIT E 1;
			TNT1 A 0 A_SpawnItem("GemLightningBoltVar1",0,-50,0);
			GLIT A 1;
			TNT1 A 0 A_SpawnItem("GemLightningBoltVar3",0,-50,0);
			GLIT B 1;
			TNT1 A 0 A_SpawnItem("GemLightningBoltVar1",0,-50,0);
			GLIT C 1;
			TNT1 A 0 A_SpawnItem("GemLightningBoltVar2",0,-50,0);
			GLIT D 1;
			TNT1 A 0 A_SpawnItem("GemLightningBoltVar3",0,-50,0);
			GLIT E 1;
			TNT1 A 0 A_SpawnItem("GemLightningBoltVar1",0,-50,0);
			GLIT A 1;
			TNT1 A 0 A_SpawnItem("GemLightningBoltVar2",0,-50,0);
			GLIT B 1;
			TNT1 A 0 A_SpawnItem("GemLightningBoltVar3",0,-50,0);
			Stop;
    	Death:
			TNT1 A 0;
			Stop;
	}
}

class GemLightningBoltVar1 : Actor {
	default {
		Radius 7;
		Height 5;
		Speed 0;
		Alpha 1;
		Scale 0.8;
		PROJECTILE;
		RenderStyle "Add";
		+RANDOMIZE;
		+THRUACTORS;
		+NOCLIP;
		+DONTSPLASH;
		+BRIGHT;
		+DONTBLAST;
		ReactionTime 1;
	}

	states {
		Spawn:
			GBLT A 1;
			TNT1 A 0 ThrustThingZ(0,240,1,1);
			TNT1 A 0 A_SpawnItem("GemLightningDMG",0,0,0);
			GBLT B 1;
			TNT1 A 0 ThrustThingZ(0,240,1,1);
			TNT1 A 0 A_SpawnItem("GemLightningDMG",0,0,0);
			GBLT C 1;
			TNT1 A 0 ThrustThingZ(0,240,1,1);
			TNT1 A 0 A_SpawnItem("GemLightningDMG",0,0,0);
			GBLT D 1;
			TNT1 A 0 ThrustThingZ(0,240,1,1);
			TNT1 A 0 A_SpawnItem("GemLightningDMG",0,0,0);
			TNT1 A 0 A_Countdown;
			Loop;
		Death:
			GXLT ABCD 1;
			Stop;
	}
}

class GemLightningBoltVar2 : Actor {
	default {
		Radius 7;
		Height 5;
		Speed 0;
		Alpha 1;
		Scale 0.8;
		PROJECTILE;
		RenderStyle "Add";
		+RANDOMIZE;
		+THRUACTORS;
		+NOCLIP;
		+DONTSPLASH;
		+BRIGHT;
		+DONTBLAST;
		ReactionTime 1;
	}

	states {
    	Spawn:
			GBLT D 1;
			TNT1 A 0 ThrustThingZ(0,240,1,1);
			TNT1 A 0 A_SpawnItem("GemLightningDMG",0,0,0);
			GBLT B 1;
			TNT1 A 0 ThrustThingZ(0,240,1,1);
			TNT1 A 0 A_SpawnItem("GemLightningDMG",0,0,0);
			GBLT C 1;
			TNT1 A 0 ThrustThingZ(0,240,1,1);
			TNT1 A 0 A_SpawnItem("GemLightningDMG",0,0,0);
			GBLT A 1;
			TNT1 A 0 ThrustThingZ(0,240,1,1);
			TNT1 A 0 A_SpawnItem("GemLightningDMG",0,0,0);
			TNT1 A 0 A_Countdown;
			Loop;
		Death:
			GXLT ABCD 1;
			Stop;
	}
}

class GemLightningBoltVar3 : Actor {
	default {
		Radius 7;
		Height 5;
		Speed 0;
		Alpha 1;
		Scale 0.8;
		PROJECTILE;
		RenderStyle "Add";
		+RANDOMIZE;
		+THRUACTORS;
		+NOCLIP;
		+DONTSPLASH;
		+BRIGHT;
		+DONTBLAST;
		ReactionTime 1;
	}

	states {
		Spawn:
			GBLT C 1;
			TNT1 A 0 ThrustThingZ(0,240,1,1);
			TNT1 A 0 A_SpawnItem("GemLightningDMG",0,0,0);
			GBLT A 1;
			TNT1 A 0 ThrustThingZ(0,240,1,1);
			TNT1 A 0 A_SpawnItem("GemLightningDMG",0,0,0);
			GBLT D 1;
			TNT1 A 0 ThrustThingZ(0,240,1,1);
			TNT1 A 0 A_SpawnItem("GemLightningDMG",0,0,0);
			GBLT B 1;
			TNT1 A 0 ThrustThingZ(0,240,1,1);
			TNT1 A 0 A_SpawnItem("GemLightningDMG",0,0,0);
			TNT1 A 0 A_Countdown;
			Loop;
		Death:
			GXLT ABCD 1;
			Stop;
	}
}

class GemLightningDMG : Actor {
	default {
		Speed 2;
		Radius 15;
		Height 8;
		DamageFunction (2*random(3,6));
		PROJECTILE;
		+BLOODLESSIMPACT;
		+DONTSPLASH;
		+DONTBLAST;
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

class GemShardYellow : Actor {
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
			GYSD ABCD 1;
			Loop;
		Death:
			TNT1 A 0;
			Stop;
	}
}