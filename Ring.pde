float ringWMass = 25;
float ringWVMult = 0.6;
float ringWThreshold = 0.9;
class Ring extends Entity {
	Point p = new Point();
	SpringValue w = new SpringValue(0, ringWVMult, ringWMass);
	float wMax;
	float amp;
	IColor fillStyle = new IColor(255,255,255,255);
	int type = 0;

	Ring(int type, float x, float y, float z, float w, float wMax, float amp) {
		this.p.reset(x,y,z);
		this.w.reset(w,wMax, ringWVMult,ringWMass);
		this.wMax = wMax;
		this.amp = amp;
		this.type = type;
	}

	Ring() {}

	void update() {
		p.update();
		w.update();
		fillStyle.update();
		if (w.x >= wMax*ringWThreshold) finished = true;
	}

	void render() {
		push();
		translate(p.p.x,p.p.y,p.p.z);
		switch(type) {
			case 0:
			fillStyle.strokeStyle();
			noFill();
			strokeWeight((wMax*ringWThreshold-w.x)*amp);
			rect(0,0,w.x,w.x);
			break;
			case 1:
			fillStyle.fillStyle();
			noStroke();
			rect(0,0,wMax-w.x,wMax-w.x);
			break;
			case 2:
			fillStyle.fillStyle();
			noStroke();
			rect(0,-w.x,wMax,wMax-w.x);
			rect(0,w.x,wMax,wMax-w.x);
			break;
		}
		pop();
	}
}

class RingPool extends ObjectPool<Ring> {

	void set(Ring mob, int type, float x, float y, float z, float w, float wMax, float amp) {
		mob.p.reset(x,y,z);
		mob.w.x = w;
		mob.w.X = wMax;
		mob.w.v = 0;
		mob.wMax = wMax;
		mob.amp = amp;
		mob.type = type;
		mob.finished = false;
	}

	void add(int type, PolyS parent, float x, float y, float z, float w, float wMax, float amp) {
		if (arm == ar.size()) {
			ar.add(new Ring());
		}
		Ring mob = ar.get(arm);
		set(mob,type,x,y,z,w,wMax,amp);
		mob.fillStyle.reset(parent.fillStyle[0]);
		arm ++;
	}

	void add(int type, PolyS parent, float w, float wMax, float amp) {
		add(type, parent, parent.p.p.x,parent.p.p.y,parent.p.p.z, w,wMax,amp);
	}

	void add(int type, PolyS parent, float w, float wMax) {
		add(type, parent, parent.p.p.x,parent.p.p.y,parent.p.p.z, w, wMax, 0.5);
	}

	void add(int type, PolyS parent, float wMax) {
		add(type, parent, parent.p.p.x,parent.p.p.y,parent.p.p.z, parent.w, wMax, 0.5);
	}
}