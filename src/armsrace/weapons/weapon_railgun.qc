void() SW_Railgun_Effect_Think =
{
    local float i;

    for(i=0;i<self.volume && self.cnt > 0;i++,self.cnt--) {
        // Particle effects
        managed_particle(self.origin,self.pos1 * 10,150,8);
        managed_particle(self.origin,self.pos1 * 10,111,8);

        // Play close encounter sound
        local entity closeby = findradius(self.origin,64);
        while(closeby) {
            if(closeby.classname == "player") {
                localsound(closeby,"enforcer/enfstop.wav");
            }
            closeby = closeby.chain;
        }

        self.origin += self.pos1 * self.distance;
    }

    if(self.cnt <= 0)
        remove(self);

    self.nextthink = time;
}

void() SW_FireRailgun =
{
    self.punchangle_x = -5;

    player_rocket1();

    sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);

    self.currentammo = self.ammo_rockets -= 1;

    local vector start = self.origin + v_forward*8 + '0 0 16';
    local vector end = start + (v_forward * 5000);

    traceline(start,end,FALSE,self);


    local vector dir = normalize(end - start);
    local float dmg = 300;
    local entity oldEnt;
    while(trace_ent)
    {

        if(trace_ent.takedamage != DAMAGE_NO)
        {
            T_Damage(trace_ent,self,self,dmg);

            if(trace_ent.flags & (FL_MONSTER | FL_CLIENT) && trace_ent.health <= 0) {

                // Continue the trace if the thing hasn't died
                dmg *= 0.5;

                oldEnt = trace_ent;
                traceline(trace_endpos,end,FALSE,oldEnt);

                if(oldEnt == trace_ent)
                    break;
            }
            else {
                break;
            }
        }
        else {
            break;
        }
    }


    end = trace_endpos;

    local float len = vlen(start - end);
    local float particleCount = len / 48;

    local entity effect = spawn();
    effect.origin = start;
    effect.classname = "railgun_effect";
    effect.think = SW_Railgun_Effect_Think;
    effect.nextthink = time;
    effect.distance = 48;
    effect.volume = 3;
    effect.pos1 = dir;
    effect.pos2 = end;
    effect.cnt = particleCount;

    /*
        local float i;
        for(i=0;i<particleCount;i++) {

            // Particle effects
            managed_particle(start,dir * 10,150,8);

                // Play close encounter sound
                local entity closeby = findradius(start,64);
                while(closeby) {
                    if(closeby.classname == "player") {
                        localsound(closeby,"enforcer/enfstop.wav");
                    }
                    closeby = closeby.chain;
                }


            start += dir * 32;

        }
    */
    managed_particle(end,'0 0 0',15,16);

    self.attack_finished = time + 1.5;
    //self.attack_finished = time;
}