static float bpm = 115;
static float beatInc = 0.5;
static int threshold = 100;
static int offset = -100;
static int binCount = 144;
static float defaultMass = 6;
static float defaultVMult = 0.1;
static float fillMass = 6;
static float fillVMult = 0.1;
static float fftThreshold = 1.2;
static float fftPow = 1.9;
static float fftAmp = 3;
static float volumeGain = -9;
static String songName = "../Music/doyoudontyou.mp3";

IColor defaultFill = new IColor(0,0,0,0);
IColor defaultStroke = new IColor(255,255,255,0);

PolyS mob;
/*
SYSTEM CHANGES

PolyS EXTENDS Mob
PolyS has an OBJECT POOL
PolyS DOES NOT HAVE vertices or faces

Remember Glacier? Try something like that

Polys are still grid-locked, with special animation functions etc

Additional behavior is that they can spawn more of themselves, in cascading patterns

PolySBoxes can also be used to spawn Polys based on pitches

*/

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
	if (beatQ) {
		instantEvents();
	}
	push();
	rotateX(box.ang.p.x);
	rotateY(box.ang.p.y);
	rotateZ(box.ang.p.z);
	fill(10,15,40);
	box(de*5,de*2.5,de*5);
	pop();
}

void setSketch() {
	front = new PVector(de*2,de,de*0.2);
	back = new PVector(-de*2,-de,-de*2);
	strokeWeight(2);

	box = new PolySBox(0,0,0, 6,4,6, de*0.14);
	ar = box.ar;
	mobs.add(box);

	// box2 = new PolySBox(0,0,0, 5,5,5, de*0.13);
	// ar2 = box2.ar;
	// mobs.add(box2);

	setTime(102330,197.25);
}