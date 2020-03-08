float ringWMass = 25;
float ringWVMult = 0.6;
float ringWThreshold = 0.9;
class Ring extends Entity {
	Point p = new Point();
	Point ang = new Point();
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
		ang.update();
		w.update();
		fillStyle.update();
		if (w.x >= wMax*ringWThreshold) finished = true;
	}

	void render() {
		push();
		translate(p.p.x,p.p.y,p.p.z);
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
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

	void set(Ring mob, int type, float x, float y, float z, float ax, float ay, float az, float w, float wMax, float amp) {
		mob.p.reset(x,y,z);
		mob.ang.reset(ax,ay,az);
		mob.w.x = w;
		mob.w.X = wMax;
		mob.w.v = 0;
		mob.wMax = wMax;
		mob.amp = amp;
		mob.type = type;
		mob.finished = false;
	}

	void add(int type, PolyS parent, float x, float y, float z, float ax, float ay, float az, float w, float wMax, float amp) {
		if (arm == ar.size()) {
			ar.add(new Ring());
		}
		Ring mob = ar.get(arm);
		set(mob,type,x,y,z,ax,ay,az,w,wMax,amp);
		if (parent.strokeStyle[0].a.x > parent.fillStyle[0].a.x) {
			mob.fillStyle.reset(parent.strokeStyle[0]);
		} else {
			mob.fillStyle.reset(parent.fillStyle[0]);
			
		}
	arm ++;
	}

	void add(int type, PolyS parent, float w, float wMax, float amp) {
		add(type, parent, parent.p.p.x,parent.p.p.y,parent.p.p.z, parent.ang.p.x,parent.ang.p.y,parent.ang.p.z, w,wMax,amp);
	}

	void add(int type, PolyS parent, float w, float wMax) {
		add(type, parent, parent.p.p.x,parent.p.p.y,parent.p.p.z, parent.ang.p.x,parent.ang.p.y,parent.ang.p.z, w, wMax, 0.25);
	}

	void add(int type, PolyS parent, float wMax) {
		add(type, parent, parent.p.p.x,parent.p.p.y,parent.p.p.z, parent.ang.p.x,parent.ang.p.y,parent.ang.p.z, parent.w, wMax, 0.25);
	}
}