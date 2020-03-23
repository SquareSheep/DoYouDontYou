float pi2 = PI/2;
class PolyS extends Entity {
	Point p = new Point();
	Point pv = new Point();
	Point w = new Point();
	float gw;
	Point ang = new Point();
	Point av = new Point();
	IColor[] fillStyle = new IColor[10];
	IColor[] strokeStyle = new IColor[10];
	SpringValue sca = new SpringValue(1);
	int index;
	float threshold = 100;

	boolean alive = true;
	boolean diePulse = true;
	boolean checkBorders = true;
	PolySBox parent;
	PolyTemp template;

	int steps = 0;
	int maxSteps = 8;
	String[] modes;
	float tick = 0.5;
	float tickOffset = 0;
	int tx = 0; int ty = -1; int tz = 0;
	int tx2 = 0; int ty2 = -1; int tz2 = 0;
	PolyS mob;
	boolean flag;
	int id;

	PolyS reset(String[] modes, PolyTemp template, float x, float y, float z, float w, float tick, float tickOffset, int maxSteps) {
		this.p.reset((int)(x*w),(int)(y*w),(int)(z*w));
		this.pv.reset(0,0,0);
		this.ang.reset(0,0,0);
		this.av.reset(0,0,0);
		this.w.reset(w/2,w/2,w/2);
		this.sca.x = 0; this.sca.X = 1; this.sca.v = 0;
		this.gw = w;
		this.template = template;
		this.modes = modes;
		this.tick = tick;
		this.tickOffset = tickOffset;
		this.finished = false;
		this.alive = true;
		this.diePulse = true;
		this.steps = 0;
		this.maxSteps = maxSteps;
		return this;
	}

	PolyS() {
		for (int i = 0 ; i < fillStyle.length ; i ++) {
			fillStyle[i] = new IColor();
			strokeStyle[i] = new IColor();
		}
		p.mass = 25;
		p.vMult = 0.8;
	}

	void update() {
		p.update();
		pv.update();
		w.update();
		ang.update();
		av.update();
		sca.update();
		for (int i = 0 ; i < template.faces.length ; i ++) {
			fillStyle[i].update();
			strokeStyle[i].update();
		}
		if (!alive && sca.x < 0.03) {
				finished = true;
		} else if (beatQ && (currBeat+tickOffset) % tick == 0) {
			tickUpdate();
			steps ++;
			if (steps == maxSteps) die();
		}
	}

	void tickUpdate() {
		for (String mode : modes) {
			switch(mode) {
				case "line":
				addPT();
				break;
				case "flip":
				if ((steps+id) % 2 == 0) {
					addP(tx2,ty2,tz2);
				} else {
					addP(-tx2,-ty2,-tz2);
				}
				break;
				case "flipAng":
				sca.x -= 0.5;
				addAng(min(abs(tx2),1),min(abs(ty2),1),min(abs(tz2),1)); 
				break;
				case "altTemp":
				template = templates[(int)(currBeat%6)%templates.length];
				break;
				case "source":
				mob = parent.add(mLine, template, getx(),gety(),getz(), tick,tickOffset,maxSteps);
				mob.setT(tx2,ty2,tz2);
				break;
			}
		}
	}

	void render() {
		push();
		translate(p.p.x,p.p.y,p.p.z);
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
		scale(sca.x);
		for (int i = 0 ; i < template.faces.length ; i ++) {
			fillStyle[i].fillStyle();
			strokeStyle[i].strokeStyle();
			beginShape();
			for (int k = 0 ; k < template.faces[i].length ; k ++) {
				vertex(template.vert[template.faces[i][k]].p.x*w.p.x, template.vert[template.faces[i][k]].p.y*w.p.y, template.vert[template.faces[i][k]].p.z*w.p.z);
			}
			vertex(template.vert[template.faces[i][0]].p.x*w.p.x, template.vert[template.faces[i][0]].p.y*w.p.y, template.vert[template.faces[i][0]].p.z*w.p.z);
			endShape();
		}
		pop();
	}

