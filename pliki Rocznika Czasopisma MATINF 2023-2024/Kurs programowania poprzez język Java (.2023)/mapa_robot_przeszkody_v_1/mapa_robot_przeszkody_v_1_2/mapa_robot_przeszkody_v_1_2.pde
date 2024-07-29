/**********************//**********************/

// czy zamiast klasy nie zastosowac Javovych interfejsow?
abstract class Element {
  
  char typ;
  float rozmiar;
  
  Element(char typ, float rozmiar) {
    this.typ = typ;
    this.rozmiar = rozmiar;
  }
  
  abstract void rysuj(float x, float y, float skala);
  
}

/**********************//**********************/

class Efekt extends Element {
    
  Efekt(char typ, float rozmiar) {
    super(typ, rozmiar);
  }
    
  void rysuj(float x, float y, float skala) {
    switch(typ) {
       case '.' : {
           
       }
       break;
       case '5' : {
         for(int i = 0; i < 10; ++i) {
           circle( x + rozmiar*skala*random(-1, 1), y + rozmiar*skala*random(-1, 1), rozmiar*skala*random(-1, 1) );
         }
       }
       break;
       case '6' : {
         fill(random(0, 255), random(0, 255), random(0, 255));
         rect( x + rozmiar*skala*random(-1, 0), y + rozmiar*skala*random(-1, 0), rozmiar*skala*random(0, 1), rozmiar*skala*random(0, 1) );
         fill(255, 255, 255);
       }
       break;
       case '7' : {
         for(int i = 0; i < 10; ++i) {
           line( x + rozmiar*skala*random(-1, 1), y + rozmiar*skala*random(-1, 1), x + rozmiar*skala*random(-1, 1), y + rozmiar*skala*random(-1, 1) );
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
         this.polaEfektow[i][j] = new Efekt(this.listaPol[j].charAt(i), this.rozmiarKlatkiMapy);
           
         // na razie jest tylko jeden robot
         if(this.listaPol[j].charAt(i) == 'r') {
           this.x = i;
           this.y = j;
         }
         
       }
    }
  }
  
  void rysuj(float skala) {

    // rysowanie siatki mapy
    for(int i = 0; i <= this.wysokosc; ++i) { //<>//
      line(0, i * this.rozmiarKlatkiMapy, this.rozmiarKlatkiMapy * this.szerokosc, i * this.rozmiarKlatkiMapy);
    }
    for(int i = 0; i <= this.szerokosc; ++i) {
      line(i * this.rozmiarKlatkiMapy, 0, i * this.rozmiarKlatkiMapy, this.rozmiarKlatkiMapy * this.wysokosc);
    }
    
    // rysowanie efektow, robot tez powinien byc narysowany, a nie widac
    for(int i = 0; i < this.szerokosc; ++i) {
       for(int j = 0; j < this.wysokosc; ++j) {
             this.polaEfektow[i][j].rysuj(i * this.rozmiarKlatkiMapy, j * this.rozmiarKlatkiMapy, skala);
       }
    }
    
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

class Robot extends Element {

  Mapa mapa;

  Robot(Mapa mapa, float rozmiar) {
    // typ efektu dla robota
    super('r', rozmiar);
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
  
  void rysuj(float x, float y, float skala) {
     circle(x * rozmiar * skala, y * rozmiar * skala, skala/2);
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

Robot robot = new Robot(mapa, 1);

void setup() {
    size(800, 600);
}
 
void draw() {
    mapa.rysuj(1);

    // tutaj rozkazy dla robota
    robot.krokWKierunku(1);

    delay(100);
}
