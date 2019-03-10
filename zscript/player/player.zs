
class GKPlayer : PlayerPawn {

	private int strength;
	private int dexterity;
	private int intelligence;

	private Array<String> memorizedSpells;
	private String currentSpell;

	default {
		Player.DisplayName "Gatekeeper";
		Player.StartItem "Fists";
		Player.StartItem "Bow";
		Player.StartItem "Hatchet";
		Player.StartItem "Pole";
		Player.StartItem "Battleaxe";
		Player.StartItem "ArrowAmmo", 99;
		Player.StartItem "FireGem", 99;
		Player.StartItem "EarthGem", 99;
		Player.StartItem "WindGem", 99;
		Player.StartItem "WaterGem", 99;
		Player.StartItem "PoisonGem", 99;
		Player.StartItem "LightningGem", 99;
		Player.StartItem "IceGem", 99;
		Player.StartItem "DarkGem", 99;
		Player.StartItem "LightGem", 99;
	}

	StateLabel getCurrentSpell() {
		return "FireSpell";
	}
}