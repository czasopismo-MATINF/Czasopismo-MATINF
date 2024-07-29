import java.util.*; //<>//
/**********************//**********************/

// czy zamiast klasy nie zastosowac Javovych interfejsow?
abstract class Element {
  
  char typ;
  float rozmiarKlatkiMapy;
  
  Element(char typ, float rozmiarKlatkiMapy) {
    this.typ = typ;
    this.rozmiarKlatkiMapy = rozmiarKlatkiMapy;
  }
  
  abstract void rysuj(float skala);
  
}

/**********************//**********************/

class Efekt extends Element {
    
  Efekt(char typ, float rozmiar) {
    super(typ, rozmiar);
  }
  
  void resetFill() {
     fill(255,255,255); 
  }
  
  // efekty rysuja sie w punkcie (0,0), przesuniecie do pola mapy jest wykonywane podczas rysowania mapy przy pomocy metody translate
  void rysuj(float skala) {
    switch(typ) {
      
       case '.' : {
           
       }
       break;
       
       // proponowany efekt zderzenia
       case '4' : {
         fill(120, 120, 120);
         for(int yl = 1; yl < 10; ++yl) {
           for(int i = 1; i < 10; ++i) {
             float xt = random(-1, 1) * super.rozmiarKlatkiMapy * skala / 2 * yl / 10;
             float yt = - yl * super.rozmiarKlatkiMapy * skala / 10;
              translate(xt, yt);
              circle(0, 0, super.rozmiarKlatkiMapy * skala * random(-1, 1) * yl / 20 );
              translate(-xt, -yt);
           }
         }
       }
       break;
       
       case '5' : {
         for(int i = 0; i < 10; ++i) {
           float xt = random(-1, 1) * super.rozmiarKlatkiMapy * skala / 2;
           float yt = random(-1, 1) * super.rozmiarKlatkiMapy * skala / 2;
           translate(xt, yt);
           circle( 0, 0, super.rozmiarKlatkiMapy*skala*random(-1, 1) );
           translate(-xt, -yt);  
       }
       }
       break;
       
       case '6' : {
         for(int i = 0; i < 10; ++i) {
           fill(random(0, 255), random(0, 255), random(0, 255));
           float xt = random(-1, 0) * super.rozmiarKlatkiMapy * skala;
           float yt = random(-1, 0) * super.rozmiarKlatkiMapy * skala;
           translate(xt, yt);
           rect( 0, 0, rozmiarKlatkiMapy*skala*random(0, 1), rozmiarKlatkiMapy*skala*random(0, 1) );
           translate(-xt, -yt);
         }
       }
       break;
       
       // proponowany efekt ladowania
       case '7' : {
         for(int i = 0; i < 10; ++i) {
           line( rozmiarKlatkiMapy*skala*random(-1, 1), rozmiarKlatkiMapy*skala*random(-1, 1), rozmiarKlatkiMapy*skala*random(-1, 1), rozmiarKlatkiMapy*skala*random(-1, 1) );
         }
       }
       break;
       
    }
    
    this.resetFill();
    
  }

}

/**********************//**********************/

class Mapa {

  // mapa utworzona przez uzytkownika w formie napisow list
  String[] listaPol;

  // na razie program dziala tylko z prostokatnym planem mapy
  int szerokosc;
  int wysokosc;
  
  int rozmiarKlatkiMapy;

  // glownym skladnikiem mapy jest pole elementow
  /*Element[][] polaElementow;*/
  // wewnetrzna mapa obiektowa, w Javie nie ma tupli, nalezaloby napisac wlasna generyczna strukture danych: n.p. Pola<Integer, Integer, List<Element>>
  Map<Integer, Map<Integer, List<Element>>> polaElementow;

  // pomocnicza lista robotow na mapie obiektowej, udostepniona uzytkownikowi
  List<Robot> roboty = new LinkedList<>();
  
