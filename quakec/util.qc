float particleCountThisFrame;

void(vector o, vector d, float color, float count) managed_particle =
{
    if(particleCountThisFrame >= 50)
        return;

    particleCountThisFrame++;
    particle(o,d,color,count);
}