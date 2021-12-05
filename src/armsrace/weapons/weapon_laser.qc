void() Laser_Touch;

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

    self.attack_finished = time + 0.25;
}