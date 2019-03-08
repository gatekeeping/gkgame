class GemShine : Actor {
	default {
		Radius 1;
		Height 1;
		Speed 0;
		Projectile;
		+ThruActors;
		+MoveWithSector;
		+NoClip;
		+DontBlast;
		RenderStyle "add";
		Alpha 0.6;
		Scale 0.5;
	}

	states {
		Spawn:
			GSHN A 1;
			TNT1 A 0 A_SetScale(0.6);
			TNT1 A 0 A_SetTranslucent(0.3);
			GSHN A 1;
			TNT1 A 0 A_SetScale(0.7);
			TNT1 A 0 A_SetTranslucent(0.25);
			GSHN A 1;
			TNT1 A 0 A_SetScale(0.8);
			TNT1 A 0 A_SetTranslucent(0.15);
			GSHN A 1;
			TNT1 A 0 A_SetScale(0.9);
			TNT1 A 0 A_SetTranslucent(0.1);
			GSHN A 1;
			Stop;
		Death:
			TNT1 A 0;
			Stop;
	}

}