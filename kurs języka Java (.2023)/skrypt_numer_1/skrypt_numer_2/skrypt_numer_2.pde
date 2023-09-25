int[] wspolrzedne = new int[8];

void setup() {
  size(640, 360, P2D);
}

void draw() {
  for(int i = 0; i < 4; ++i) {
     wspolrzedne[2*i + 0] = (int) (random(640)); 
     wspolrzedne[2*i + 1] = (int) (random(360));
  }
  
  circle(wspolrzedne[0],wspolrzedne[1],10);
  circle(wspolrzedne[2],wspolrzedne[3],20);
  circle(wspolrzedne[4],wspolrzedne[5],30);
  circle(wspolrzedne[6],wspolrzedne[7],40);
}