  Mapa(String[] listaPol, int rozmiarKlatkiMapy) {

    this.listaPol = listaPol;

    // na razie program dziala tylko z prostokatnym planem mapy
    this.szerokosc = listaPol[0].length();
    this.wysokosc = listaPol.length;
    this.rozmiarKlatkiMapy = rozmiarKlatkiMapy;

    /*this.polaElementow = new Element[this.szerokosc][this.wysokosc];*/
    this.polaElementow = new HashMap<>();

    // w konstruktorze mapy przygotowujemy struktury danych ulatwiajace jej zadania
    // na pojedynczych polach mapy moze byc teraz wiecej obiektow
    for(int i = 0; i < this.szerokosc; ++i) {
       this.polaElementow.put(i, new HashMap<Integer, List<Element>>());
       for(int j = 0; j < this.wysokosc; ++j) {
         
         // pole jest lista elementow
         List<Element> pole = new LinkedList<Element>();
         
         // dodanie elementu do listy na polu
         Element element = utworzElement(this.listaPol[j].charAt(i), this.rozmiarKlatkiMapy);
         if(element != null) pole.add(element);
         
         // zapamietanie, jesli to jest robot
         if(this.listaPol[j].charAt(i) == 'r') {
           this.roboty.add((Robot) element);
         }
         
         // umieszczenie listy (pola) na mapie
         this.polaElementow.get(i).put(j, pole);

       }
    }
  }

  // pomocnicza lista robotow na mapie obiektowej, udostepniona uzytkownikowi
  List<Robot> robotyNaMapie() {
      return this.roboty;
  }
  
  void rysuj(float skala) {

    // rysowanie siatki mapy
    for(int i = 0; i <= this.wysokosc; ++i) {
      line(0, i * this.rozmiarKlatkiMapy, this.rozmiarKlatkiMapy * this.szerokosc, i * this.rozmiarKlatkiMapy);
    }
    for(int i = 0; i <= this.szerokosc; ++i) {
      line(i * this.rozmiarKlatkiMapy, 0, i * this.rozmiarKlatkiMapy, this.rozmiarKlatkiMapy * this.wysokosc);
    }

    // rysowanie elementow
    for(int i = 0; i < this.szerokosc; ++i) {
       for(int j = 0; j < this.wysokosc; ++j) {
         translate( i * this.rozmiarKlatkiMapy, j * this.rozmiarKlatkiMapy);
         for(Element e : this.polaElementow.get(i).get(j)) {
           e.rysuj(skala);
         }
        translate( - i * this.rozmiarKlatkiMapy, - j * this.rozmiarKlatkiMapy);
     }
    }
  }
  
  List<Robot> listaWszystkichRobotowNaMapie() {
    List<Robot> roboty = new LinkedList<>();
    for(int i = 0; i < this.szerokosc; ++i) {
       for(int j = 0; j < this.wysokosc; ++j) {
         for(Element e : this.polaElementow.get(i).get(j)) {
           // czy to jest zgodne z dobrymi praktykami programistycznymi ?
           try { roboty.add((Robot) e); }
           catch(Exception exception) {}
         }
     }
    }
    return roboty;
  }
  
  // wykonanie po jednym rozkazie z kolejek rozkazow robotow
  void dzialaj() {
    // odczytanie pojedynczego rozkazu kazdego robota na mapie
    List<Robot> roboty = this.listaWszystkichRobotowNaMapie();
    for(Robot robot : roboty) {
      Rozkaz rozkaz = robot.rozkazy.poll();
      if(rozkaz != null) {
        this.wykonajRozkaz(robot, rozkaz);
      }
    }
    
    // wkrywanie zdarzen, na razie tylko kolizji z zastapieniem efektem dymu
    for(int i = 0; i < this.szerokosc; ++i) {
       for(int j = 0; j < this.wysokosc; ++j) {
         if(this.polaElementow.get(i).get(j).size() >= 2) {
           // tutaj dla odmiany, znikanie robotow i efektow przy zderzeniach
           this.polaElementow.get(i).get(j).clear();
         }
     }
    }
    
  }
  
  // na razie, sposrod obiektow na mapie, tylko roboty wykonuja rozkazy
  void wykonajRozkaz(Robot robot, Rozkaz rozkaz) {
    Vector<Integer> miejsce = this.gdzieJestObiekt(robot);
    int x = miejsce.get(0);
    int y = miejsce.get(1);
    if(rozkaz.getKierunek() == 0) {
      this.krokNaPolnoc(robot, x, y);
    } else if(rozkaz.getKierunek() == 1) {
      this.krokNaWschod(robot, x, y);
    } else if(rozkaz.getKierunek() == 2) {
      this.krokNaPoludnie(robot, x, y);
    } else if(rozkaz.getKierunek() == 3) {
      this.krokNaZachod(robot, x, y);
    }
  }
  