	PolyS setTick(String[] modes, float tick, float tickOffset) {
		this.modes = modes;
		this.tick = tick;
		this.tickOffset = tickOffset;
		return this;
	}

	PolyS setT(int tx, int ty, int tz, int tx2, int ty2, int tz2) {
		this.tx = tx; this.ty = ty; this.tz = tz; this.tx2 = tx2; this.ty2 = ty2; this.tz2 = tz2;
		return this;
	}

	PolyS setT(int tx, int ty, int tz) {
		setT(tx,ty,tz, tx,ty,tz);
		return this;
	}

	void pulse(float amp) {
		sca.v += amp;
		parent.rings.add(0,this,0,gw*1.5,amp);
	}

	void die() {
		sca.X = -0.1;
		alive = false;
		float ax = 0; float ay = 0;
		if (tx != 0) {
			ay = PI/2;
		} else if (ty != 0) {
			ax = PI/2;
		}
		if (diePulse) parent.rings.add(0,this,p.p.x,p.p.y,p.p.z, ax,ay,0, 0,gw*1.5, 0.25);
	}

	void addAng(float x, float y, float z) {
		ang.P.add((int)x*pi2,(int)y*pi2,(int)z*pi2);
	}

	void addP(float x, float y, float z) {
		x = (int)x; y = (int)y; z = (int)z;
		p.P.add(x*gw,y*gw,z*gw);
	}

	void addPT(float x, float y, float z) {
		p.P.add(tx*gw,ty*gw,tz*gw);
		p.P.add((int)x*gw,(int)y*gw,(int)z*gw);
	}

	void addPT() {
		p.P.add(tx*gw,ty*gw,tz*gw);
	}

	void setAng(float x, float y, float z) {
		x = (int)x; y = (int)y; z = (int)z;
		ang.P.set(x*pi2,y*pi2,z*pi2);
	}

	void setP(float x, float y, float z) {
		x = (int)x; y = (int)y; z = (int)z;
		p.P.set(x*gw,y*gw,z*gw);
	}

	int getx() {
		if (abs(p.p.x) <= gw/2) return 0;
		if (p.p.x > 0) return (int)(p.p.x/gw)+1;
		return (int)(p.p.x/gw)-1;
	}

	int gety() {
		if (abs(p.p.y) <= gw/2) return 0;
		if (p.p.y > 0) return (int)(p.p.y/gw)+1;
		return (int)(p.p.y/gw)-1;
	}

	int getz() {
		if (abs(p.p.z) <= gw/2) return 0;
		if (p.p.z > 0) return (int)(p.p.z/gw)+1;
		return (int)(p.p.z/gw)-1;
	}

	void setFillStyle(float rc, float gc, float bc, float ac, float rcr, float gcr, float bcr, float acr, 
	float rm, float gm, float bm, float am, float rmr, float gmr, float bmr, float amr, float index) {
		setFillStyle(rc,gc,bc,ac,rcr,gcr,bcr,acr,rm,gm,bm,am,rmr,gmr,bmr,amr);
		for (int i = 0 ; i < fillStyle.length ; i ++) {
			fillStyle[i].index = (int)(index + i)%binCount;
		}
	}

	void setFillStyle(float rc, float gc, float bc, float ac, float rcr, float gcr, float bcr, float acr, 
	float rm, float gm, float bm, float am, float rmr, float gmr, float bmr, float amr) {
		float t;
		for (int i = 0 ; i < fillStyle.length ; i ++) {
			t = (float)i/fillStyle.length;
			fillStyle[i].set(rc+rcr*t, gc+gcr*t, bc+bcr*t, ac+acr*t, rm+rmr*t, gm+gmr*t, bm+bmr*t, am+amr*t);
		}
	}

