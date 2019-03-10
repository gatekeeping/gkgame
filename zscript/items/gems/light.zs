
class LightGem : Inventory {
	default {
		Inventory.Amount 1;
		Inventory.MaxAmount 99;
		Inventory.PickupSound "gem/get";
		Inventory.PickupMessage "Light Gem";
		Inventory.Icon "ILIGA0";
		Tag "Light Gem - Smites evil with light.";
		Scale 0.7;
		+Inventory.INVBAR;
		+FLOORCLIP;
	}

	states {
		Spawn:
			LIGM A 12;
			TNT1 A 0 A_SpawnItem("GemShine",0,0,0);
			Loop;
	}

	override bool use (bool pickup) {
		owner.A_ThrowGrenade("LightGemSet", 2, 8, 3, 0);
		return true;
	}
}

class LightGemSet : Actor {
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
			LIGM  A 1 Bright;
			Loop;
 		Death:
			LIGM  A 1 Bright;
			TNT1 A 0 A_SpawnItem("LightGemPrepare",0,0,0);
			Stop;
	}
}

class LightGemPrepare : Actor {
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
			LIGM A 1;
			TNT1 A 0 ThrustThingZ(0,10,0,0);
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			TNT1 A 0 A_SpawnItemEx("LightGemActive",0,0,0,0,0,0,0,32);
			Stop;
	}
}

class LightGemActive : Actor {
	default {
		Radius 3;
		Height 5;
		Speed 0;
		Scale 0.5;
		PROJECTILE;
		Reactiontime 35;
		RenderStyle "Add";
		Alpha 1;
		+THRUACTORS;
		-SHOOTABLE;
		+BRIGHT;
		+NOCLIP;
		+VISIBILITYPULSE;
		+DONTBLAST;
	}

	states {
		Spawn:  
			TNT1 A 0;
			TNT1 A 0 A_AlertMonsters;
			LIGM A 10;
			TNT1 A 0 A_PlaySound("gem/light/active",5,0.8,0);
			LIGM A 2;
			TNT1 A 0 A_SpawnItemEx("GemLightBurstFX",3,0,6);
			TNT1 AAAAA 0 A_SpawnProjectile("LightRayStartup", 0, 0, random(0,360), CMF_AIMDIRECTION,random(0,5));
			LIGM A 3;
			TNT1 A 0 A_CountDown;
			Goto Spawn+4;
		Death:
			TNT1 A 0;
			TNT1 A 0 A_PlaySound("gem/break",5,2,0);
			TNT1 AAAAAA 0 A_SpawnItemEx("GemShardWhite",0,0,3,random(-2,2),random(-2,2),random(3,9),random(0,359),32);
			Stop;
	}
}

class LightRayStartup : Actor {
	default {
		Speed 12;
		Radius 10;
		Height 10;
		DamageFunction (4*random(3,7));
		Alpha 0.6;
		Scale 0.5;
		PROJECTILE;
		RenderStyle "Add";
		ReactionTime 2;
		+RANDOMIZE;
		+BRIGHT;
		+DONTBLAST;
	}

	states {
		Spawn:
			LIPR ABCD 1 Bright;
			TNT1 A 0 A_Countdown;
			Loop;
		Death:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItem("GemLightBurstShockwave",0,0,0,0);
			TNT1 A 0 A_PlaySound("gem/light/active",5,0.2,0);
			TNT1 A 0 A_SpawnProjectile("GemLightRayProj", 0, 0, 0, CMF_AIMDIRECTION);
			TNT1 A 0 A_SetScale(0.3);
			TNT1 A 0 A_SetTranslucent(0.6);
			TRPF AABCDE 1 Bright;
			Stop;
	}
}

class GemLightRayProj : FastProjectile {
	default {
		Speed 40;
		Radius 10;
		Height 10;
		DamageFunction (4*random(3,7));
		DeathSound "gem/light/ray";
		MissileType "GemLightFlyTrail";
		MissileHeight 8;
		Scale 0.6;
		PROJECTILE;
		+BRIGHT;
		+DONTBLAST;
	}

	states {
		Spawn:
			TNT1 A 0;
			LIPR ABCD 1;
			TNT1 A 0 A_Jump(100,"LightBeam");
			Loop;
		LightBeam:
			TNT1 A 0 A_SpawnItemEx("LightRayLaunched",0,0,8,random(-2,2),random(-2,2),random(5,15),random(0,359),32);
			Stop;
		Death: 
			TNT1 A 0;
			TNT1 A 0 A_SetScale(0.4);
			TNT1 A 0 A_SetTranslucent(0.8);
			TNT1 A 0 A_SpawnItem("GemLightShockwave",0,0,0);
			TRPF AABCDE 1 BRIGHT;
			Stop;
	}
}

