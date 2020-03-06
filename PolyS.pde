/*
Snap-to-grid Poly
Custom class for Do You Don't You
Snaps to grid, right angles, and has special animation functions
*/
PolyS newPolyS(float type, float x, float y, float z, float ax, float ay, float az, float w, String mode, float tick, float tickOffset) {
  PolyS poly;
  switch ((int)type) {
    case 0: // Pyramid
    poly = new PolyS(x,y,z, ax,ay,az, w, new float[]{-1,-1,-1, 1,-1,-1, 1,1,-1, -1,1,-1, 0,0,1},
    new int[][]{new int[]{0,1,2,3}, new int[]{0,1,4}, new int[]{1,2,4}, new int[]{2,3,4}, new int[]{3,0,4}}, mode, tick, tickOffset);
    break;
    case 1: // Box
    poly = new PolyS(x,y,z, ax,ay,az, w, new float[]{-1,-1,-1, 1,-1,-1, 1,1,-1, -1,1,-1, -1,-1,1, 1,-1,1, 1,1,1, -1,1,1},
    new int[][]{new int[]{0,1,2,3}, new int[]{0,1,5,4}, new int[]{1,2,6,5}, new int[]{2,3,7,6}, new int[]{3,0,4,7}, new int[]{4,5,6,7}}, mode, tick, tickOffset);
    break;
    case 2: // Octahedron
    poly = new PolyS(x,y,z, ax,ay,az, w, new float[]{0,-1,0, -1,0,0, 0,0,1, 1,0,0, 0,0,-1, 0,1,0},
      new int[][]{new int[]{0,1,2}, new int[]{0,2,3}, new int[]{0,3,4}, new int[]{0,4,1},
      new int[]{5,1,2}, new int[]{5,2,3}, new int[]{5,3,4}, new int[]{5,4,1}}, mode, tick, tickOffset); //0,1,4,5
    break;  
    default:
    poly = new PolyS();
    break;
  }
  return poly;
}

class PolySBar extends PolyS {
	PolySBar(float x, float y, float z, float ax, float ay, float az, float w) {
		super(x,y,z,ax,ay,az,w,new float[]{-1,-1,-1, 1,-1,-1, 1,1,-1, -1,1,-1, 0,0,1},
    new int[][]{new int[]{0,1,2,3}, new int[]{0,1,4}, new int[]{1,2,4}, new int[]{2,3,4}, new int[]{3,0,4}}, "",0,0);
	}

	void setM(float amp, float k) {
		amp *= w;
		vert[2].pm.set(0,amp,0);
		vert[3].pm.set(0,amp,0);
		vert[4].pm.set(0,amp,0);
		vert[5].pm.set(0,amp,0);
	}

	void setIndex(float k) {
		int index = (int)k%binCount;
		super.setIndex(k);
		vert[2].index = index;
		vert[3].index = index;
		vert[4].index = index;
		vert[5].index = index;
	}
}

float pi2 = PI/2;
class PolyS extends Poly {
	float gw;
	boolean alive = true;
	PolySBox parent;

	int steps = 0;
	String mode = "";
	float tick = 0.5;
	float tickOffset = 0;
	int tx = 0; int ty = -1; int tz = 0;

	PolyS(float x, float y, float z, float ax, float ay, float az, float w, float[] vert, int[][] faces, String mode, float tick, float tickOffset) {
		super(x,y,z,ax,ay,az,w,vert,faces);
		this.gw = w*2; this.mode = mode; this.tick = tick; this.tickOffset = tickOffset; sca.x = 0;
	}

	PolyS() {}

	void update() {
		super.update();
		if (!alive) {
			if (sca.x <= 0.03) {
				finished = true;
			}
		} else if (beatQ && mode != "" && (currBeat+tickOffset) % tick == 0) {
			tickUpdate();
		}
	}

	void tickUpdate() {
		int X = getx();
		int Y = gety();
		int Z = getz();
		switch(mode) {
			case "box":
				switch((int)(currBeat*2) % 4) {
					case 0:
					addPT(1,0,0);
					break;
					case 1:
					addPT(0,0,1);
					break;
					case 2:
					addPT(-1,0,0);
					break;
					case 3:
					addPT(0,0,-1);
				}
				addAng(1,1,0);
			break;
			case "tower":
				if (p.p.x > 0) {
					addPT(X%2,0,0);
				} else {
					addPT(-X%2,0,0);
				}
				addAng(X%2,0,0);
			break;
			case "line":
			addPT();
			break;
		}
	}

	void setTick(String mode, float tick, float tickOffset) {
		this.mode = mode;
		this.tick = tick;
		this.tickOffset = tickOffset;
	}

	void pulse(float amp) {
		sca.v += amp;
		parent.rings.add(0,this,0,w*3,amp);
	}

	void die() {
		sca.X = 0;
		alive = false;
		parent.rings.add(0,this,w*3);
	}

	void addAng(float x, float y, float z) {
		ang.P.add((int)x*pi2,(int)y*pi2,(int)z*pi2);
	}

	void addRang(float x, float y, float z) {
		rang.P.add((int)x*pi2,(int)y*pi2,(int)z*pi2);
	}

	void addP(float x, float y, float z) {
		x = (int)x; y = (int)y; z = (int)z;
		p.P.add(x*gw,y*gw,z*gw);
		steps ++;
	}

	void addPT(float x, float y, float z) {
		p.P.add(tx*gw,ty*gw,tz*gw);
		p.P.add((int)x*gw,(int)y*gw,(int)z*gw);
		steps ++;
	}

	void addPT() {
		p.P.add(tx*gw,ty*gw,tz*gw);
		steps ++;
	}

	void addR(float x, float y, float z) {
		x = (int)x; y = (int)y; z = (int)z;
		r.P.add(x*gw,y*gw,z*gw);
	}

	void setAng(float x, float y, float z) {
		x = (int)x; y = (int)y; z = (int)z;
		ang.P.set(x*pi2,y*pi2,z*pi2);
	}

	void setRang(float x, float y, float z) {
		x = (int)x; y = (int)y; z = (int)z;
		rang.P.set(x*pi2,y*pi2,z*pi2);
	}

	void setP(float x, float y, float z) {
		x = (int)x; y = (int)y; z = (int)z;
		p.P.set(x*gw,y*gw,z*gw);
		steps ++;
	}

	void setR(float x, float y, float z) {
		x = (int)x; y = (int)y; z = (int)z;
		r.P.set(x*gw,y*gw,z*gw);
	}

	int getx() {
		if (p.p.x > 0) return (int)(p.p.x/gw - p.p.x%gw);
		return (int)(p.p.x/gw - p.p.x%gw+1);
	}

	int gety() {
		if (p.p.y > 0) return (int)(p.p.y/gw - p.p.y%gw);
		return (int)(p.p.y/gw - p.p.y%gw+1);
	}

	int getz() {
		if (p.p.z > 0) return (int)(p.p.z/gw - p.p.z%gw);
		return (int)(p.p.z/gw - p.p.z%gw+1);
	}
}