
class GKEttin : GKMonster replaces Ettin {

	Default
	{
		Health 175;
		Radius 25;
		Height 68;
		Mass 175;
		Speed 13;
		Damage 3;
		Painchance 60;
		Monster;
		+FLOORCLIP
		+TELESTOMP
		SeeSound "EttinSight";
		AttackSound "EttinAttack";
		PainSound "EttinPain";
		DeathSound "EttinDeath";
		ActiveSound "EttinActive";
		HowlSound "PuppyBeat";
		Obituary "$OB_ETTIN";
		Tag "$FN_ETTIN";
	}
	States
	{
	Spawn:
		ETTN AA 10 A_Look;
		Loop;
	See:
		ETTN ABCD 5 A_Chase;
		Loop;
	Pain:
		ETTN H 7 A_Pain;
		Goto See;
	Melee:
		ETTN EF 6 A_FaceTarget;
		ETTN G 8 A_CustomMeleeAttack(random[EttinAttack](1,8)*2);
		Goto See;
	Death:
		ETTN IJ 4;
		ETTN K 4 A_Scream;
		ETTN L 4 A_NoBlocking;
		ETTN M 4 A_QueueCorpse;
		ETTN NOP 4;
		ETTN Q -1;
		Stop;
	Ice:
		ETTN R 5 A_FreezeDeath;
		ETTN R 1 A_FreezeDeathChunks;
		Wait;
	}

	override int forgetTicks() {
		return 15*35;
	}

}