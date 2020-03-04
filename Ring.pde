class Ring extends Entity {
	Point p;
	SpringValue w;
	float wMax;
	float amp;
	IColor fillStyle = new IColor();
	IColor strokeStyle = new IColor();
	int type = 0;

	Ring(int type, float x, float y, float z, float w, float wMax, float amp) {
		this.p = new Point(x,y,z);
		this.w = new SpringValue(w,wMax);
		this.wMax = wMax;
		this.amp = amp;
		this.type = type;
	}

	Ring() {
		p = new Point();
		w = new SpringValue();
	}

	void update() {
		p.update();
		w.update();
		fillStyle.update();
		strokeStyle.update();
		if (w.x >= wMax) finished = true;
	}

	void render() {
		push();
		strokeStyle.strokeStyle();
		fillStyle.fillStyle();
		rect(0,0,w.x,w.x);
		pop();
	}
}

class RingPool extends ObjectPool<Ring> {

	void set(Ring mob, int type, float x, float y, float z, float w, float wMax, float amp) {
		mob.p.reset(x,y,z);
		mob.w.reset(w,wMax);
		mob.wMax = wMax;
		mob.amp = amp;
		mob.type = type;
	}

	void add(int type, float x, float y, float z, float w, float wMax, float amp) {
		if (arm == ar.size()) {
			ar.add(new Ring());
		}
		Ring mob = ar.get(arm);
		set(mob,type,x,y,z,w,wMax,amp);
		arm ++;
	}

	void add(int type, PolyS parent, float amp) {
		add(type, parent.p.p.x,parent.p.p.y,parent.p.p.z,parent.w,parent.w*2,amp);
	}
}