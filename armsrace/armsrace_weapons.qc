#define DEFINE_ARMSRACE_WEAPON(_qcname,_name,_items,_specialweapon) entity() Armsrace_##_qcname =\
{\
    local entity ent = spawn();\
    ent.netname = _name;\
    ent.items = _items;\
    ent.specialweapon = _specialweapon;\
    return ent;\
}

#define ARMSRACE_WEAPON(_qcname) Armsrace_##_qcname



DEFINE_ARMSRACE_WEAPON(Weapon_Axe,"Axe",IT_AXE,0);
DEFINE_ARMSRACE_WEAPON(Weapon_Shotgun,"Shotgun",IT_SHOTGUN,0);
DEFINE_ARMSRACE_WEAPON(Weapon_SuperShotgun,"Super Shotgun",IT_SUPER_SHOTGUN,0);
DEFINE_ARMSRACE_WEAPON(Weapon_Nailgun,"Nailgun",IT_NAILGUN,0);
DEFINE_ARMSRACE_WEAPON(Weapon_SuperNailgun,"Super Nailgun",IT_SUPER_NAILGUN,0);
DEFINE_ARMSRACE_WEAPON(Weapon_GrenadeLauncher,"Grenade Launcher",IT_GRENADE_LAUNCHER,0);
DEFINE_ARMSRACE_WEAPON(Weapon_RocketLauncher,"Rocket Launcher",IT_ROCKET_LAUNCHER,0);
DEFINE_ARMSRACE_WEAPON(Weapon_LightningGun,"Lightning Gun",IT_LIGHTNING,0);

DEFINE_ARMSRACE_WEAPON(Weapon_Laser,"Laser Gun",IT_LIGHTNING,ARW_LASER);
DEFINE_ARMSRACE_WEAPON(Weapon_Flamethrower,"Flamethrower",IT_GRENADE_LAUNCHER,ARW_FLAME_THROWER);




void(entity target,float direct) Flame_DoDamage =
{
    local float dmg = (direct ? 50 : 30) * (1 - (self.frame / 7));

    traceline(self.origin,target.origin,FALSE,self);

    if(trace_ent != target)
        SpawnBlood (self.origin - 8*normalize(self.velocity), self.velocity*0.2, dmg);
    else
        SpawnBlood (trace_endpos, self.velocity*0.2, dmg);

    T_Damage (target, self, self.owner, dmg);
}

void() Flame_Think =
{
    self.frame++;

    if(self.frame >= 6)
    {
        remove(self);
        return;
    }


    local entity p;
    while((p = find(p,classname,"player")))
    {
        if(p != self.owner && vlen(p.origin - self.origin) < 16) {
            Flame_DoDamage(p,FALSE);
        }
    }

    self.nextthink = time + 0.1;
}

void() Flame_Touch =
{	
	if (other == self.owner)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	
	
	if (other.health)
	{
        Flame_DoDamage(other,TRUE);
	}
	
	remove(self);	
}

void() SW_FireFlameThrower =
{
    self.punchangle_x = -2;

    self.currentammo = --self.ammo_rockets;

    
    
    
    newmis = spawn();
    
    newmis.owner = self;
    newmis.movetype = MOVETYPE_FLYMISSILE;
    newmis.solid = SOLID_BBOX;
    newmis.effects = EF_DIMLIGHT;

    setmodel(newmis, "progs/s_explod.spr");
    setsize (newmis, '0 0 0','0 0 0');		

    setorigin (newmis, self.origin + v_forward*8 + '0 0 16');

    makevectors (self.v_angle);
    newmis.velocity = aim(self, 1000);
    newmis.velocity *= 500;
    newmis.angles = vectoangles(newmis.velocity);

    newmis.nextthink = time + 0.1;
    newmis.think = Flame_Think;
    newmis.touch = Flame_Touch;

    sound (newmis, CHAN_WEAPON, "buttons/airbut1.wav", 1, ATTN_NORM);
}

void() SW_FireLaser =
{
    
    self.punchangle_x = -2;

    sound (self, CHAN_WEAPON, "enforcer/enfire.wav", 1, ATTN_NORM);
    
    local float i;
    for(i=0;i<3;i++) {
        if(self.ammo_cells <= 0)
            break;
        
        self.currentammo = --self.ammo_cells;

        newmis = spawn();
        newmis.owner = self;
        newmis.movetype = MOVETYPE_FLY;
        newmis.solid = SOLID_BBOX;
        newmis.effects = EF_DIMLIGHT;

        setmodel (newmis, "progs/laser.mdl");
        setsize (newmis, '0 0 0', '0 0 0');		

        local vector sumVec = v_right * ((i * 4) - 4);
        setorigin (newmis, self.origin + v_forward*8 + '0 0 16' + sumVec);

        makevectors (self.v_angle);
        newmis.velocity = aim(self, 1000);
        newmis.velocity *= 800;
        newmis.angles = vectoangles(newmis.velocity);

        newmis.nextthink = time + 5;
        newmis.think = SUB_Remove;
        newmis.touch = Laser_Touch;
    }
}