	void setStrokeStyle(float rc, float gc, float bc, float ac, float rcr, float gcr, float bcr, float acr, 
	float rm, float gm, float bm, float am, float rmr, float gmr, float bmr, float amr, float index) {
	setStrokeStyle(rc,gc,bc,ac,rcr,gcr,bcr,acr,rm,gm,bm,am,rmr,gmr,bmr,amr);
		for (int i = 0 ; i < fillStyle.length ; i ++) {
			strokeStyle[i].index = (int)(index + i)%binCount;
		}
	}

	void setStrokeStyle(float rc, float gc, float bc, float ac, float rcr, float gcr, float bcr, float acr, 
	float rm, float gm, float bm, float am, float rmr, float gmr, float bmr, float amr) {
	float t;
		for (int i = 0 ; i < fillStyle.length ; i ++) {
			t = (float)i/fillStyle.length;
			strokeStyle[i].set(rc+rcr*t, gc+gcr*t, bc+bcr*t, ac+acr*t, rm+rmr*t, gm+gmr*t, bm+bmr*t, am+amr*t);
		}
	}

	void setIndex(float index) {
		int i = (int)index%binCount;
		index = i;
		p.index = i;
		w.index = i;
		ang.index = i;
		sca.index = i;
		pv.index = i;
		av.index = i;
		for (int k = 0 ; k < fillStyle.length ; k ++) {
			fillStyle[k].index = (i+k)%binCount;
			strokeStyle[k].index = (i+k)%binCount;
		}
	}
}

class PolyTemp {
	Point[] vert;
	int[][] faces;

	PolyTemp(float[] vert, int[][] faces) {
		this.faces = faces;
		this.vert = new Point[vert.length/3];
		for (int i = 0 ; i < vert.length ; i += 3) {
			this.vert[i/3] = new Point(vert[i],vert[i+1],vert[i+2]);
		}
	}
}

PolyTemp chooseTemp(float i) {
	switch((int)i) {
		case 0: return pyramid;
		case 1: return cube;
		case 2: return octohedron;
		case 3: return crystal;
		default: return cube;
	}
}

PolyTemp randomTemp(PolyTemp[] ar) {
	return ar[(int)random(ar.length)];
}

PolyTemp pyramid = new PolyTemp(new float[]{-1,1,-1, 1,1,-1, 1,1,1, -1,1,1, 0,-1,0},
	new int[][]{new int[]{0,1,2,3}, new int[]{0,1,4}, new int[]{1,2,4}, new int[]{2,3,4}, new int[]{3,0,4}});

PolyTemp cube = new PolyTemp(new float[]{-1,-1,-1, 1,-1,-1, 1,1,-1, -1,1,-1, -1,-1,1, 1,-1,1, 1,1,1, -1,1,1},
    new int[][]{new int[]{0,1,2,3}, new int[]{0,1,5,4}, new int[]{1,2,6,5}, new int[]{2,3,7,6}, new int[]{3,0,4,7}, new int[]{4,5,6,7}});

PolyTemp crystal = new PolyTemp(new float[]{-1,-1,-1, 1,-1,-1, 1,1,-1, -1,1,-1, -1,-1,1, 1,-1,1, 1,1,1, -1,1,1, 0,2.5,0, 0,-2.5,0},
      new int[][]{new int[]{0,1,2,3}, new int[]{0,1,5,4}, new int[]{1,2,6,5}, new int[]{2,3,7,6}, new int[]{3,0,4,7}, new int[]{4,5,6,7},
      new int[]{9,0,1}, new int[]{9,1,5}, new int[]{9,4,5}, new int[]{9,4,0}});

PolyTemp octohedron = new PolyTemp(new float[]{0,-1,0, -1,0,0, 0,0,1, 1,0,0, 0,0,-1, 0,1,0},
      new int[][]{new int[]{0,1,2}, new int[]{0,2,3}, new int[]{0,3,4}, new int[]{0,4,1},
      new int[]{5,1,2}, new int[]{5,2,3}, new int[]{5,3,4}, new int[]{5,4,1}});

PolyTemp[] templates = new PolyTemp[]{pyramid,cube,octohedron};