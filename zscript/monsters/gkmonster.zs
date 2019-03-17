
class GKMonster : Actor {

	private int forgetTimer;
	private int randomForget;

	override void PostBeginPlay() {
		randomForget = random(1, 30);
	}

	override void Tick() {
		if (canForget() && gametic % 35) {
			if(target && forgetTimer < forgetCalc() && CheckSight(target)) {
				forgetTimer = forgetCalc();
			}
			else if (target && forgetTimer && !CheckSight(target)) {
				forgetTimer--;
				if (!forgetTimer) {
					A_ClearTarget();
					SetState(FindState("Wander"));
				}
			}
		}
		super.Tick();
	}

	int forgetCalc() {
		return (forgetSeconds() + randomForget);
	}

	virtual int forgetSeconds() {
		return 0; 
	}

	virtual float minSeeDist() {
		return 0.0;
	}

	virtual float maxSeeDist() {
		return 0.0;
	}

	virtual float maxHearDist() {
		return 0.0;
	}

	virtual double fov() {
		return 160.0;
	}

	virtual bool canForget() {
		return true;
	}

}
