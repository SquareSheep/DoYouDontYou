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
IColor defaultStroke = new IColor(255,255,255,255);

/*

*/

PolySBox box;

float gw;
float gx = 4; float gy = 7; float gz = 4;

//Temporary computation variables
float temp, x,y,z, w,d, tick, r,g,b,a;

void render() {
	cam.ang.P.y += 0.003;
	if (timer.beat) println(song.position() + " " + (int)(currBeat+1));
	if (beatQ) {
		if (currBeat % 1 == 0) {
			box.setW(random(2,5),random(2,5),random(2,5));
		}

		if (currBeat % 0.5 == 0) {
			for (int i = 0 ; i < random(box.g.x*box.g.y*box.g.z)*10 ; i ++) {
				box.add(random(2), random(-10,10),random(-10,10),random(-10,10),0,0,0);
			}

			
			for (int i = 0 ; i < box.ar.size() ; i ++) {
				Poly mob = box.ar.get(i);
				if (mob.p.p.y < -gy*gw) {
					mob.finished = true;
				} else {
					switch ((int)random(2)) {
						case 0:
						mob.addAng((int)random(-2,3), (int)random(-2,3), (int)random(-2,3));
						case 1:
						mob.addP(randomD(),randomD(),randomD());
						break;
					}
					if (random(1) < 0.2) mob.die();
				}
			}
		}
	}
	tick = 0.01*frameCount;
	for (int i = 0 ; i < box.ar.size() ; i ++) {
		Poly mob = box.ar.get(i);
		x = mob.p.p.x/gw*0.1;
		y = mob.p.p.y/gw*0.1;
		z = mob.p.p.z/gw*0.1;
		r = noise(x,y,tick)*100+25;
		g = noise(y,tick)*100+25;
		b = noise(z,-y,tick)*100+25;
		IColorSet(mob.fillStyle,r,g,b,255, 125,125,125,0, 
			r*0.05,g*0.05,b*0.05,0, 0,0,0,0,	(float)i/box.ar.size()*binCount);
	}
}

void setSketch() {
	front = new PVector(de*2,de,de*0.2);
	back = new PVector(-de*2,-de,-de*2);

	gw = de*0.15;
	box = new PolySBox(0,0,0, 3,3,3, gw);
	mobs.add(box);
}