/*
Box container class for PolyS objects
Can change shape fluidly
Checks boundaries
*/
class PolySBox extends Mob {
	ArrayList<PolyS> ar = new ArrayList<PolyS>();
	RingPool rings = new RingPool();
	int gx; int gy; int gz;
	float gw;
	boolean checkBorders = true;
	boolean dieBorders = true;
	int stepLimit = -1;
	boolean drawBorders = false;
	Point arPv = new Point();

	boolean flag;

	PolySBox(int x, int y, int z, int w, int h, int d, float gw) {
		p = new Point(x*gw,y*gw,z*gw);
		ang = new Point();
		this.w = new Point(w*gw,h*gw,d*gw);
		gx = w; gy = h; gz = d;
		this.gw = gw;
	}

	PolyS add(float type, float x, float y, float z, int ax, int ay, int az, String mode, float tick, float tickOffset, float maxSteps) {
		x = (int)min(max(x,-gx),gx);
		y = (int)min(max(y,-gy),gy);
		z = (int)min(max(z,-gz),gz);
		ar.add(newPolyS(type,gw*x,gw*y,gw*z,ax*PI/2,ay*PI/2,az*PI/2,gw/2, mode, tick, tickOffset, maxSteps));
		ar.get(ar.size()-1).parent = this;
		return get();
	}

	PolyS add(float type, float x, float y, float z, String mode, float tick, float tickOffset, float maxSteps) {
		return add(type, x,y,z, 0,0,0, mode,tick,tickOffset,maxSteps);
	}

	PolyS add(float type, float x, float y, float z, String mode, float tick, float tickOffset) {
		return add(type, x,y,z, 0,0,0, mode,tick,tickOffset,8);
	}

	PolyS add(float type, float x, float y, float z, int ax, int ay, int az) {
		return add(type, x,y,z, ax,ay,az, "",0,0, 8);
	}

	PolyS add(float type, float x, float y, float z) {
		return add(type, x,y,z, 0,0,0, "",0,0, 8);
	}

	PolySBar addBar(float x, float y, float z, int ax, int ay, int az) {
		x = (int)min(max(x,-gx),gx);
		y = (int)min(max(y,-gy),gy);
		z = (int)min(max(z,-gz),gz);
		ar.add(new PolySBar(gw*x,gw*y,gw*z,ax*PI/2,ay*PI/2,az*PI/2,gw/2));
		ar.get(ar.size()-1).parent = this;
		return (PolySBar)ar.get(ar.size()-1);
	}

	PolyS get() {
		return ar.get(ar.size()-1);
	}

	PolyS get(float i) {
		return ar.get((int)i);
	}

	void setW(float x, float y, float z) {
		w.P.set(gw*(int)x, gw*(int)y, gw*(int)z);
	}

	void arFillStyleSet(boolean which, float rc, float gc, float bc, float ac, float rcr, float gcr, float bcr, float acr, 
		float rm, float gm, float bm, float am, float rmr, float gmr, float bmr, float amr) {
		float x,y,z,t;
		for (int i = 0 ; i < ar.size() ; i ++) {
			PolyS mob = ar.get(i);
			t = (float)i/ar.size();
			x2 = mob.p.p.x/w.p.x;
			y2 = mob.p.p.y/w.p.y;
			z2 = mob.p.p.z/w.p.z;
			x = (x2+y2);
			y = (y2+z2);
			z = (z2+x2);
			if (which) {
				mob.fillStyleSet(rc+x*rcr,gc+y*gcr,bc+z*bcr,ac+t*acr, rcr,gcr,bcr,acr, rm+x*rmr,gm+y*gmr,bm+z*bmr,am+t*amr, rmr,gmr,bmr,amr);
			} else {
				mob.strokeStyleSet(rc+x*rcr,gc+y*gcr,bc+z*bcr,ac+t*acr, rcr,gcr,bcr,acr, rm+x*rmr,gm+y*gmr,bm+z*bmr,am+t*amr, rmr,gmr,bmr,amr);
			}
		}
		arIndex();
	}

	void arFillStyleSet(float rc, float gc, float bc, float ac, float rcr, float gcr, float bcr, float acr, 
		float rm, float gm, float bm, float am, float rmr, float gmr, float bmr, float amr) {
		arFillStyleSet(false, rc,gc,bc,ac, rcr,gcr,bcr,acr, rm,gm,bm,am, rmr,gmr,bmr,amr);
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
		gx = (int)(w.p.x/gw);
		gy = (int)(w.p.y/gw);
		gz = (int)(w.p.z/gw);
		for (int i = 0 ; i < ar.size() ; i ++) {
			ar.get(i).update();
		}
		for (int i = 0 ; i < ar.size() ; i ++) {
			if (ar.get(i).finished) ar.remove(i);
		}
		if (checkBorders) {
			for (PolyS mob : ar) {
				if (checkMobBorder(mob) && dieBorders) {
					if (mob.alive) mob.die();
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