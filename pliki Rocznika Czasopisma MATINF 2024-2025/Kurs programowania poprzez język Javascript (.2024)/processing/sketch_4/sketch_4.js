var gwiazdy = [];
var G = 1000;
var ilosc_gwiazd = 10;

function rysuj_gwiazdy(gwiazdy) {

  for(var i = 0; i < gwiazdy.length; ++i) {
    fill(100, 50, 50);
    circle(gwiazdy[i][0], gwiazdy[i][1], gwiazdy[i][2]);
  }
  
}

function przesun_gwiazdy(gwiazdy, krok_czasu) {
 
  var sumy_sil = [];
  
  //naiwne obliczenia sil grawitacji
  for(var i = 0; i < gwiazdy.length; ++i) {
    var suma_sil = [0, 0];
    for(var j = 0; j < gwiazdy.length; ++j) {
      if(i != j) {
        var wektor_przesuniecia = [ gwiazdy[j][0]-gwiazdy[i][0], gwiazdy[j][1]-gwiazdy[i][1] ];
        var dlugosc_wektora_przesuniecia = Math.sqrt(Math.pow(wektor_przesuniecia[0],2) + Math.pow(wektor_przesuniecia[1],2));
        var kierunek_sily = [wektor_przesuniecia[0] / dlugosc_wektora_przesuniecia, wektor_przesuniecia[1] / dlugosc_wektora_przesuniecia];
        var kwadrat_odleglosci_gwiazd = Math.pow(gwiazdy[j][0]-gwiazdy[i][0], 2) + Math.pow(gwiazdy[j][1]-gwiazdy[i][1], 2);
        var sila = [G * kierunek_sily[0] * gwiazdy[i][3] * gwiazdy[j][3] / kwadrat_odleglosci_gwiazd, G * kierunek_sily[1] * gwiazdy[i][3] * gwiazdy[j][3] / kwadrat_odleglosci_gwiazd];
        suma_sil = [suma_sil[0] + sila[0], suma_sil[1] + sila[1]];
      }
    }
    sumy_sil.push(suma_sil);
  }

  //naiwne obliczanie przesuniec gwiazd
  for(i = 0; i < gwiazdy.length; ++i) {
    gwiazdy[i][4] = gwiazdy[i][4] + sumy_sil[i][0] * krok_czasu;
    gwiazdy[i][5] = gwiazdy[i][5] + sumy_sil[i][1] * krok_czasu;

    gwiazdy[i][0] = gwiazdy[i][0] + gwiazdy[i][4] * krok_czasu;
    gwiazdy[i][1] = gwiazdy[i][1] + gwiazdy[i][5] * krok_czasu;
  }
  
}

function setup() {
  
  createCanvas(windowWidth, windowHeight);
  background(100,150,100);
  
  for(var i = 0; i < ilosc_gwiazd; ++i) {
   /* [x, y, rozmiar, waga, predkosc x, predkosc y ] gwiazdy */
   rozmiar_gwiazdy = 10+Math.random()*10;
   gwiazdy.push([Math.random()*width, Math.random()*height, rozmiar_gwiazdy, rozmiar_gwiazdy, Math.random()*50, Math.random()*50]); 
  }
  
}

function draw() {
  
  //background(100,150,100);
  
  przesun_gwiazdy(gwiazdy, 0.1);

  rysuj_gwiazdy(gwiazdy);

}
