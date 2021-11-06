float() ArmsRace_Precache =
{
    precache_sound("misc/medkey.wav");
    precache_sound ("items/protect.wav");
	precache_sound ("items/protect2.wav");
	precache_sound ("items/protect3.wav");
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
    switch(level) {
        case 0: return "Lightning Gun";
        case 1: return "Rocket Launcher";
        case 2: return "Grenade Launcher";
        case 3: return "Super Nailgun";
        case 4: return "Nailgun";
        case 5: return "Super Shotgun";
        case 6: return "Shotgun";
        case 7: return "Axe";
    }
}

void(entity player) ArmsRace_GiveWeaponsToPlayer =
{
    // Remove weapons
    player.items = player.items - (player.items & (IT_AXE | IT_SHOTGUN | IT_SUPER_SHOTGUN | IT_NAILGUN | IT_SUPER_NAILGUN | IT_ROCKET_LAUNCHER | IT_LIGHTNING));

    switch(ArmsRace_GetPlayerLevel(player)) {
        case 0:
            player.items |= IT_LIGHTNING;
            player.ammo_cells = 200;
            player.weapon = IT_LIGHTNING;
            break;
        case 1:
            player.items |= IT_ROCKET_LAUNCHER;
            player.ammo_rockets = 100;
            player.weapon = IT_ROCKET_LAUNCHER;
            break;
        case 2:
            player.items |= IT_GRENADE_LAUNCHER;
            player.ammo_rockets = 100;
            player.weapon = IT_GRENADE_LAUNCHER;
            break;
        case 3:
            player.items |= IT_SUPER_NAILGUN;
            player.ammo_nails = 200;
            player.weapon = IT_SUPER_NAILGUN;
            break;
        case 4:
            player.items |= IT_NAILGUN;
            player.ammo_nails = 200;
            player.weapon = IT_NAILGUN;
            break;
        case 5:
            player.items |= IT_SUPER_SHOTGUN;
            player.ammo_shells = 100;
            player.weapon = IT_SUPER_SHOTGUN;
            break;
        case 6:
            player.items |= IT_SHOTGUN;
            player.ammo_shells = 100;
            player.weapon = IT_SHOTGUN;
            break;
        case 7:
            player.items |= IT_AXE;
            player.weapon = IT_AXE;
            break;
        default:
            dprint("Unknown level!\n");
            break;
    }


}

void() Armsrace_Initialize =
{
    armsrace_lastLevel = 7;
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
    if(level == 8)
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

    if(level != armsrace_lastLevel) {
        centerprint(player,"You are now level ",ftos(level+1),"!\n",ArmsRace_GetLevelName(level));
    }
    else {
        centerprint(player,"You are now level ",ftos(level+1),"!\n",ArmsRace_GetLevelName(level),"\n\nLast level!");
    }

    sound(player, CHAN_VOICE, "misc/medkey.wav",1, ATTN_IDLE);
    localsound(player,"misc/medkey.wav");
}