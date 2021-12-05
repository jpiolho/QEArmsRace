#define DEFINE_ARMSRACE_WEAPON(_qcname,_name,_items,_specialweapon,_attackfunc) entity() Armsrace_##_qcname =\
{\
    local entity ent = spawn();\
    ent.netname = _name;\
    ent.items = _items;\
    ent.specialweapon = _specialweapon;\
    ent.attackfunc = _attackfunc;\
    return ent;\
}

#define ARMSRACE_WEAPON(_qcname) Armsrace_##_qcname



DEFINE_ARMSRACE_WEAPON(Weapon_Axe,"Axe",IT_AXE,0,W_FireAxeWeapon);
DEFINE_ARMSRACE_WEAPON(Weapon_Shotgun,"Shotgun",IT_SHOTGUN,0,W_FireShotgun);
DEFINE_ARMSRACE_WEAPON(Weapon_SuperShotgun,"Super Shotgun",IT_SUPER_SHOTGUN,0,W_FireSuperShotgun);
DEFINE_ARMSRACE_WEAPON(Weapon_Nailgun,"Nailgun",IT_NAILGUN,0,W_FireNailgun);
DEFINE_ARMSRACE_WEAPON(Weapon_SuperNailgun,"Super Nailgun",IT_SUPER_NAILGUN,0,W_FireNailgun);
DEFINE_ARMSRACE_WEAPON(Weapon_GrenadeLauncher,"Grenade Launcher",IT_GRENADE_LAUNCHER,0,W_FireGrenade);
DEFINE_ARMSRACE_WEAPON(Weapon_RocketLauncher,"Rocket Launcher",IT_ROCKET_LAUNCHER,0,W_FireRocket);
DEFINE_ARMSRACE_WEAPON(Weapon_LightningGun,"Lightning Gun",IT_LIGHTNING,0,W_FireLightningGun);

DEFINE_ARMSRACE_WEAPON(Weapon_Laser,"Laser Gun",IT_LIGHTNING,ARW_LASER,SW_FireLaser);
DEFINE_ARMSRACE_WEAPON(Weapon_Flamethrower,"Flamethrower",IT_GRENADE_LAUNCHER,ARW_FLAME_THROWER,SW_FireFlameThrower);
DEFINE_ARMSRACE_WEAPON(Weapon_AcidSpitter,"Acid Spitter",IT_SHOTGUN,ARW_ACID_SPITTER,SW_FireAcidSpitter);