  // metoda "fabryczna"
  Element utworzElement(char typ, float rozmiar) {
     switch(typ) {
        case '4' :
        case '5' :
        case '6' :
        case '7' : return new Efekt(typ, rozmiar);
        case 'r' : return new Robot(this, rozmiar);
        // pola puste
        default: return null;
     }
  }
  
  boolean czyPozaMapa(int i, int j) {
     if(i < 0 || i + 1 > this.szerokosc) {
        return true; 
     }
     if(j < 0 || j + 1 > this.wysokosc) {
       return true;
     }
     return false;
  }

  // by przez pomylke nie napisac rozkazow dla robota sprawdzajacych niesasiadujace pola, ta metoda ma zakres widocznosci prywatny
  private boolean czyZajete(int i, int j) {
     if(this.czyPozaMapa(i, j)) return true;
     if(!this.polaElementow.get(i).get(j).isEmpty()) return false;
     return true;
  }
  
  boolean czyZablokowane(int i, int j) {
     if(this.czyPozaMapa(i, j)) return true;
     /* blokuje kolizje
     if(!this.polaElementow.get(i).get(j).isEmpty()) return false;
     return true;
     */
     return false;
  }
  
  // metoda nie sprawdza poprawnosci: n.p. czy docelowe miejsce jest wolne
  private void przesunRobota (Robot robot, int xp, int yp, int xk, int yk) {
    /* po poprzedniej wersji programu
    this.polaElementow[xk][yk] = this.polaElementow[xp][yp];
    this.polaElementow[xp][yp] = null;
    this.x = xk;
    this.y = yk;
    */
    // przesuniecie robota jest usunieciem go z listy pola (xp,yp) i dodaniem do listy pola (xk, yk)
    this.polaElementow.get(xp).get(yp).remove(robot);
    this.polaElementow.get(xk).get(yk).add(robot);
  }

  boolean krokNaPolnoc(Robot robot, int x, int y) {
    if(y == 0 || this.czyZablokowane(x, y-1)) return false;
    this.przesunRobota(robot, x,y,x,y-1);
    return true;
  }
  boolean krokNaWschod(Robot robot, int x, int y) {
    if(x+1 == this.szerokosc || this.czyZablokowane(x+1, y)) return false;
    this.przesunRobota(robot, x,y,x+1,y);
    return true;
  }
  boolean krokNaPoludnie(Robot robot, int x, int y) {
    if(y+1 == this.wysokosc || this.czyZablokowane(x, y+1)) return false;
    this.przesunRobota(robot, x,y,x,y+1);
    return true;
  }
  boolean krokNaZachod(Robot robot, int x, int y) {
    if(x == 0 || this.czyZablokowane(x-1, y)) return false;
    this.przesunRobota(robot, x,y,x-1,y);
    return true;
  }
  
  // ze wzgledu na brak tupli w Javie wykorzystanie klasy Vector, metoda bardzo skomplikowanie wyglada
  Vector<Integer> gdzieJestObiekt(Element element) {
     Vector<Integer> odpowiedz = new Vector<>();
     for(Map.Entry<Integer, Map<Integer, List<Element>>> e : this.polaElementow.entrySet()) {
       for(Map.Entry<Integer, List<Element>> f : e.getValue().entrySet()) {
         if(f.getValue().contains(element)) {
            odpowiedz.add(e.getKey());
            odpowiedz.add(f.getKey());
            return odpowiedz;
         }
       }
     }
     return null;
  }
  
