static float bpm = 110;//115;//Doyoudontyou
static float beatInc = 0.5;
static int threshold = 100;
static int offset = -50;
static int binCount = 144;
static float defaultMass = 5;
static float defaultVMult = 0.25;
static float fillMass = 5;
static float fillVMult = 0.25;
static float fftThreshold = 1.7;
static float fftPow = 2;
static float fftAmp = 5;
static float volumeGain = -8;
static String songName = "../Music/arewestillyoung.mp3";

IColor defaultFill = new IColor(0,0,0,255);
IColor defaultStroke = new IColor(255,255,255,255);

/*

*/

float gw;
float gx = 4; float gy = 7; float gz = 4;

//Temporary computation variables
float temp, x,y,z, w,d, tick, r,g,b,a;
float amp = 0.01;

void render() {
	//noFill();
	cam.ang.P.add(0.001,-0.003,-0.001);
	if (timer.beat) println(song.position() + " " + (int)(currBeat+1));
	if (beatQ) {
		for (int o = 0 ; o < mobs.size() ; o ++) {
			PolySBox box = (PolySBox)mobs.get(o);
			if (currBeat % 4 == 0) box.ang.P.add(0,0,PI);
			if (currBeat % 4 == 2) box.ang.P.add(PI,0,0);
			if (currBeat % 1 == 0.25) box.setW(2,2,2);
			if (currBeat % 1 == 0.75) box.setW(3,3,3);

			if (currBeat % 0.5 == 0) {
				for (int i = 0 ; i < random(box.g.x*box.g.y*box.g.z)*3 ; i ++) {
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
	}
	for (int o = 0 ; o < mobs.size() ; o ++) {
		PolySBox box = (PolySBox)mobs.get(o);
		tick = 0.01*frameCount;
		for (int i = 0 ; i < box.ar.size() ; i ++) {
			Poly mob = box.ar.get(i);
			x = mob.p.p.x/gw*0.3;
			y = mob.p.p.y/gw*0.3;
			z = mob.p.p.z/gw*0.3;
			r = noise(x,y,tick+o*100)*225+25;
			g = noise(y,tick+o*100)*225+25;
			b = noise(z,-y,tick+o*100)*225+25;
			IColorSet(mob.fillStyle,r,g,b,0, 125,125,125,0, 
				r*amp*0.3,g*amp*0.3,b*amp*0.3,1, 0,0,0,0,	(float)i/box.ar.size()*binCount);
			IColorSet(mob.strokeStyle,r,g,b,0, 125,125,125,0, 
				r*amp,g*amp,b*amp,1, 0,0,0,0,	(float)i/box.ar.size()*binCount);
		}
	}
}

void setSketch() {
	front = new PVector(de*2,de,de*0.2);
	back = new PVector(-de*2,-de,-de*2);
	strokeWeight(3);
	gw = de*0.1;
	int w = 3;
	mobs.add(new PolySBox(-w,-w,-w, w,w,w, gw));
	mobs.add(new PolySBox(w,-w,-w, w,w,w, gw));
	mobs.add(new PolySBox(w,-w,w, w,w,w, gw));
	mobs.add(new PolySBox(w,w,w, w,w,w, gw));
	mobs.add(new PolySBox(w,w,-w, w,w,w, gw));
	mobs.add(new PolySBox(-w,w,-w, w,w,w, gw));
	mobs.add(new PolySBox(-w,w,w, w,w,w, gw));
	mobs.add(new PolySBox(-w,-w,w, w,w,w, gw));
}