class LightRayLaunched : FastProjectile {
	default {
		Speed 12;
		DamageFunction (4*random(3,7));
		Radius 10;
		Height 10	;
		RenderStyle "Add";
		Alpha 0.3;
		Scale 0.8;
		ReactionTime 15;
		PROJECTILE;
		+BRIGHT;
		+DONTBLAST;
		MissileType "GemLightFlyTrail";
		MissileHeight 8;
	}

	states {
		Spawn:
			LIPR ABCD 2;
			TNT1 A 0 A_CountDown;
			TNT1 A 0 A_Jump(150,"LightBeam");
			Loop     ;
		LightBeam:
			TNT1 AA 0 A_SpawnProjectile("GemLightRayProjExtra", 0, 0, random(0,360), CMF_AIMDIRECTION);
			Stop;
		Death:
			TNT1 A 0;
			TNT1 A 0 A_SetScale(0.4);
			TNT1 A 0 A_SetTranslucent(0.8);
			TNT1 A 0 A_SpawnItem("GemLightShockwave",0,0,0);
			TRPF AABCDE 1 BRIGHT;
			Stop;
	}
}

class GemLightRayProjExtra : FastProjectile {
	default {
		Speed 40;
		DamageFunction (4*random(3,7));
		Radius 10;
		Height 10;
		DeathSound "gem/light/ray";
		MissileType "GemLightFlyTrail";
		MissileHeight 8;
		Scale 0.6;
		PROJECTILE;
		+BRIGHT;
		+DONTBLAST;
	}

	states {
		Spawn:
			TNT1 A 0;
			LIPR ABCD 1;
			TNT1 A 0 A_Jump(150,"LightBeam");
			Loop;
		LightBeam:
			TNT1 A 0 A_SpawnItemEx("LightRayLaunched",0,0,-8,random(-2,2),random(-2,2),random(-5,-15),random(0,359),32);
			Stop;
		Death: 
			TNT1 A 0;
			TNT1 A 0 A_SetScale(0.4);
			TNT1 A 0 A_SetTranslucent(0.8);
			TNT1 A 0 A_SpawnItem("GemLightShockwave",0,0,0);
			TRPF AABCDE 1 BRIGHT;
			Stop;
	}
}

class GemLightFlyTrail : Actor {
	default {
		+NOINTERACTION;
		+NOCLIP;
		+BRIGHT;
		+DONTBLAST;
		Radius 1;
		Height 1;
		Renderstyle "Add";
		Alpha 0.2;
		Scale 0.3;
	}

	states {
		Spawn:
			TTRL ABCD 1;
			Stop;
	}
}

class GemLightShockwave : Actor {
	default {
		Radius 6;
		Height 6;
		Speed 0;
		RenderStyle "Add";
		Alpha 0.2;
		Scale 0.5;
		PROJECTILE;
		+NOCLIP;
		+THRUACTORS;
		+BRIGHT;
		+DONTBLAST;
	}

	states {
		Spawn:
			TNT1 A 0;
			Goto Death;
		Death:
			TSXP A 1;
			TNT1 A 0 A_SetTranslucent(0.1);
			TSXP A 1;
			Stop;
	}
}

class GemLightBurstShockwave : Actor {
	default {
		Radius 6;
		Height 6;
		Speed 0;
		RenderStyle "Add";
		Alpha 0.3;
		Scale 0.4;
		PROJECTILE;
		+NOCLIP;
		+THRUACTORS;
		+BRIGHT;
		+DONTBLAST;
	}

	states {
		Spawn:
			TNT1 A 0;
			Goto Death;
		Death:
			TSXP A 1;
			TNT1 A 0 A_SetTranslucent(0.1);
			TNT1 A 0 A_SetScale(0.6);
			TSXP A 1;
			TNT1 A 0 A_SetScale(0.8);
			TSXP A 1;
			Stop;
	}
}

class GemLightBurstFX : Actor {
	default {
		Radius 6;
		Height 6;
		Speed 0;
		RenderStyle "Add";
		Alpha 0.5;
		Scale 0.4;
		PROJECTILE;
		+NOCLIP;
		+THRUACTORS;
		+BRIGHT;
		+DONTBLAST;
	}

	states {
		Spawn:
			TNT1 A 0;
			Goto Death;
		Death:
			TSXP A 1;
			TNT1 A 0 A_SetTranslucent(0.2);
			TNT1 A 0 A_SetScale(0.6);
			TSXP A 1;
			TNT1 A 0 A_SetScale(0.8);
			TSXP A 1;
			Stop;
	}
}


class GemShardWhite : Actor {
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
			GWSD ABCD 1;
			Loop ;
		Death:
			TNT1 A 0;
			Stop;
	}

}