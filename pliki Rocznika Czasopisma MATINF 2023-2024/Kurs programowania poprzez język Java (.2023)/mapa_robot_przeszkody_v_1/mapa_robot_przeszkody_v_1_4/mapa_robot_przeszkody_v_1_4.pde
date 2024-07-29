/**********************//**********************/

// czy zamiast klasy nie zastosowac Javovych interfejsow?
abstract class Element {
  
  char typ;
  float rozmiarKlatkiMapy;
  
  Element(char typ, float rozmiarKlatkiMapy) {
    this.typ = typ;
    this.rozmiarKlatkiMapy = rozmiarKlatkiMapy;
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
           circle( x + rozmiarKlatkiMapy*skala*random(-1, 1), y + rozmiarKlatkiMapy*skala*random(-1, 1), rozmiarKlatkiMapy*skala*random(-1, 1) );
         }
       }
       break;
       case '6' : {
         fill(random(0, 255), random(0, 255), random(0, 255));
         rect( x + rozmiarKlatkiMapy*skala*random(-1, 0), y + rozmiarKlatkiMapy*skala*random(-1, 0), rozmiarKlatkiMapy*skala*random(0, 1), rozmiarKlatkiMapy*skala*random(0, 1) );
         fill(255, 255, 255);
       }
       break;
       case '7' : {
         for(int i = 0; i < 10; ++i) {
           line( x + rozmiarKlatkiMapy*skala*random(-1, 1), y + rozmiarKlatkiMapy*skala*random(-1, 1), x + rozmiarKlatkiMapy*skala*random(-1, 1), y + rozmiarKlatkiMapy*skala*random(-1, 1) );
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

  // glownym skladnikiem mapy jest pole elementow
  Element[][] polaElementow;

  // atrybuty pomocnicze, powielone informacje znajdujace sie rowniez w atrybucie klasy - polu elementow - mapy
  Robot robot;
  int x,y;  // pole z robotem

  Mapa(String[] listaPol, int rozmiarKlatkiMapy) {

    this.listaPol = listaPol;

    // na razie program dziala tylko z prostokatnym planem mapy
    this.szerokosc = listaPol[0].length();
    this.wysokosc = listaPol.length;
    this.rozmiarKlatkiMapy = rozmiarKlatkiMapy;

    this.polaElementow = new Element[this.szerokosc][this.wysokosc];

    // w konstruktorze mapy przygotowujemy struktury danych ulatwiajace jej zadania
    for(int i = 0; i < this.szerokosc; ++i) {
       for(int j = 0; j < this.wysokosc; ++j) {

         // na razie efekty nie moga sie poruszac, nie moze byc kilku w jednym miejscu, pola zajmowane przez roboty musza byc wolne od innych elementow
         this.polaElementow[i][j] = utworzElement(this.listaPol[j].charAt(i), this.rozmiarKlatkiMapy);

         // zapamietanie na razie tylko jednego utworzonego robota
         if(this.listaPol[j].charAt(i) == 'r') {
           this.x = i;
           this.y = j;
           this.robot = (Robot) this.polaElementow[i][j];
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

    // rysowanie elementow
    for(int i = 0; i < this.szerokosc; ++i) {
       for(int j = 0; j < this.wysokosc; ++j) {
             if(this.polaElementow[i][j] != null) this.polaElementow[i][j].rysuj(i * this.rozmiarKlatkiMapy, j * this.rozmiarKlatkiMapy, skala);
       }
    }
  }

  // metoda "fabryczna"
  Element utworzElement(char typ, float rozmiar) {
     switch(typ) {
        case '5' :
        case '6' :
        case '7' : return new Efekt(typ, rozmiar);
        case 'r' : return new Robot(this, rozmiar);
        // pola puste
        default: return null;
     }
  }

  // by przez pomylke nie napisac rozkazow dla robota sprawdzajacych niesasiadujace pola, ta metoda ma zakres widocznosci prywatny
  private boolean czyZajete(int x, int y) {
     if(this.polaElementow[x][y] != null) return true;
     return false;
  }
  // metoda nie sprawdza poprawnosci: n.p. czy docelowe miejsce jest wolne
  private void przesunRobota (int xp, int yp, int xk, int yk) {
    this.polaElementow[xk][yk] = this.polaElementow[xp][yp];
    this.polaElementow[xp][yp] = null;
    this.x = xk;
    this.y = yk;
  }

  // ruchy kolizyjne nie sa wykonywane
  boolean krokNaPolnoc() {
    if(this.y == 0 || this.czyZajete(this.x, this.y-1)) return false;
    this.przesunRobota(x,y,x,y-1);
    return true;
  }
  boolean krokNaWschod() {
    if(this.x+1 == this.szerokosc || this.czyZajete(this.x+1, this.y)) return false;
    this.przesunRobota(x,y,x+1,y);
    return true;
  }
  boolean krokNaPoludnie() {
    if(this.y+1 == this.wysokosc || this.czyZajete(this.x, this.y+1)) return false;
    this.przesunRobota(x,y,x,y+1);
    return true;
  }
  boolean krokNaZachod() {
    if(this.x == 0 || this.czyZajete(this.x-1, this.y)) return false;
    this.przesunRobota(x,y,x-1,y);
    return true;
  }
  
  boolean naZachodzieWolne() {
    return this.czyZajete(this.x-1, this.y);
  }
  boolean naWschodzieWolne() {
    return this.czyZajete(this.x+1, this.y);
  }
  boolean naPolnocyWolne() {
    return this.czyZajete(this.x, this.y-1); 
  }
  boolean naPoludniuWolne() {
    return this.czyZajete(this.x, this.y+1); 
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
     circle(x, y, rozmiarKlatkiMapy * skala / 2);
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
 "r..........6...",
 "...............",
 "..............."
};

Mapa mapa = new Mapa(szkieletMapy, rozmiarKlatkiMapy);

void setup() {
    size(800, 600);
}
 
void draw() {
    // bez sladow robota
    //background(200,200,200);
    mapa.rysuj(1);

    // tutaj rozkazy dla robota
    // mapa.robot.krokWKierunku(1);
    
    // robot chodzacy losowo, ruch kolizyjny nie jest wykonywany
    mapa.robot.krokWKierunku((int) random(4));

    delay(100);
}
