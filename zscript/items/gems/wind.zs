
class WindGem : Inventory {
	default {
		Inventory.Amount 1;
		Inventory.MaxAmount 99;
		Inventory.PickupSound "gem/get";
		Inventory.PickupMessage "Wind Gem";
		Inventory.Icon "IWIGA0";
		Tag "Wind Gem - Pulls in enemies with a barrage of tornadoes.";
		Scale 0.7;
		+Inventory.INVBAR;
		+FLOORCLIP;
	}

	states {
		Spawn:
			WIGM A 1;
			TNT1 A 0 A_SpawnItem("GemShine", 0, 0, 0);
			Loop;
	}

	override bool use (bool pickup) {
		owner.A_ThrowGrenade("WindGemSet", 2, 8, 3, 0);
		return true;
	}
}

class WindGemSet : Actor {
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
			WIGM A 1 Bright;
			Loop;
		Death:
			WIGM A 1 Bright;
			TNT1 A 0 A_SpawnItem("WindGemPrepare", 0, 0, 0);
			Stop;
	}
}

class WindGemPrepare : Actor {
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
			WIGM A 1;
			TNT1 A 0 ThrustThingZ(0,10,0,0);
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			TNT1 A 0 A_SpawnItemEx("WindGemActive",0,0,0,0,0,0,0,32);
			Stop;
	}
}

class WindGemActive : Actor {
	default {
		Radius 3;
		Height 5;
		Speed 0;
		Scale 0.6;
		PROJECTILE;
		Reactiontime 125;
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
			TNT1 A 0 A_SpawnItemEx("GemTornadoTinyLauncherA",0,0,-5);
			TNT1 A 0 A_AlertMonsters;
			TNT1 A 0 A_SpawnItemEx("GemTornado",0,0,-21);
			TNT1 A 0 A_PlaySound("TRNWND",5,1.6,1);
			TNT1 A 0 A_RadiusThrust(-450,280,2);
			WIGM A 4;
			TNT1 A 0 A_CountDown;
			Goto Spawn+2;
		Death:
			TNT1 A 0;
			TNT1 A 0 A_PlaySound("GEMBRK",5,2,0);
			TNT1 AAAAAA 0 A_SpawnItemEx("GemShardGreen",0,0,3,random(-2,2),random(-2,2),random(3,9),random(0,359),32);
			Stop;
	}
}

class GemTornado : Actor {
	default {
		Radius 3;
		Height 5;
		Speed 0;
		RenderStyle "Add";
		Alpha 0.3;
		PROJECTILE;
		+BRIGHT;
		+THRUACTORS;
		-SHOOTABLE;
		+DONTBLAST;
	}

	states {
		Spawn:   
			WTOR ABCD 1;
			TNT1 A 0 A_Jump(55,"SmallTornadoShot");
			Stop;
		SmallTornadoShot:
			TNT1 A 0 A_CustomMissile("GemTornadoSeeker", 45, 0, random(0,360), CMF_AIMDIRECTION);
			Stop;
		Death:
			TNT1 A 0;
			Stop;
	}
}

class GemTornadoSeeker : Actor {
	default {
		Speed 10;
		DamageFunction (3*random(2,5));
		Radius 10;
		Height 5;
		RenderStyle "Add";
		Alpha 0.25;
		Scale 0.8;
		PROJECTILE;
		+BRIGHT;
		+SEEKERMISSILE;
		+DONTBLAST;
		ReactionTime 50;
	}

	states {
		Spawn:   
			SWTR ABABAB 1;
			SWTR AB 1 A_SeekerMissile(8,20,SMF_LOOK,256|SMF_PRECISE);
			TNT1 A 0 A_PlaySound("TRNWND",5,0.6,1);
			TNT1 A 0 A_RadiusThrust(-120,60,2);
			TNT1 A 0 A_CountDown;
			Goto Spawn+6;
		Death:
			SWTR A 2 A_SetTranslucent(0.20);
			TNT1 A 0 A_SetScale(0.6);
			SWTR B 2 A_SetTranslucent(0.15);
			TNT1 A 0 A_SetScale(0.4);
			SWTR A 2 A_SetTranslucent(0.10);
			TNT1 A 0 A_SetScale(0.2);
			SWTR B 2 A_SetTranslucent(0.05);
			Stop;
	}
}

class GemTornadoTinyLauncherA : Actor {
	default {
		Radius 5;
		Height 5;
		PROJECTILE;
		+DONTBLAST;
		ReactionTime 16;
	}

