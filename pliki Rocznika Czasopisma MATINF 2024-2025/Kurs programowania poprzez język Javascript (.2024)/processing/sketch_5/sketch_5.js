var gwiazdy = [];
var G = 1000;
var ilosc_gwiazd = 10;

function rysuj_gwiazdy(gwiazdy) {

  for(var i = 0; i < gwiazdy.length; ++i) {
    fill(100, 50, 50);
    circle(gwiazdy[i].x, gwiazdy[i].y, gwiazdy[i].promien);
  }
  
}

function Wektor(x, y) {
   this.x = x;
   this.y = y;
   this.dlugosc = function() {
      return Math.sqrt(Math.pow(this.x, 2) + Math.pow(this.y, 2));
   };
   this.kierunek = function() {
      return new Wektor(this.x/this.dlugosc(), this.y/this.dlugosc());
   };
   this.razy = function(liczba) {
      this.x = liczba * this.x;
      this.y = liczba * this.y;
      return this;
   }
   this.dodaj = function(wektor) {
      this.x += wektor.x;
      this.y += wektor.y;
      return this;
   }
}

function przesun_gwiazdy(gwiazdy, krok_czasu) {
 
  var sumy_sil = [];
  
  //naiwne obliczenia sil grawitacji
  for(var i = 0; i < gwiazdy.length; ++i) {
    
    var suma_sil = new Wektor(0,0);
    
    for(var j = 0; j < gwiazdy.length; ++j) {
      if(i != j) {
        var przesuniecie = new Wektor(
           gwiazdy[j].x-gwiazdy[i].x,
           gwiazdy[j].y-gwiazdy[i].y
        );
        var kierunek_sily = przesuniecie.kierunek();
        var kwadrat_odleglosci_gwiazd = Math.pow(gwiazdy[j].x-gwiazdy[i].x, 2) + Math.pow(gwiazdy[j].y-gwiazdy[i].y, 2);
        var sila = kierunek_sily.razy(G*(gwiazdy[i].masa)*(gwiazdy[j].masa)/kwadrat_odleglosci_gwiazd);
        suma_sil = suma_sil.dodaj(sila);
      }
    }
    sumy_sil.push(suma_sil);
  }

  //naiwne obliczanie przesuniec gwiazd
  for(i = 0; i < gwiazdy.length; ++i) {
    gwiazdy[i].krok(sumy_sil[i], krok_czasu);
  }
  
}

function setup() {
  
  createCanvas(windowWidth, windowHeight);
  background(100,150,100);
  
  for(var i = 0; i < ilosc_gwiazd; ++i) {
    
   rozmiar_gwiazdy = 10+Math.random()*10;
   
   gwiazdy.push({
     "x" : Math.random()*width,
     "y" : Math.random()*height,
     "promien" : rozmiar_gwiazdy,
     "masa": rozmiar_gwiazdy,
     "vx" : Math.random()*50,
     "vy" : Math.random()*50,
     "krok" : function(suma_sil, krok_czasu) {
        this.vx = this.vx + suma_sil.x * krok_czasu;
        this.vy = this.vy + suma_sil.y * krok_czasu;
        this.x = this.x + this.vx * krok_czasu;
        this.y = this.y + this.vy * krok_czasu;       
     }
   }); 
  
  }
  
}

function draw() {
  
  //background(100,150,100);
  
  przesun_gwiazdy(gwiazdy, 0.1);

  rysuj_gwiazdy(gwiazdy);

}
