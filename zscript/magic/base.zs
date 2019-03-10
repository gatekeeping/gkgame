class GKSpell {
	virtual statelabel getLabel() { 
		return "Ready"; 
	}
	
	virtual int getManaCost() { 
		return 0; 
	}
	
	virtual int getTimeout() { 
		return 0; 
	}
}
