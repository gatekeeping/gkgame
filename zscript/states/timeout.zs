
class Timeout : Inventory {
	protected int timer;
	default { Inventory.MaxAmount 1; }
	virtual int tickCount() {
		return 0;
	}	
	override void AttachToOwner(Actor user) {
		timer = tickCount();
		super.AttachToOwner(user);
	}
    override void DoEffect() {
		timer--;
		if(timer <= 0)
			owner.RemoveInventory(self);
    }	
    override void OwnerDied() {
    	owner.RemoveInventory(self);
    }
}