static float bpm = 115;
static float beatInc = 0.5;
static int threshold = 100;
static int offset = -50;
static int binCount = 144;
static float defaultMass = 10;
static float defaultVMult = 0.5;
static float fillMass = 10;
static float fillVMult = 0.5;
static float fftThreshold = 1.5;
static float fftPow = 1.8;
static float fftAmp = 10;
static float volumeGain = -8;
static String songName = "../Music/doyoudontyou.mp3";

IColor defaultFill = new IColor(222,125,222,255);
IColor defaultStroke = new IColor(0,0,0,0);

/*

*/

float gw;
float gx = 10; float gy = 10; float gz = 10;

//Temporary computation variables
float temp, x,y,z, w,d,r, tick;

void render() {
	cam.ang.P.y += 0.003;
	if (timer.beat) println(song.position() + " " + (int)(currBeat+1));
	if (beatQ) {
		if (currBeat % 0.5 == 0) {
			y = gy;
			for (int i = 0 ; i < random(100) ; i ++) {
				x = (int)random(-gx,gx);
				z = (int)random(-gz,gz);
				mobs.add(newPoly(random(3), x*gw,y*gw,z*gw,0,0,0,gw/2));
			}

			
			for (int i = 0 ; i < mobs.size() ; i ++) {
				Poly mob = (Poly) mobs.get(i);
				if (mob.p.p.y < -gy*gw) {
					mob.finished = true;
				} else {
					mob.p.P.y -= gw;
					switch ((int)random(1)) {
						case 0:
						mob.addAng((int)random(-2,3), (int)random(-2,3), (int)random(-2,3));
						break;
					}

					if (random(1) < 0.15) {
						mob.pulse();
					}
					if (random(1) < 0.1) {
						mob.die();
					}
				}
			}
		}
	}
	tick = 0.01*frameCount;
	for (int i = 0 ; i < mobs.size() ; i ++) {
		Poly mob = (Poly)mobs.get(i);
		x = mob.p.p.x/gw*0.1;
		y = mob.p.p.y/gw*0.1;
		z = mob.p.p.z/gw*0.1;
		mob.fillStyleSet(true,noise(x,y,tick)*200+55,noise(y,tick)*200+55,noise(z,-y,tick)*200+55,0, 125,125,125,0, 
			0,0,0,8, 0,0,0,0,	(float)i/mobs.size()*binCount);
	}
}

void setSketch() {
	front = new PVector(de*2,de,de*0.2);
	back = new PVector(-de*2,-de,-de*2);
	gw = de*0.15;
	y = gy;
}