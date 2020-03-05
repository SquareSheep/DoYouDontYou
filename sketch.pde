static float bpm = 115;
static float beatInc = 0.5;
static int threshold = 100;
static int offset = -100;
static int binCount = 144;
static float defaultMass = 5;
static float defaultVMult = 0.25;
static float fillMass = 5;
static float fillVMult = 0.25;
static float fftThreshold = 1.7;
static float fftPow = 2;
static float fftAmp = 5;
static float volumeGain = -10;
static String songName = "../Music/doyoudontyou.mp3";

IColor defaultFill = new IColor(125,125,125,255);
IColor defaultStroke = new IColor(255,255,255,0);

/*
Animation consists of PolyS objects and PolySBox containers

PolyS
Extends Poly, extends MobFL
PolyS have special animations:
	Spawn: On spawning, emits an expanding, fading, hollow square (See Rule 101)
	Turn: Turns in increments of PI/2
	Move: Translates by increments of grid width
	Flash: Briefly sets fill to all one color
	Pulse: Briefly increases scale
	Blink: Briefly becomes invisible (Similar to Flash)
	Emit: Emits an expanding shape effect
	Die: Shrinks until 0, then despawns

Ring
Particle-like effect, stored in object pool
Spawned by PolS objects
Rings expand until they reach a set maximum, then despawn
Rings can have different shapes:
	Square/Rectangle
	Scattered squares
	Ring of outward lines
*/

PolySBox box;
ArrayList<PolyS> ar;

void render() {
	//cam.ang.P.add(-0.01,-0.01,0);
	if (beatQ) {
		instantEvents();

		// if (currBeat % 0.5 == 0) {
		// 	for (int i = 0 ; i < random(box.g.x*box.g.y)*10 ; i ++) {
		// 		box.add(random(3), random(-box.g.x,box.g.x),random(-box.g.y,box.g.y),-box.g.z,0,0,0);
		// 	}

		// 	for (int i = 0 ; i < box.ar.size() ; i ++) {
		// 		PolyS mob = box.ar.get(i);
		// 		if (mob.p.p.z >= box.w.p.z-box.gw || random(1) < 0.1) {
		// 			mob.die();
		// 		} else {
		// 			mob.addAng((int)random(-2,3), (int)random(-2,3), (int)random(-2,3));
		// 			mob.addP(0,0,1);
		// 		}

		// 		t = (float)frameCount/100;
		// 		x = mob.p.p.x/box.w.p.x*6;
		// 		y = mob.p.p.y/box.w.p.y*6;
		// 		z = mob.p.p.z/box.w.p.z*6;

		// 		r = noise(x,t)*175;
		// 		g = noise(y,t)*175;
		// 		b = noise(z,t)*175;
		// 		sAmp = 0.018;
		// 		fillStyleSet(mob.fillStyle, r,g,b,175, 
		// 			r*sAmp,g*sAmp,b*sAmp,1, ((float)i/box.ar.size()*binCount)%binCount);

		// 		fillStyleSet(mob.strokeStyle, 0,0,0,0, 
		// 			r*sAmp,g*sAmp,b*sAmp,4, mob.fillStyle[0].index);
		// 	}
		// }
	}
}

void setSketch() {
	front = new PVector(de*2,de,de*0.2);
	back = new PVector(-de*2,-de,-de*2);
	strokeWeight(1);

	box = new PolySBox(0,0,0,5,5,5,de*0.16);
	ar = box.ar;
	mobs.add(box);

	setTime(104420,201);
	currBeat += 0.25;
}