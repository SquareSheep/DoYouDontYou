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
static float volumeGain = -9;
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
PolySBox box2;
ArrayList<PolyS> ar2;

void render() {
	//cam.ang.P.add(-0.01,-0.01,0);
	if (beatQ) {
		instantEvents();
	}
}

void setSketch() {
	front = new PVector(de*2,de,de*0.2);
	back = new PVector(-de*2,-de,-de*2);
	strokeWeight(1);

	box = new PolySBox(0,0,0, 3,3,3, de*0.16);
	ar = box.ar;
	mobs.add(box);

	box2 = new PolySBox(0,0,0, 3,3,3, de*0.16);
	ar2 = box2.ar;
	mobs.add(box2);

	setTime(104420,201);
	currBeat += 0.25;
}