  boolean naZachodzieWolne(Robot robot) {
    Vector<Integer> miejsce = this.gdzieJestObiekt(robot);
    int x = miejsce.get(0);
    int y = miejsce.get(1);
    return this.czyZajete(x-1, y);
  }
  boolean naWschodzieWolne(Robot robot) {
    Vector<Integer> miejsce = this.gdzieJestObiekt(robot);
    int x = miejsce.get(0);
    int y = miejsce.get(1);
    return this.czyZajete(x+1, y);
  }
  boolean naPolnocyWolne(Robot robot) {
    Vector<Integer> miejsce = this.gdzieJestObiekt(robot);
    int x = miejsce.get(0);
    int y = miejsce.get(1);
    return this.czyZajete(x, y-1); 
  }
  boolean naPoludniuWolne(Robot robot) {
    Vector<Integer> miejsce = this.gdzieJestObiekt(robot);
    int x = miejsce.get(0);
    int y = miejsce.get(1);
    return this.czyZajete(x, y+1); 
  }
  
}

/**********************//**********************/

// umieszczajac obiekty w kolekcjach Javy raczej trzeba nadac im wspolny typ - klase lub interfejs (generics)
class Rozkaz {
  
  int kierunek;
  
  Rozkaz(int kierunek) {
    this.kierunek = kierunek;
  }
  
  // gettery, settery, standardowy sposob enkapsulacji klasy w Javie
  
  int getKierunek() {
    return this.kierunek;
  }
  
  void setKierunek(int kierunek) {
     this.kierunek = kierunek; 
  }
  
}

/**********************//**********************/

class Robot extends Element {

  Mapa mapa;
  // kolejka rozkazow robota przy uzyciu odpowiedniej klasy Javy z uzyciem typu generycznego (generics)
  Queue<Rozkaz> rozkazy;
  
  // blok inicjalizujacy pola obiektu, poczytac o kolejnosci wykonywania takich blokow oraz konstruktorow
  {
    this.rozkazy = new LinkedList<>();
  }

  Robot(Mapa mapa, float rozmiar) {
    // typ efektu dla robota
    super('r', rozmiar);
    this.mapa = mapa;
  }
  
  // roboty rysuja sie w punkcie (0,0), przesuniecie do pola mapy jest wykonywane podczas rysowania mapy przy pomocy metody translate
  void rysuj(float skala) {
     circle(0, 0, rozmiarKlatkiMapy * skala / 2);
  }

  // robot sprawdza swoje otoczenie na mapie
  boolean naPolnocyWolne() {
    return this.mapa.naPolnocyWolne(this); 
  }
  boolean naWschodzieWolne() {
    return this.mapa.naWschodzieWolne((this));
  }
  boolean naPoludniuWolne() {
    return this.mapa.naPoludniuWolne((this));
  }
  boolean naZachodzieWolne() {
    return this.mapa.naZachodzieWolne((this));
  }

  // robot porusza sie po mapie
  void krokWKierunku(int kierunek) {
    this.rozkazy.add(new Rozkaz(kierunek));
  }

}

/**********************//**********************/

int rozmiarKlatkiMapy = 20;

// poprawic tak, by wyswietlaly sie mapy innych ksztaltow niz prostokatne
String[] szkieletMapy = new String[] {
 "....7..r...6.........r....r.........r...",
 ".7...5.........r......................4.",
 "..r..6....r..........r......r......5.r..",
 "...........7......r.....................",
 "..5...r...r.............r...r......6.r..",
 ".7.6.5............r.....................",
 "....r.....r....r.......r.....r.....5.r..",
 "..r....5...r........r...................",
 ".......r....r.....r..........r.....6.r..",
 "..7.....r..........r....r...........r..."
};

Mapa mapa = new Mapa(szkieletMapy, rozmiarKlatkiMapy);

List<Robot> roboty = mapa.robotyNaMapie();

void setup() {
    size(800, 600);
}
 
void draw() {
    // bez sladow robota
    background(200,200,200);
    mapa.dzialaj();
    mapa.rysuj(1);

    // tutaj rozkazy dla robotów
    // zmasowany pochod na polnoc
    for(Robot robot : roboty) robot.krokWKierunku(0);
    
    // roboty chodzace losowo, kolizje ze wszystkim
    // 0 - polnoc, 1 - wschod, 2 - poludnie, 4 - zachod
    /*
    for(Robot robot : mapa.robotyNaMapie()) {
       robot.krokWKierunku((int) random(4));
    }
    */

    delay(100);
}
