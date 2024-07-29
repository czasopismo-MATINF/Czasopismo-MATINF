/**********************//**********************/

public class Efekt {
  
  char typ;
  int rozmiar;
    
  Efekt(char typ, int rozmiar) {
    this.typ = typ;
    this.rozmiar = rozmiar;
  }
    
  void rysuj(float x, float y, float skala) {
    switch(this.typ) {
       case '.' : {
           
       }
       break;
       case '5' : {
         for(int i = 0; i < 10; ++i) {
           circle( x + this.rozmiar*skala*random(-1, 1), y + this.rozmiar*skala*random(-1, 1), this.rozmiar*skala*random(-1, 1) );
         }
       }
       break;
       case '6' : {
         fill(random(0, 255), random(0, 255), random(0, 255));
         rect( x + this.rozmiar*skala*random(-1, 0), y + this.rozmiar*skala*random(-1, 0), this.rozmiar*skala*random(0, 1), this.rozmiar*skala*random(0, 1) );
         fill(255, 255, 255);
       }
       break;
       case '7' : {
         for(int i = 0; i < 10; ++i) {
           line( x + this.rozmiar*skala*random(-1, 1), y + this.rozmiar*skala*random(-1, 1), x + this.rozmiar*skala*random(-1, 1), y + this.rozmiar*skala*random(-1, 1) );
         }
       }
       break;
    }
    
  }

}

/**********************//**********************/

public class Mapa {

  String[] listaPol;
  int szerokosc;
  int wysokosc;
  int rozmiarKlatkiMapy;
  
  Efekt[][] pola;
  
  Mapa(String[] listaPol, int rozmiarKlatkiMapy) {
    this.listaPol = listaPol;
    // na razie program dziala tylko z prostokatnym planem mapy
    this.szerokosc = listaPol[0].length();
    this.wysokosc = listaPol.length;
    this.rozmiarKlatkiMapy = rozmiarKlatkiMapy;
    
    this.pola = new Efekt[this.szerokosc][this.wysokosc];
    
    // problem przy tlumaczeniu z jezyka Python na jezyk Java, poniewaz w Javie, w tablicach obiekty musza byc tego samego typu
    /* do usuniecia
    for(int j = 0; j < this.wysokosc; ++j) {
       for(int i = 0; i < this.szerokosc; ++i) {
          if(this.listaPol[j].charAt(i) != '.') {
             // ... 
             // self.pola[j][i] = e.Efekt(int(self.pola[j][i]), self.rozmiar_klatki_mapy)
          }
       }
    }
    */
    
    //stad potrzeba dodania wlasciwosci Efekt[][] pola, zmiany typu typu w klasie Efekt na char oraz "defaultowego" efektu '.'
    for(int i = 0; i < this.szerokosc; ++i) {
       for(int j = 0; j < this.wysokosc; ++j) {
             this.pola[i][j] = new Efekt(this.listaPol[j].charAt(i), this.rozmiarKlatkiMapy);
       }
    }
  }
  
  void rysuj(float skala) {
    for(int i = 0; i <= this.wysokosc; ++i) {
      line(0, i * this.rozmiarKlatkiMapy, this.rozmiarKlatkiMapy * this.szerokosc, i * this.rozmiarKlatkiMapy);
    }
    for(int i = 0; i <= this.szerokosc; ++i) {
      line(i * this.rozmiarKlatkiMapy, 0, i * this.rozmiarKlatkiMapy, this.rozmiarKlatkiMapy * this.wysokosc);
    }
    //ale to uproscilo metode rysujaca efekty na mapie
    for(int i = 0; i < this.szerokosc; ++i) {
       for(int j = 0; j < this.wysokosc; ++j) {
             this.pola[i][j].rysuj(i * this.rozmiarKlatkiMapy,j*this.rozmiarKlatkiMapy,skala);
       }
    }
  }
  
}

/**********************//**********************/

class Robot {
  
  Mapa mapa;
  int rozmiarKlatkiMapy;
  // czy robot powinien znac swoje polozenie na mapie (OOD?)
  int[] poleStartowe;
  int x,y,rozmiar;
  
  Robot(Mapa mapa, int rozmiarKlatkiMapy, int[] poleStartowe) {
    this.mapa = mapa;
    this.x = poleStartowe[0];
    this.y = poleStartowe[1];
    this.rozmiarKlatkiMapy = rozmiarKlatkiMapy;
    this.rozmiar = rozmiarKlatkiMapy/2;
  }
  
  // poprawic rozpoznawanie przeszkod
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
  
  // czy robot powinien sam sie wyswietlac (OOD?)
  void rysuj() {
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
// poprawic tak, by wyswietlaly sie mapy innych ksztaltow niz prostokatne
String[] szkieletMapy = new String[] {
 "..7............",
 "...............",
 "..6............",
 "...............",
 "..5............",
 "...............",
 "...............",
 "...............",
 "...............",
 "..............."
};

Mapa mapa = new Mapa(szkieletMapy, rozmiarKlatkiMapy);

// przeniesc punkt poczatkowy robota na mape
Robot robot = new Robot(mapa, rozmiarKlatkiMapy, new int[] {2,4});

void setup() {
    size(800, 600);
}
 
void draw() {
    mapa.rysuj(1);
    robot.rysuj();

    //tutaj rozkazy dla robota
    robot.krokWKierunku(1);

    delay(100);
}
