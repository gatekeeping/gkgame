
class FireTrail : GKSpell {
	override statelabel getLabel() { 
		return "FireTrail"; 
	}
	
	override int getManaCost() { 
		return 10; 
	}
}

class FireTrailTimeout : Timeout {
	override int tickCount() {
		return 70;
	}	
}