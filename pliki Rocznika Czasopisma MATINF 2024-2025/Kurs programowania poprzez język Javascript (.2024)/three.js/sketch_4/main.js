import * as THREE from 'three';

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000 );

camera.position.x = 0;
camera.position.y = 0;
camera.position.z = 10;

const renderer = new THREE.WebGLRenderer();
renderer.setSize( window.innerWidth, window.innerHeight );
document.body.appendChild( renderer.domElement );

var directionalLight = new THREE.DirectionalLight( 0xFFFFFF, 0.5 );
directionalLight.position.x = 0;
directionalLight.position.y = 0;
directionalLight.position.z = 10;
scene.add( directionalLight );

/********************/

var gwiazdy = [];
var G = 1000;
var ilosc_gwiazd = 10;

for(var i = 0; i < ilosc_gwiazd; ++i) {
  /* [x, y, z, rozmiar, waga, predkosc x, predkosc y, predkosc z ] gwiazdy */
  var waga_gwiazdy = 10+Math.random()*10;
  var rozmiar_gwiazdy = waga_gwiazdy * 0.01
  gwiazdy.push([-5+Math.random()*10, -5+Math.random()*10, Math.random()*5, rozmiar_gwiazdy, waga_gwiazdy, Math.random()*50, Math.random()*50, Math.random()*50]);
}

for(var i = 0; i < ilosc_gwiazd; ++i) {
  /* [x, y, z, rozmiar, waga, predkosc x, predkosc y, predkosc z, Three.js group ] */

  var group = new THREE.Group();
  group.position.x = gwiazdy[i][0];
  group.position.y = gwiazdy[i][1];
  group.position.z = gwiazdy[i][2];
  gwiazdy[i].push(group);
  var geometry = new THREE.SphereGeometry( gwiazdy[i][3], 32, 32 );
  var material = new THREE.MeshPhongMaterial( { color: 0xFFFF00 } );
  var sphere = new THREE.Mesh( geometry, material );
  group.add(sphere);
  scene.add(group);

}

function przesun_gwiazdy(gwiazdy, krok_czasu) {
 
  var sumy_sil = [];
  
  //naiwne obliczenia sil grawitacji
  for(var i = 0; i < gwiazdy.length; ++i) {
    var suma_sil = [0, 0, 0];
    for(var j = 0; j < gwiazdy.length; ++j) {
      if(i != j) {
        var wektor_przesuniecia = [
                        gwiazdy[j][0]-gwiazdy[i][0],
                        gwiazdy[j][1]-gwiazdy[i][1],
                        gwiazdy[j][2]-gwiazdy[i][2]
        ];
        var dlugosc_wektora_przesuniecia = Math.sqrt(
                    Math.pow(wektor_przesuniecia[0],2)
                    + Math.pow(wektor_przesuniecia[1],2)
                    + Math.pow(wektor_przesuniecia[2],2)
        );
        var kierunek_sily = [
                    wektor_przesuniecia[0] / dlugosc_wektora_przesuniecia,
                    wektor_przesuniecia[1] / dlugosc_wektora_przesuniecia,
                    wektor_przesuniecia[2] / dlugosc_wektora_przesuniecia
        ];
        var kwadrat_odleglosci_gwiazd = Math.pow(gwiazdy[j][0]-gwiazdy[i][0],2)
                                        + Math.pow(gwiazdy[j][1]-gwiazdy[i][1],2)
                                        + Math.pow(gwiazdy[j][2]-gwiazdy[i][2],2);
        var sila = [
                G * kierunek_sily[0] * gwiazdy[i][4] * gwiazdy[j][4] / kwadrat_odleglosci_gwiazd,
                G * kierunek_sily[1] * gwiazdy[i][4] * gwiazdy[j][4] / kwadrat_odleglosci_gwiazd,
                G * kierunek_sily[2] * gwiazdy[i][4] * gwiazdy[j][4] / kwadrat_odleglosci_gwiazd
        ];
        suma_sil = [suma_sil[0] + sila[0], suma_sil[1] + sila[1], suma_sil[2] + sila[2]];
      }
    }
    sumy_sil.push(suma_sil);
  }

  //naiwne obliczanie przesuniec gwiazd
  for(i = 0; i < gwiazdy.length; ++i) {
    gwiazdy[i][5] = gwiazdy[i][5] + sumy_sil[i][0] * krok_czasu;
    gwiazdy[i][6] = gwiazdy[i][6] + sumy_sil[i][1] * krok_czasu;
    gwiazdy[i][7] = gwiazdy[i][7] + sumy_sil[i][2] * krok_czasu;

    gwiazdy[i][0] = gwiazdy[i][0] + gwiazdy[i][5] * krok_czasu;
    gwiazdy[i][1] = gwiazdy[i][1] + gwiazdy[i][6] * krok_czasu;
    gwiazdy[i][2] = gwiazdy[i][2] + gwiazdy[i][7] * krok_czasu;

    gwiazdy[i][8].position.x = gwiazdy[i][0];
    gwiazdy[i][8].position.y = gwiazdy[i][1];
    gwiazdy[i][8].position.z = gwiazdy[i][2];
  }
  
}

/********************/

function animate() {

  przesun_gwiazdy(gwiazdy, 0.00001);

	renderer.render( scene, camera );
	
}

renderer.setAnimationLoop( animate );