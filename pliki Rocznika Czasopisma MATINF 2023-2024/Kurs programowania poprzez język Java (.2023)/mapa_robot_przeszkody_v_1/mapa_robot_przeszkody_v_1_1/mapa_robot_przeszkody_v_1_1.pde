/**********************//**********************/

class Efekt {
  
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

class Mapa {

  String[] listaPol;
  
  int szerokosc;
  int wysokosc;
  int rozmiarKlatkiMapy;
  
  Efekt[][] polaEfektow;
  int x,y;  // pole z robotem
  
  Mapa(String[] listaPol, int rozmiarKlatkiMapy) {

    this.listaPol = listaPol;

    // na razie program dziala tylko z prostokatnym planem mapy
    this.szerokosc = listaPol[0].length();
    this.wysokosc = listaPol.length;
    this.rozmiarKlatkiMapy = rozmiarKlatkiMapy;

    this.polaEfektow = new Efekt[this.szerokosc][this.wysokosc];

    // w konstruktorze mapy przygotowujemy struktury danych ulatwiajace jej zadania
    for(int i = 0; i < this.szerokosc; ++i) {
       for(int j = 0; j < this.wysokosc; ++j) {
         
         // na razie efekty nie moga sie poruszac, nie moze byc kilku w jednym miejscu, a pola startowe robotow musza byc wolne od efektow
         if("0123456789.".contains(String.valueOf(this.listaPol[j].charAt(i))))
           this.polaEfektow[i][j] = new Efekt(this.listaPol[j].charAt(i), this.rozmiarKlatkiMapy);
         else
           this.polaEfektow[i][j] = new Efekt('.', this.rozmiarKlatkiMapy);
           
         // na razie jest tylko jeden robot
         if(this.listaPol[j].charAt(i) == 'r') {
           this.x = i;
           this.y = j;
         }
       }
    }
  }
  
  // "potok graficzny renderowania"
  void rysuj(float skala) {

    // rysowanie siatki mapy
    for(int i = 0; i <= this.wysokosc; ++i) { //<>//
      line(0, i * this.rozmiarKlatkiMapy, this.rozmiarKlatkiMapy * this.szerokosc, i * this.rozmiarKlatkiMapy);
    }
    for(int i = 0; i <= this.szerokosc; ++i) {
      line(i * this.rozmiarKlatkiMapy, 0, i * this.rozmiarKlatkiMapy, this.rozmiarKlatkiMapy * this.wysokosc);
    }
    
    // rysowanie efektow
    for(int i = 0; i < this.szerokosc; ++i) {
       for(int j = 0; j < this.wysokosc; ++j) {
             this.polaEfektow[i][j].rysuj(i * this.rozmiarKlatkiMapy, j * this.rozmiarKlatkiMapy, skala);
       }
    }

    // rysowanie robota
    circle(this.x * this.rozmiarKlatkiMapy, this.y * this.rozmiarKlatkiMapy, this.rozmiarKlatkiMapy/2);
    
    // ...
    
  }
  
  void krokNaPolnoc() {
    --this.y;
  }
  void krokNaWschod() {
    ++this.x;
  }
  void krokNaPoludnie() {
    ++this.y;
  }
  void krokNaZachod() {
    --this.x;
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
  boolean naPoludniuWolne() {
    return true; 
  }
  
}

/**********************//**********************/

class Robot {

  Mapa mapa;

  Robot(Mapa mapa) {
    this.mapa = mapa;
  }

  // robot sprawdza swoje otoczenie na mapie
  boolean naPolnocyWolne() {
    return this.mapa.naPolnocyWolne(); 
  }
  boolean naWschodzieWolne() {
    return this.mapa.naWschodzieWolne();
  }
  boolean naPoludniuWolne() {
    return this.mapa.naPoludniuWolne();
  }
  boolean naZachodzieWolne() {
    return this.mapa.naZachodzieWolne();
  }

  // robot porusza sie na mapie
  void krokWKierunku(int kierunek) {

   switch(kierunek) {
      case 0: {
        this.mapa.krokNaPolnoc();
      } break;
      case 1: {
        this.mapa.krokNaWschod();
      } break;
      case 2: {
        this.mapa.krokNaPoludnie();
      } break;
      case 3: {
        this.mapa.krokNaZachod();
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
 "....r..........",
 "...............",
 "..............."
};

Mapa mapa = new Mapa(szkieletMapy, rozmiarKlatkiMapy);

Robot robot = new Robot(mapa);

void setup() {
    size(800, 600);
}
 
void draw() {
    // "potok graficzny renderowania"
    mapa.rysuj(1);

    // tutaj rozkazy dla robota
    robot.krokWKierunku(1);

    delay(100);
}
