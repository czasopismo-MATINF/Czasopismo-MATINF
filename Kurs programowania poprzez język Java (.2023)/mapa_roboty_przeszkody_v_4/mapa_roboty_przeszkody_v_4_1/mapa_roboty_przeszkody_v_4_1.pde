import java.util.*; //<>//

/**********************//**********************/

// klasa elementow umieszczanych na mapie
abstract class Element {
  
  char typ;
  float rozmiarKlatkiMapy;
  
  Element(char typ, float rozmiarKlatkiMapy) {
    this.typ = typ;
    this.rozmiarKlatkiMapy = rozmiarKlatkiMapy;
  }
  
  abstract void rysuj(float skala);
  
  void resetStroke() {
     stroke(0, 0, 0); 
  }
  
  void resetFill() {
     fill(255,255,255); 
  }
  
}

/**********************//**********************/

// klasa efektow umieszczanych na mapie
class Efekt extends Element {
    
  Efekt(char typ, float rozmiarKlatkiMapy) {
    super(typ, rozmiarKlatkiMapy);
  }
  
  void rysuj(float skala) {
    switch(typ) {
      
       case '.' : {
           
       }
       break;
       
       // proponowany efekt zderzenia, dymu
       case '4' : {
         fill(120, 120, 120);
         for(int yl = 1; yl < 10; ++yl) {
           for(int i = 1; i < 10; ++i) {
             float xt = random(-1, 1) * super.rozmiarKlatkiMapy * skala / 2 * yl / 10;
             float yt = - yl * super.rozmiarKlatkiMapy * skala / 10 + super.rozmiarKlatkiMapy / 3;
              translate(xt, yt);
              circle(0, 0, super.rozmiarKlatkiMapy * skala * random(-1, 1) * yl / 20 );
              translate(-xt, -yt);
           }
         }
       }
       break;
       
       // proponowany efekt niszczacej pulapki
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
       
       // proponowany efekt teleportacji
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
  // wewnetrzna mapa obiektowa, w Javie nie ma tupli, nalezaloby napisac wlasna generyczna strukture danych: n.p. Pola<Integer, Integer, List<Element>>
  Map<Integer, Map<Integer, List<Element>>> polaElementow;

  // pomocnicza lista robotow na mapie obiektowej, udostepniona uzytkownikowi, zawiera rowniez roboty usuniete z mapy n.p. po zderzeniach
  List<Robot> roboty = new LinkedList<>();

  List<Robot> robotyNaMapie() {
      return this.roboty;
  }
  
  Mapa(String[] listaPol, int rozmiarKlatkiMapy) {

    this.listaPol = listaPol;

    // na razie program dziala tylko z prostokatnym planem mapy
    this.szerokosc = listaPol[0].length();
    this.wysokosc = listaPol.length;
    this.rozmiarKlatkiMapy = rozmiarKlatkiMapy;

    this.polaElementow = new HashMap<>();

    // w konstruktorze mapy przygotowujemy struktury danych ulatwiajace jej zadania
    // na pojedynczych polach mapy moze byc wiecej obiektow
    for(int i = 0; i < this.szerokosc; ++i) {
       this.polaElementow.put(i, new HashMap<Integer, List<Element>>());
       for(int j = 0; j < this.wysokosc; ++j) {
         
         // pole jest lista elementow
         List<Element> pole = new LinkedList<Element>();
         
         // dodanie elementu do listy na polu
         Element element = utworzElement(this.listaPol[j].charAt(i), this.rozmiarKlatkiMapy);
         if(element != null) pole.add(element);
         
         // zapamietanie dla uzytkownika, jesli to jest robot
         if(this.listaPol[j].charAt(i) == 'r') {
           this.roboty.add((Robot) element);
         }
         
         // umieszczenie listy (pola) na mapie
         this.polaElementow.get(i).put(j, pole);

       }
    }
  }
  
  // metoda "fabryczna" elementow - efektow i robotow
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
  
  /**********************************************/
  // PROCEDURY MECHANIKI NA MAPIE
  
  // wykonanie po jednym rozkazie z kolejek rozkazow robotow
  void dzialaj() {
    // odczytanie i wykonanie pojedynczego rozkazu kazdego robota na mapie
    List<Robot> roboty = this.listaWszystkichRobotowNaMapie();
    for(Robot robot : roboty) {
      Rozkaz rozkaz = robot.rozkazy.poll();
      if(rozkaz != null) {
        this.wykonajRozkaz(robot, rozkaz);
      }
    }
    
    // pulapki niszczace roboty
    for(int i = 0; i < this.szerokosc; ++i) {
       for(int j = 0; j < this.wysokosc; ++j) {
         if(this.polaElementow.get(i).get(j).size() >= 2) {
           if( this.czyNaPoluJestPulapka(i, j) ) usunRobotyZPola(i, j);
         }
     }
    }
    
    // teleportacje robotow
    for(int i = 0; i < this.szerokosc; ++i) {
       for(int j = 0; j < this.wysokosc; ++j) {
         if(this.polaElementow.get(i).get(j).size() >= 2) {
           if( this.czyNaPoluJestTeleportacja(i, j) ) teleportujRobotyZPola(i, j);
         }
     }
    }
    
    // kolizje co najmniej dwoch robotow
    for(int i = 0; i < this.szerokosc; ++i) {
       for(int j = 0; j < this.wysokosc; ++j) {
         if(this.polaElementow.get(i).get(j).size() >= 2) {
           if(this.robotyNaPolu(i, j).size() >= 2 || czyNaPoluJestKraksa(i, j)) {
             this.polaElementow.get(i).get(j).clear();
             this.polaElementow.get(i).get(j).add(this.utworzElement('4', this.rozmiarKlatkiMapy));
           } 
         }
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
  
  List<Robot> robotyNaPolu(int i, int j) {
     List<Robot> roboty = new LinkedList<>();
     for(Element e : this.polaElementow.get(i).get(j)) {
       try { roboty.add((Robot) e); }
       catch(Exception exception) {}
     }
     return roboty;
  }
  
  boolean czyNaPoluJestKraksa(int i, int j) {
    for(Element element : this.polaElementow.get(i).get(j)) {
      if(element.typ == '4') return true;
    }
    return false; 
  }
  
  boolean czyNaPoluJestPulapka(int i, int j) {
    for(Element element : this.polaElementow.get(i).get(j)) {
      if(element.typ == '5') return true;
    }
    return false;
  }
  
  boolean czyNaPoluJestTeleportacja(int i, int j) {
    for(Element element : this.polaElementow.get(i).get(j)) {
      if(element.typ == '6') return true;
    }
    return false;
  }

  void usunRobotyZPola(int i, int j) {
     for(Robot robot : this.robotyNaPolu(i, j)) {
       this.polaElementow.get(i).get(j).remove(robot);
     }
  }
  
  void teleportujRobotyZPola(int i, int j) {
     List<Robot> roboty =  this.robotyNaPolu(i, j);
     for(Robot robot : roboty) {
       this.polaElementow.get(i).get(j).remove(robot);
     }
     for(Robot robot : roboty) {
        int x = (int) random(this.szerokosc);
        int y = (int) random(this.wysokosc);
        this.polaElementow.get(x).get(y).add(robot);
     }
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
     if(this.polaElementow.get(i).get(j).isEmpty()) return false;
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

  // ta metoda nie sprawdza poprawnosci: n.p. czy docelowe miejsce jest wolne
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
  
  boolean naZachodzieWolne(Robot robot) {
    Vector<Integer> miejsce = this.gdzieJestObiekt(robot);
    if(miejsce == null) return false;
    int x = miejsce.get(0);
    int y = miejsce.get(1);
    return this.czyZajete(x-1, y);
  }
  boolean naWschodzieWolne(Robot robot) {
    Vector<Integer> miejsce = this.gdzieJestObiekt(robot);
    if(miejsce == null) return false;
    int x = miejsce.get(0);
    int y = miejsce.get(1);
    return this.czyZajete(x+1, y);
  }
  boolean naPolnocyWolne(Robot robot) {
    Vector<Integer> miejsce = this.gdzieJestObiekt(robot);
    if(miejsce == null) return false;
    int x = miejsce.get(0);
    int y = miejsce.get(1);
    return this.czyZajete(x, y-1); 
  }
  boolean naPoludniuWolne(Robot robot) {
    Vector<Integer> miejsce = this.gdzieJestObiekt(robot);
    if(miejsce == null) return false;
    int x = miejsce.get(0);
    int y = miejsce.get(1);
    return this.czyZajete(x, y+1); 
  }
  
  // zwraca liste elementow na polu na polnoc, wschod, poludnie lub zachod od robota
  List<Element> obiektyWSasiedztwie(Robot robot, int kierunek) {
    Vector<Integer> miejsce = this.gdzieJestObiekt(robot);
    if(miejsce == null) return null;
    int x = miejsce.get(0);
    int y = miejsce.get(1);
    if(kierunek == 0) {
      if(this.czyPozaMapa(x, y-1)) return null;
      return new LinkedList<>(this.polaElementow.get(x).get(y-1));
    } else if(kierunek == 1) {
      if(this.czyPozaMapa(x+1, y)) return null;
      return new LinkedList<>(this.polaElementow.get(x+1).get(y));
    } else if(kierunek == 2) {
      if(this.czyPozaMapa(x, y+1)) return null;
      return new LinkedList<>(this.polaElementow.get(x).get(y+1));
    } else if(kierunek == 3) {
      if(this.czyPozaMapa(x-1, y)) return null;
      return new LinkedList<>(this.polaElementow.get(x-1).get(y));
    }
    return null; 
  }
  
}

/**********************//**********************/

// klasa rozkazow wypelnianych przez roboty, na razie tylko poruszanie sie po mapie
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

// klasa robotow przyjmujacych rozkazy od uzytkownika
class Robot extends Element {

  Mapa mapa;
  // kolejka rozkazow robota przy uzyciu odpowiedniej klasy Javy z uzyciem typu generycznego (generics)
  Queue<Rozkaz> rozkazy;
  
  // kolor robota nadawany przez uzytkownika po jego utworzeniu na mapie
  int r,g,b;
  
  // blok inicjalizujacy pola obiektu, poczytac o kolejnosci wykonywania takich blokow oraz konstruktorow
  {
    this.rozkazy = new LinkedList<>();
  }

  Robot(Mapa mapa, float rozmiarKlatkiMapy) {
    // typ efektu dla robota
    super('r', rozmiarKlatkiMapy);
    this.mapa = mapa;
  }
  
  void setColor(int r, int g, int b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  // roboty rysuja sie w punkcie (0,0), przesuniecie do pola mapy jest wykonywane podczas rysowania mapy przy pomocy metody translate
  void rysuj(float skala) {
     stroke(this.r, this.g, this.b);
     fill(this.r, this.g, this.b);
     circle(0, 0, rozmiarKlatkiMapy * skala / 2);
     resetStroke();
     resetFill();
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
  
  List<Element> obiektyWSasiedztwie(int kierunek) { return this.mapa.obiektyWSasiedztwie(this, kierunek); }

  // robot porusza sie po mapie
  void krokWKierunku(int kierunek) {
    this.rozkazy.add(new Rozkaz(kierunek));
  }

}

/**********************//**********************/

int rozmiarKlatkiMapy = 20;

// poprawic tak, by wyswietlaly sie mapy innych ksztaltow niz prostokatne
String[] szkieletMapy = new String[] {
 "........................................",
 "........................................",
 "55555555555.5555555555555555555555555555",
 "..r.......r..........r......r........r..",
 "..................r..................r..",
 "......r...r.............r...r........r..",
 "..................r..................r..",
 "....r.....r....r.......r.....r.......r..",
 "..r........r........r................r..",
 ".......r....r.....r..........r.......r..",
 "6666666666666666666666666666666666666666"
};

Mapa mapa = new Mapa(szkieletMapy, rozmiarKlatkiMapy);

List<Robot> roboty = mapa.robotyNaMapie();

void setup() {
  
  size(800, 600);
    
  // nadanie kolorow robotom
  for(Robot robot : roboty) {
     robot.setColor((int) random(255), (int) random(255), (int) random(255)); 
  }
  
}
 
void draw() {
    // bez sladow robota
    background(200,200,200);
    mapa.dzialaj();
    mapa.rysuj(1);

    // tutaj rozkazy dla robotow na najblizsza ture
    
    // zmasowany pochod na polnoc
    //for(Robot robot : roboty) robot.krokWKierunku(0);
    
    // roboty chodzace losowo, kolizje ze wszystkim
    // 0 - polnoc, 1 - wschod, 2 - poludnie, 4 - zachod
    /*
    for(Robot robot : mapa.robotyNaMapie()) {
       robot.krokWKierunku((int) random(4));
    }
    */
    
    // proste czesciowe ominiecie bariery polnocnej
    // idz na poludnie do miejsc teleportacji, chyba, ze na poludnie jest juz pulapka
    for(Robot robot : roboty) {
      List<Element> naPoludnie = robot.obiektyWSasiedztwie(2);
      if(! (naPoludnie != null && !naPoludnie.isEmpty() && naPoludnie.get(0).typ == '5')) {
        robot.krokWKierunku(2);
      }
    }

    delay(100);
}
