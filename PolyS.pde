/*
Snap-to-grid Poly
Custom class for Do You Don't You
Snaps to grid, right angles, and has special animation functions
*/
PolyS newPolyS(float type, float x, float y, float z, float ax, float ay, float az, float w) {
  PolyS poly;
  switch ((int)type) {
    case 0: // Pyramid
    poly = new PolyS(x,y,z, ax,ay,az, w, new float[]{-1,-1,-1, 1,-1,-1, 1,1,-1, -1,1,-1, 0,0,1},
    new int[][]{new int[]{0,1,2,3}, new int[]{0,1,4}, new int[]{1,2,4}, new int[]{2,3,4}, new int[]{3,0,4}});
    break;
    case 1: // Box
    poly = new PolyS(x,y,z, ax,ay,az, w, new float[]{-1,-1,-1, 1,-1,-1, 1,1,-1, -1,1,-1, -1,-1,1, 1,-1,1, 1,1,1, -1,1,1},
    new int[][]{new int[]{0,1,2,3}, new int[]{0,1,5,4}, new int[]{1,2,6,5}, new int[]{2,3,7,6}, new int[]{3,0,4,7}, new int[]{4,5,6,7}});
    break;
    case 2: // Crystal
    poly = new PolyS(x,y,z, ax,ay,az, w, new float[]{-1,-1,-1, 1,-1,-1, 1,1,-1, -1,1,-1, -1,-1,1, 1,-1,1, 1,1,1, -1,1,1, 0,2.5,0, 0,-2.5,0},
      new int[][]{new int[]{0,1,2,3}, new int[]{0,1,5,4}, new int[]{1,2,6,5}, new int[]{2,3,7,6}, new int[]{3,0,4,7}, new int[]{4,5,6,7},
      new int[]{9,0,1}, new int[]{9,1,5}, new int[]{9,4,5}, new int[]{9,4,0}}); //0,1,4,5
    break;
    default:
    poly = new PolyS();
    break;
  }
  return poly;
}

float pi2 = PI/2;
class PolyS extends Poly {
	float gw;
	boolean alive = true;
	PolySBox parent;

	PolyS(float x, float y, float z, float ax, float ay, float az, float w, float[] vert, int[][] faces) {
		super(x,y,z,ax,ay,az,w,vert,faces);
		this.gw = w*2;
	}

	PolyS() {}

	void update() {
		super.update();
		if (!alive) {
			if (sca.x <= 0.03) {
				finished = true;
			}
		}
	}

	void pulse(float amp) {
		sca.v += amp;
		ang.v.add(random(-amp,amp),random(-amp,amp),random(-amp,amp));
	}

	void die() {
		sca.X = 0;
		alive = false;
		parent.rings.add(0,this,w*3, 0.5);
	}

	void addAng(float x, float y, float z) {
		x = (int)x; y = (int)y; z = (int)z;
		ang.P.add(x*pi2,y*pi2,z*pi2);
	}

	void addRang(float x, float y, float z) {
		x = (int)x; y = (int)y; z = (int)z;
		rang.P.add(x*pi2,y*pi2,z*pi2);
	}

	void addP(float x, float y, float z) {
		x = (int)x; y = (int)y; z = (int)z;
		p.P.add(x*gw,y*gw,z*gw);
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
	}

	void setR(float x, float y, float z) {
		x = (int)x; y = (int)y; z = (int)z;
		r.P.set(x*gw,y*gw,z*gw);
	}
}