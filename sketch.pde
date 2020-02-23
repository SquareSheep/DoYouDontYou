static float bpm = 170;
static float beatInc = 0.5;
static int threshold = 100;
static int offset = -350;
static int binCount = 144;
static float defaultMass = 10;
static float defaultVMult = 0.5;
static float fillMass = 10;
static float fillVMult = 0.5;
static float fftThreshold = 1.5;
static float fftPow = 1.8;
static float fftAmp = 10;
static float volumeGain = -10;
static String songName = "../Music/onetwo.mp3";

IColor defaultFill = new IColor(222,125,222,255);
IColor defaultStroke = new IColor(255,255,255,255);

void render() {
	if (timer.beat) println(song.position() + " " + (int)(currBeat+1));
}

void setSketch() {
	front = new PVector(de*2,de,de*0.2);
	back = new PVector(-de*2,-de,-de*2);
}