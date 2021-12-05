void(entity ent) AcidSpitter_Spit_Damage =
{
    T_Damage(ent,self,self.owner,8);

    if(ent.classname == "player" && ent.deadflag != DEAD_NO) {
        local entity oself = self;
        self = ent;

        local float waterType = self.watertype;
        self.watertype = CONTENT_SLIME;
        PainSound();
        self.watertype = waterType;

        self = oself;
    }
}

void() AcidSpitter_Spit_Landed_Think =
{
    // Find players close by and give them damage
    local entity ent = findradius(self.origin,48);

    local float hit = FALSE;

    while(ent) {

        if(ent.takedamage != DAMAGE_NO)
        {
            AcidSpitter_Spit_Damage(ent);
            hit = TRUE;
        }
        ent = ent.chain;
    }


    // Effect + next think
    local vector v = self.origin;
    v += self.finalangle * crandom() * 10;
    particle(v,self.finalangle,63,8);
    self.nextthink = time + 0.15;


    // If hit, remove self
    if(hit) {
        sound(self,CHAN_VOICE,"wizard/hit.wav",1, ATTN_NORM);
        remove(self);
        return;
    }

    // Destroy itself if the time is up
    if(time >= self.waitmax)
        remove(self);
}

void() AcidSpitter_Spit_Touch =
{
    // Landed!
    self.movetype = MOVETYPE_NONE;
    self.solid = SOLID_NOT;

    sound(self,CHAN_VOICE,"wizard/hit.wav",1, ATTN_NORM);

    if(other.takedamage != DAMAGE_NO) {
        AcidSpitter_Spit_Damage(other);
        remove(self);
        return;
    }


    traceline(self.origin,self.origin + self.velocity, TRUE,self);
    self.finalangle = trace_plane_normal;

    self.waitmax = time + 5.0;
    self.think = AcidSpitter_Spit_Landed_Think;
    self.nextthink = time + 0.15;
}

void() AcidSpitter_Spit_Think =
{
    particle(self.origin,'0 0 0',63,8);

    self.nextthink = time + 0.05;

    // Remove itself if it expired
    if(time >= self.waitmax)
        remove(self);
}

void() SW_FireAcidSpitter
{
    self.punchangle_x = -4;

    player_shot1();

    sound(self,CHAN_WEAPON,"player/h2ojump.wav",1, ATTN_NORM);

    local float i;
    for(i=0;i<10;i++) {
        if(self.ammo_shells <= 0)
            break;

        newmis = spawn();
        newmis.owner = self;
        newmis.movetype = MOVETYPE_BOUNCE;
        newmis.solid = SOLID_BBOX;

        setsize (newmis, '0 0 0', '0 0 0');

        local vector sumVec = v_right * ((i * 4) - 4);
        setorigin (newmis, self.origin + v_forward*8 + '0 0 16' + sumVec);

        makevectors (self.v_angle);
        newmis.velocity = aim(self, 1000) + (crandom() * v_right * 0.1) + (crandom() * v_up * 0.1) + (v_up * 0.1);
        newmis.velocity *= 800;
        newmis.angles = vectoangles(newmis.velocity);

        newmis.waitmax = time + 2.0;
        newmis.nextthink = time + 0.1;
        newmis.think = AcidSpitter_Spit_Think;
        newmis.touch = AcidSpitter_Spit_Touch;
    }

    self.currentammo = self.ammo_shells -= 2;
    self.attack_finished = time + 2.0;
}