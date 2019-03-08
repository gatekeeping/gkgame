class StopMoveState : Inventory {
	default {
		Inventory.MaxAmount 1;
	}
	private double originalSpeed;
	override void AttachToOwner(Actor user) {
		originalSpeed = user.speed;
		super.AttachToOwner(user);
	}
	override void DoEffect() {
		owner.speed = 0;
	}
	override void DetachFromOwner() {
		owner.speed = originalSpeed;
		super.DetachFromOwner();
	}
}