	states {
		Spawn:   
			TNT1 A 30;
			TNT1 A 0 A_CustomMissile("GemTornadoTinyLauncherB",-5,0,0, CMF_AIMDIRECTION);
			TNT1 A 0 A_CustomMissile("GemTornadoTinyLauncherB",-5,0,45, CMF_AIMDIRECTION);
			TNT1 A 0 A_CustomMissile("GemTornadoTinyLauncherB",-5,0,90, CMF_AIMDIRECTION);
			TNT1 A 0 A_CustomMissile("GemTornadoTinyLauncherB",-5,0,135, CMF_AIMDIRECTION);
			TNT1 A 0 A_CustomMissile("GemTornadoTinyLauncherB",-5,0,180, CMF_AIMDIRECTION);
			TNT1 A 0 A_CustomMissile("GemTornadoTinyLauncherB",-5,0,225, CMF_AIMDIRECTION);
			TNT1 A 0 A_CustomMissile("GemTornadoTinyLauncherB",-5,0,270, CMF_AIMDIRECTION);
			TNT1 A 0 A_CustomMissile("GemTornadoTinyLauncherB",-5,0,315, CMF_AIMDIRECTION);
			TNT1 A 0 A_CountDown;
			Loop;
		Death:
			TNT1 A 0;
			Stop;
	}
}

class GemTornadoTinyLauncherB : Actor {
	default {
		Speed 4;
		Damage 0;
		Radius 5;
		Height 5;
		PROJECTILE;
		+THRUACTORS;
		+DONTBLAST;
	}

	states {
		Spawn:   
			TNT1 AAA 2;
			TNT1 A 0 A_Jump(255,"SLife","MLife","LLife");
			Loop;
		SLife:
			TNT1 A 0 A_SpawnItem("GemTornadoTinyShort",0,0,0);
			Stop;
		MLife:
			TNT1 A 0 A_SpawnItem("GemTornadoTinyMid",0,0,0);
			Stop;
		LLife:
			TNT1 A 0 A_SpawnItem("GemTornadoTiny",0,0,0);
			Stop;
		Death:
			TNT1 A 0;
			Stop;
	}
}

class GemTornadoTiny : Actor {
	default {
		Speed 5;
		Damage 0;
		Radius 5;
		Height 5;
		RenderStyle "Add";
		Alpha 0.25;
		Scale 1;
		PROJECTILE;
		+BRIGHT;
		+THRUACTORS;
		+DONTBLAST;
		ReactionTime 24;
	}

	states {
   		Spawn:   
			TTRN ABCABCABCABCABCABCABCABCABC 1 ThrustThingZ(0,14,0,0);
			TNT1 A 0 ThrustThing(random(0,360),3,0,0);
			TNT1 A 0 A_SpawnItemEx("TinyTornadoDMG",0,0,0);
			TTRN ABC 1 ThrustThingZ(0,1,0,0);
			TNT1 A 0 A_CountDown;
			Goto Spawn+27;
   		Death:
			TTRN A 2 A_SetTranslucent(0.20);
			TTRN B 2 A_SetTranslucent(0.15);
			TTRN C 2 A_SetTranslucent(0.10);
			TTRN A 2 A_SetTranslucent(0.05);
			Stop;
	}
}

class GemTornadoTinyMid : GemTornadoTiny {
	states {
   		Spawn:   
			TTRN ABCABCABCABCABCABC 1 ThrustThingZ(0,14,0,0);
			TNT1 A 0 ThrustThing(random(0,360),3,0,0);
			TNT1 A 0 A_SpawnItemEx("TinyTornadoDMG",0,0,0);
			TTRN ABC 1 ThrustThingZ(0,1,0,0);
			TNT1 A 0 A_CountDown;
			Goto Spawn+18;
   		Death:
			TTRN A 2 A_SetTranslucent(0.20);
			TTRN B 2 A_SetTranslucent(0.15);
			TTRN C 2 A_SetTranslucent(0.10);
			TTRN A 2 A_SetTranslucent(0.05);
			Stop;
	}
}

class GemTornadoTinyShort : GemTornadoTiny {
	states {
		Spawn:   
			TTRN ABCABCABC 1 ThrustThingZ(0,14,0,0);
			TNT1 A 0 ThrustThing(random(0,360),3,0,0);
			TNT1 A 0 A_SpawnItemEx("TinyTornadoDMG",0,0,0);
			TTRN ABC 1 ThrustThingZ(0,1,0,0);
			TNT1 A 0 A_CountDown;
			Goto Spawn+9;
		Death:
			TTRN A 2 A_SetTranslucent(0.20);
			TTRN B 2 A_SetTranslucent(0.15);
			TTRN C 2 A_SetTranslucent(0.10);
			TTRN A 2 A_SetTranslucent(0.05);
			Stop;
	}
}

class TinyTornadoDMG : Actor {
	default {
		Speed 2;
		Radius 15;
		Height 8;
		DamageFunction (2*random(2,6));
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

class GemShardGreen : Actor {
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
			GGSD ABCD 1;
			Loop ;
  		Death:
			TNT1 A 0;
			Stop;
	}
}