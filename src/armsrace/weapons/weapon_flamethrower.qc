void(vector org, vector vel, float damage) SpawnBlood;


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
        if(p != self.owner && vlen(p.origin - self.origin) < 24) {
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

    player_rocket1();
    self.attack_finished = time + 0.15;

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
    newmis.velocity *= 650;
    newmis.angles = vectoangles(newmis.velocity);

    newmis.nextthink = time + 0.1;
    newmis.think = Flame_Think;
    newmis.touch = Flame_Touch;

    sound (newmis, CHAN_WEAPON, "buttons/airbut1.wav", 1, ATTN_NORM);
}
