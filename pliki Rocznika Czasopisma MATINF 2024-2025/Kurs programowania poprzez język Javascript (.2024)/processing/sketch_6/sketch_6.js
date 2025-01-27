var gwiazdy = [];
var G = 1000;
var ilosc_gwiazd = 1000;

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

function polacz_gwiazdy() {
  
  var epsilon = 5.0
  var gwiazdy_h = [...gwiazdy];
  var polaczenie = false;
  
  while(true) {

  petla:
    for(var i = 0; i < gwiazdy_h.length; ++i) {
       for(var j = 0; j < gwiazdy_h.length; ++j) {
          if(i != j && gwiazdy_h[i].odleglosc_od(gwiazdy_h[j]) <= epsilon) {
             //dolacz lzejsza gwiazde do ciezszej
             if(gwiazdy_h[i].masa >= gwiazdy_h[j].masa) {
               gwiazdy_h[i].masa += gwiazdy_h[j].masa;
               gwiazdy_h[i].promien += gwiazdy_h[j].promien;
               gwiazdy_h.splice(j, 1);
             } else {
               gwiazdy_h[j].masa += gwiazdy_h[i].masa;
               gwiazdy_h[j].promien += gwiazdy_h[i].promien;
               gwiazdy_h.splice(i, 1);
             }
             polaczenie = true;
             break petla;
          }
       }
    }
    if(!polaczenie) {
      gwiazdy = gwiazdy_h;
      break;
    } else {
       polaczenie = false;
    }
  
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
     },
     "odleglosc_od" : function(gwiazda) {
        return Math.sqrt(Math.pow(this.x-gwiazda.x, 2) + Math.pow(this.y-gwiazda.y, 2));
     }
   }); 
  
  }
  
}

function draw() {
  
  background(100,150,100);
  
  polacz_gwiazdy();
  
  przesun_gwiazdy(gwiazdy, 0.1);

  rysuj_gwiazdy(gwiazdy);

}
