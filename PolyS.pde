/*
Custom class for Do You Don't You
Snaps to grid, right angles, and has special animation functions
*/
float pi2 = PI/2;
abstract class PolyS extends MobFL {

	void pulse() {
		
	}

	void death() {
		
	}

	void addAng(float x, float y, float z) {
		ang.P.add(x*pi2,y*pi2,z*pi2);
	}

	void addRang(float x, float y, float z) {
		rang.P.add(x*pi2,y*pi2,z*pi2);
	}

	void addP(float x, float y, float z) {
		p.P.add(x*gw,y*gw,z*gw);
	}

	void addR(float x, float y, float z) {
		r.P.add(x*gw,y*gw,z*gw);
	}

	void setAng(float x, float y, float z) {
		ang.P.set(x*pi2,y*pi2,z*pi2);
	}

	void setRang(float x, float y, float z) {
		rang.P.set(x*pi2,y*pi2,z*pi2);
	}

	void setP(float x, float y, float z) {
		p.P.set(x*gw,y*gw,z*gw);
	}

	void setR(float x, float y, float z) {
		r.P.set(x*gw,y*gw,z*gw);
	}
}