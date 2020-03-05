/*
Box container class for PolyS objects
Can change shape fluidly
Checks boundaries
*/
class PolySBox extends Mob {
	ArrayList<PolyS> ar = new ArrayList<PolyS>();
	RingPool rings = new RingPool();
	PVector g;
	float gw;
	boolean checkBorders = true;
	boolean dieBorders = false;
	int stepLimit = -1;
	boolean drawBorders = false;

	boolean flag;

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

	void add(float type, float x, float y, float z) {
		add(type, x,y,z, 0,0,0);
	}

	void setW(float x, float y, float z) {
		w.P.set(gw*(int)x, gw*(int)y, gw*(int)z);
	}

	void arFillStyleSet(float rc, float gc, float bc, float ac, float rcr, float gcr, float bcr, float acr, 
		float rm, float gm, float bm, float am, float rmr, float gmr, float bmr, float amr) {
		float x,y,z,t;
		for (int i = 0 ; i < ar.size() ; i ++) {
			PolyS mob = ar.get(i);
			t = (float)i/ar.size();
			x = mob.p.p.x/w.p.x;
			y = mob.p.p.y/w.p.y;
			z = mob.p.p.z/w.p.z;
			mob.fillStyleSet(rc+x*rcr,gc+y*gcr,bc+b*bcr,ac+t*acr, rcr,gcr,bcr,acr, rm+x*rmr,gm+y*gmr,bm+z*bmr,am+t*amr, rmr,gmr,bmr,amr);
		}
		arIndex();
	}

	void arIndex() {
		if (ar.size() > binCount*0.9) {
			for (int i = 0 ; i < ar.size() ; i ++) {
				ar.get(i).fillStyleIndex(i);
			}
		} else {
			float t;
			for (int i = 0 ; i < ar.size() ; i ++) {
				t = (float)i/ar.size();
				ar.get(i).fillStyleIndex(t*binCount);
			}
		}
	}

	void update() {
		super.update();
		rings.update();
		g.set(w.p.x/gw,w.p.y/gw,w.p.z/gw);
		for (PolyS mob : ar) {
			mob.update();
		}
		for (int i = 0 ; i < ar.size() ; i ++) {
			if (ar.get(i).finished) ar.remove(i);
		}
		if (checkBorders) {
			for (PolyS mob : ar) {
				if (checkMobBorder(mob) && dieBorders) {
					mob.die();
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
			stroke(255);
			noFill();
			box(w.p.x*2+gw,w.p.y*2+gw,w.p.z*2+gw);
		}
		pop();
	}

	boolean checkMobBorder(PolyS mob) {
		flag = false;
		if (mob.p.p.x < -w.p.x) {
			mob.p.P.x = -w.p.x;
			mob.p.p.x = -w.p.x;
			flag = true;
		}
		if (mob.p.p.y < -w.p.y) {
			mob.p.P.y = -w.p.y;
			mob.p.p.y = -w.p.y;
			flag = true;
		}
		if (mob.p.p.z < -w.p.z) {
			mob.p.P.z = -w.p.z;
			mob.p.p.z = -w.p.z;
			flag = true;
		}
		if (mob.p.p.x > w.p.x) {
			mob.p.P.x = w.p.x;
			mob.p.p.x = w.p.x;
			flag = true;
		}
		if (mob.p.p.y > w.p.y) {
			mob.p.P.y = w.p.y;
			mob.p.p.y = w.p.y;
			flag = true;
		}
		if (mob.p.p.z > w.p.z) {
			mob.p.P.z = w.p.z;
			mob.p.p.z = w.p.z;
			flag = true;
		}
		return flag;
	}
}