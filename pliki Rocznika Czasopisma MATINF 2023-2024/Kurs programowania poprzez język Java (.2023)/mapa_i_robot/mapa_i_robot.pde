/**********************//**********************/

public class Mapa {

  String[] listaPol;
  int szerokosc;
  int wysokosc;
  int rozmiarKlatkiMapy;
  
  Mapa(String[] listaPol, int rozmiarKlatkiMapy) {
    this.listaPol = listaPol;
    this.szerokosc = listaPol[0].length();
    this.wysokosc = listaPol.length;
    this.rozmiarKlatkiMapy = rozmiarKlatkiMapy;
  }
  
  void wyswietl() {
    for(int i = 0; i <= this.wysokosc; ++i) {
      line(0, i * this.rozmiarKlatkiMapy, this.rozmiarKlatkiMapy * this.szerokosc, i * this.rozmiarKlatkiMapy);
    }
    for(int i = 0; i <= this.szerokosc; ++i) {
      line(i * this.rozmiarKlatkiMapy, 0, i * this.rozmiarKlatkiMapy, this.rozmiarKlatkiMapy * this.wysokosc);
    }
  }
  
}

/**********************//**********************/

class Robot {
  
  Mapa mapa;
  int rozmiarKlatkiMapy;
  int[] poleStartowe;
  int x,y,rozmiar;
  
  Robot(Mapa mapa, int rozmiarKlatkiMapy, int[] poleStartowe) {
    this.mapa = mapa;
    this.x = poleStartowe[0];
    this.y = poleStartowe[1];
    this.rozmiarKlatkiMapy = rozmiarKlatkiMapy;
    this.rozmiar = rozmiarKlatkiMapy/2;
  }
  
  boolean naZachodzieWolne() {
    return true;
  }
  boolean naWschodzieWolne() {
    return true;
  }
  boolean naPolnocyWolne() {
    return true; 
  }
  boolean naPoludnieWolne() {
    return true; 
  }
  
  void wyswietl() {
    circle(this.x * this.rozmiarKlatkiMapy, this.y * this.rozmiarKlatkiMapy, this.rozmiar);
  }
  
  void krokWKierunku(int kierunek) {
    
   switch(kierunek) {
      case 0: {
        this.y = this.y - 1;
      } break;
      case 1: {
        this.x = this.x + 1;
      } break;
      case 2: {
        this.y = this.y + 1;
      } break;
      case 3: {
        this.x = this.x - 1;
      } break;
      
   }
  }

}

/**********************//**********************/

int rozmiarKlatkiMapy = 50;
String[] szkieletMapy = new String[] {
 "...............",
 "...............",
 "...............",
 "...............",
 "...............",
 "...............",
 "...............",
 "...............",
 "...............",
 "..............."
};

Mapa mapa = new Mapa(szkieletMapy, rozmiarKlatkiMapy);

Robot robot = new Robot(mapa, rozmiarKlatkiMapy, new int[] {2,4});

void setup() {
    size(800, 600);
}
 
void draw() {
    mapa.wyswietl();
    robot.wyswietl();

    //tutaj rozkazy dla robota
    robot.krokWKierunku(1);

    delay(500);
}
