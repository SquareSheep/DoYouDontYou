static float bpm = 115;
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
static float volumeGain = -33;
static String songName = "../Music/doyoudontyou.mp3";

IColor defaultFill = new IColor(0,0,0,255);
IColor defaultStroke = new IColor(255,255,255,255);

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

float gw;
float gx = 4; float gy = 7; float gz = 4;

RingPool rings = new RingPool();

void render() {
	rings.update();
	rings.render();

	cam.ang.P.add(0.001,-0.003,-0.001);
	if (beatQ) {
		PolySBox box = (PolySBox)mobs.get(0);

		if (currBeat % 0.5 == 0) {
			for (int i = 0 ; i < random(box.g.x*box.g.y)*30 ; i ++) {
				box.add(1, random(-10,10),random(-10,10),-box.g.z,0,0,0);
			}

			for (int i = 0 ; i < box.ar.size() ; i ++) {
				PolyS mob = box.ar.get(i);
				if (mob.p.p.y < -gy*gw) {
					mob.finished = true;
				} else {
					mob.addAng((int)random(-2,3), (int)random(-2,3), (int)random(-2,3));
					mob.addP(0,0,1);
					if (random(1) < 0.2) mob.die();
				}
			}
		}
	}
}

void setSketch() {
	front = new PVector(de*2,de,de*0.2);
	back = new PVector(-de*2,-de,-de*2);
	strokeWeight(3);

	gw = de*0.1;
	mobs.add(new PolySBox(0,0,0,10,10,25,gw));
}