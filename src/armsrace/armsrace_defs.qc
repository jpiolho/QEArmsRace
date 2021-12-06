#define specialweapon lip
#define attackfunc blocked

float PEFL_SEEN_INTRO_MESSAGE = 1;
float PEFL_IGNORE_NEXT_INVULNERABILITY_MESSAGE = 2;



float ARW_AXE = 0;
float ARW_SHOTGUN = 1;
float ARW_SUPER_SHOTGUN = 2;
float ARW_NAILGUN = 3;
float ARW_SUPER_NAILGUN = 4;
float ARW_GRENADE_LAUNCHER = 5;
float ARW_ROCKET_LAUNCHER = 6;
float ARW_LIGHTING_GUN = 7;

float ARW_LASER = 8;
float ARW_FLAME_THROWER = 9;
float ARW_ACID_SPITTER = 10;
float ARW_RAILGUN = 11;



typedef struct
{
    string name;
    float items;
    float specialweapon;
} armsraceweapon_t;