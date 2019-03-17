
class GKMonster : Actor {

	private int forgetTimer;
	private Vector2 spawnPosition;

	override void Tick() {
		if(target && forgetTimer < forgetTicks() && CheckSight(target)) {
			forgetTimer = forgetTicks();
			console.printf("Timer set: %i", forgetTimer);
		}
		else if (target && forgetTimer && !CheckSight(target)) {
			forgetTimer--;
			if (!forgetTimer) {
				console.printf("Lose Target: %i", forgetTimer);
				A_ClearTarget();
				TryMove(spawnPosition, 0);
			}
		}
		super.Tick();
	}

	override void PostBeginPlay() {
		spawnPosition = (self.pos.X, self.pos.Y);
	}

	virtual int forgetTicks() {
		return 0; 
	}




}
