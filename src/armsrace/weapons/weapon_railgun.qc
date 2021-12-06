void() SW_FireRailgun =
{
    self.punchangle_x = -5;

    player_rocket1();

    sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);

    self.currentammo = self.ammo_rockets -= 1;

    local vector start = self.origin + v_forward*8 + '0 0 16';
    local vector end = start + (v_forward * 1000);

    traceline(start,end,FALSE,self);

    dprint("START TRACE\n");

    local vector dir = normalize(end - start);
    local float dmg = 300;
    local entity oldEnt;
    while(trace_ent)
    {
        eprint(trace_ent);

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

    local float particleCount = vlen(start - end) / 32;

    local float i;
    for(i=0;i<particleCount;i++) {
        // Particle effects
        particle(start,dir,150,4);
        particle(start,dir,108,4);

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

    self.attack_finished = time + 1.5;
}