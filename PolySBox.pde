/*
Box container class for PolyS objects
Can change shape fluidly
Checks boundaries
*/
class PolySBox extends Mob {
	ArrayList<PolyS> ar = new ArrayList<PolyS>();
	RingPool rings = new RingPool();
	Point w;
	PVector g;
	float gw;
	boolean checkBorders = true;
	boolean drawBorders = false;

	PolySBox(int x, int y, int z, int w, int h, int d, float gw) {
		p = new Point(x*gw,y*gw,z*gw);
		ang = new Point();
		this.w = new Point(w*gw,h*gw,d*gw);
		g = new PVector(w,h,d);
		this.gw = gw;
	}

	void add(float type, float x, float y, float z, int ax, int ay, int az) {
		x = (int)min(max(x,-g.x),g.x);
		y = (int)min(max(y,-g.y),g.y);
		z = (int)min(max(z,-g.z),g.z);
		ar.add(newPolyS(type,gw*x,gw*y,gw*z,ax*PI/2,ay*PI/2,az*PI/2,gw/2));
		ar.get(ar.size()-1).parent = this;
	}

	void setW(float x, float y, float z) {
		w.P.set(gw*(int)x, gw*(int)y, gw*(int)z);
	}

	void update() {
		super.update();
		rings.update();
		w.update();
		g.set(w.p.x/gw,w.p.y/gw,w.p.z/gw);
		for (PolyS mob : ar) {
			mob.update();
		}
		for (int i = 0 ; i < ar.size() ; i ++) {
			if (ar.get(i).finished) ar.remove(i);
		}
		if (checkBorders) {
			for (PolyS mob : ar) {
				if (mob.p.p.x < -w.p.x) {
					mob.p.P.x = -w.p.x;
					mob.p.p.x = -w.p.x;
				}
				if (mob.p.p.y < -w.p.y) {
					mob.p.P.y = -w.p.y;
					mob.p.p.y = -w.p.y;
				}
				if (mob.p.p.z < -w.p.z) {
					mob.p.P.z = -w.p.z;
					mob.p.p.z = -w.p.z;
				}
				if (mob.p.p.x > w.p.x) {
					mob.p.P.x = w.p.x;
					mob.p.p.x = w.p.x;
				}
				if (mob.p.p.y > w.p.y) {
					mob.p.P.y = w.p.y;
					mob.p.p.y = w.p.y;
				}
				if (mob.p.p.z > w.p.z) {
					mob.p.P.z = w.p.z;
					mob.p.p.z = w.p.z;
				}
			}
		}
	}

	void render() {
		setDraw();
		rings.render();
		for (PolyS mob : ar) {
			mob.render();
		}

		if (drawBorders) {
			stroke(avg*10);
			noFill();
			box(w.p.x*2+gw,w.p.y*2+gw,w.p.z*2+gw);
		}
		pop();
	}
}