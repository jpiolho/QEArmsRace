float armsrace_totalLevels;
var entity() armsrace_levels[20];

void() ArmsRace_Precache =
{
    precache_sound ("misc/medkey.wav");
    precache_sound ("items/protect.wav");
	precache_sound ("items/protect2.wav");
	precache_sound ("items/protect3.wav");

    precache_sound ("enforcer/enfire.wav");
    precache_sound ("enforcer/enfstop.wav");
    precache_model ("progs/laser.mdl");

    precache_sound ("buttons/airbut1.wav");

    precache_sound ("wizard/hit.wav");
}

float() ArmsRace_KillsPerLevel =
{
    local float customKills = cvar("saved4");
    return customKills == 0 ? 2 : customKills;
}


float(entity player) ArmsRace_GetPlayerLevel =
{
    return floor(player.frags / ArmsRace_KillsPerLevel());
}

string(float level) ArmsRace_GetLevelName =
{
    if(level < 0 || level >= armsrace_totalLevels)
        return "Unknown";

    local entity ent = armsrace_levels[level]();
    local string name = ent.netname;
    remove(ent);

    return name;
}

void(entity player) ArmsRace_GiveWeaponsToPlayer =
{
    // Remove weapons
    player.items -= (player.items & (IT_AXE | IT_SHOTGUN | IT_SUPER_SHOTGUN | IT_NAILGUN | IT_SUPER_NAILGUN | IT_ROCKET_LAUNCHER | IT_LIGHTNING));
    player.specialweapon = 0;

    local float level = ArmsRace_GetPlayerLevel(player);

    local entity wep = armsrace_levels[level]();

    player.items |= wep.items;
    player.weapon = wep.items;
    player.specialweapon |= wep.specialweapon;
    player.attackfunc = wep.attackfunc;

    player.ammo_cells = 200;
    player.ammo_rockets = 100;
    player.ammo_nails = 200;
    player.ammo_shells = 200;

    remove(wep);
}

void(entity() callback) Armsrace_AddLevel =
{
    armsrace_levels[armsrace_totalLevels++] = callback;
}

void() Armsrace_Initialize =
{
    local float weaponSet = cvar("saved1");


    armsrace_totalLevels = 0;


    switch(weaponSet) {
        default:
        case 0:
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_LightningGun));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_RocketLauncher));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_GrenadeLauncher));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_SuperNailgun));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_Nailgun));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_SuperShotgun));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_Shotgun));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_Axe));
            break;

        case 1:
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_Railgun));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_LightningGun));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_RocketLauncher));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_GrenadeLauncher));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_Laser));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_SuperNailgun));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_AcidSpitter));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_Nailgun));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_Flamethrower));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_SuperShotgun));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_Shotgun));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_Axe));
            break;

        case 2:
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_LightningGun));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_RocketLauncher));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_GrenadeLauncher));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_SuperNailgun));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_Nailgun));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_SuperShotgun));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_Shotgun));
            break;

        case 3:
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_Axe));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_Shotgun));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_SuperShotgun));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_Nailgun));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_SuperNailgun));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_GrenadeLauncher));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_RocketLauncher));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_LightningGun));
            break;

        case 4:
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_Railgun));
            break;

        case 5:
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_Railgun));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_Laser));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_AcidSpitter));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_Flamethrower));
            Armsrace_AddLevel(ARMSRACE_WEAPON(Weapon_Axe));
            break;
    }

}


void(entity player) ArmsRace_PrintSpawnMessage =
{
    local float killsPerLevel = ArmsRace_KillsPerLevel();
    local float lvl = ArmsRace_GetPlayerLevel(player);
	sprint(player,"You're level ");
    sprint(player,ftos(lvl+1));
    sprint(player," - ");
    sprint(player,ArmsRace_GetLevelName(lvl));
    sprint(player," (");
    sprint(player,ftos(player.frags % killsPerLevel));
    sprint(player,"/");
    sprint(player,ftos(killsPerLevel));
    sprint(player,")\n");
}

void(entity player,float level) ArmsRace_LevelUp =
{
    if(level == armsrace_totalLevels)
    {
        bprint(player.netname);
        bprint(" scored the winning kill!\n");

        NextLevel();
        return;
    }

    if(player.deadflag == DEAD_NO)
    {
        ArmsRace_GiveWeaponsToPlayer(player);

        local entity oself = self;
        self = player;
        W_SetCurrentAmmo();
        self = oself;
    }

    if(level != (armsrace_totalLevels-1)) {
        centerprint(player,"You are now level {}!\n{}",ftos(level+1),ArmsRace_GetLevelName(level));
    }
    else {
        centerprint(player,"You are now level {}!\n{}\n\nLast level!",ftos(level+1),ArmsRace_GetLevelName(level));
    }

    sound(player, CHAN_VOICE, "misc/medkey.wav",1, ATTN_IDLE);
    localsound(player,"misc/medkey.wav");
}