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

function Wektor(x, y, z) {
	this.x = x;
	this.y = y;
	this.z = z;
	this.dlugosc = function() {
		return Math.sqrt(Math.pow(this.x, 2) + Math.pow(this.y, 2) + Math.pow(this.z, 2));
	};
	this.kierunek = function() {
		return new Wektor(this.x/this.dlugosc(), this.y/this.dlugosc(), this.z/this.dlugosc());
	};
	this.razy = function(liczba) {
		this.x = liczba * this.x;
		this.y = liczba * this.y;
		this.z = liczba * this.z;
		return this;
	}
	this.dodaj = function(wektor) {
		this.x += wektor.x;
		this.y += wektor.y;
		this.z += wektor.z;
		return this;
	}
}

var gwiazdy = [];
var G = 1000;
var ilosc_gwiazd = 10;

for(var i = 0; i < ilosc_gwiazd; ++i) {

	/* [x, y, z, rozmiar, waga, predkosc x, predkosc y, predkosc z, Three.js group ] */

	var waga_gwiazdy = 10+Math.random()*10;
	var rozmiar_gwiazdy = waga_gwiazdy * 0.01

	gwiazdy.push({
		"x" : -5+Math.random()*10,
		"y" : -5+Math.random()*10,
		"z" : Math.random()*5,
		"promien" : rozmiar_gwiazdy,
		"masa" : waga_gwiazdy,
		"vx" : Math.random()*50,
		"vy" : Math.random()*50,
		"vz" : Math.random()*50,
		"krok" : function(suma_sil, krok_czasu) {
			this.vx = this.vx + suma_sil.x * krok_czasu;
			this.vy = this.vy + suma_sil.y * krok_czasu;
			this.vz = this.vz + suma_sil.z * krok_czasu;
			this.x = this.x + this.vx * krok_czasu;
			this.y = this.y + this.vy * krok_czasu;
			this.z = this.z + this.vz * krok_czasu;
		},
		"threejs_group" : null
	});
}

for(var i = 0; i < ilosc_gwiazd; ++i) {

	var group = new THREE.Group();
	group.position.x = gwiazdy[i].x;
	group.position.y = gwiazdy[i].y;
	group.position.z = gwiazdy[i].z;
	gwiazdy[i].threejs_group = group;
	var geometry = new THREE.SphereGeometry( gwiazdy[i].promien, 32, 32 );
	var material = new THREE.MeshPhongMaterial( { color: 0xFFFF00 } );
	var sphere = new THREE.Mesh( geometry, material );
	group.add(sphere);
	scene.add(group);

}

function przesun_gwiazdy(gwiazdy, krok_czasu) {
 
	var sumy_sil = [];

	//naiwne obliczenia sil grawitacji
	for(var i = 0; i < gwiazdy.length; ++i) {

	var suma_sil = new Wektor(0,0,0);

		for(var j = 0; j < gwiazdy.length; ++j) {
			if(i != j) {
				var przesuniecie = new Wektor(
					gwiazdy[j].x-gwiazdy[i].x,
					gwiazdy[j].y-gwiazdy[i].y,
					gwiazdy[j].z-gwiazdy[i].z
				);
				var kierunek_sily = przesuniecie.kierunek();
				var kwadrat_odleglosci_gwiazd = Math.pow(gwiazdy[j].x-gwiazdy[i].x, 2) + Math.pow(gwiazdy[j].y-gwiazdy[i].y, 2) + Math.pow(gwiazdy[j].z-gwiazdy[i].z, 2);
				var sila = kierunek_sily.razy(G*(gwiazdy[i].masa)*(gwiazdy[j].masa)/kwadrat_odleglosci_gwiazd);
				suma_sil = suma_sil.dodaj(sila);
			}
		}

		sumy_sil.push(suma_sil);

	}

	//naiwne obliczanie przesuniec gwiazd
	for(i = 0; i < gwiazdy.length; ++i) {

		gwiazdy[i].krok(sumy_sil[i], krok_czasu);

		gwiazdy[i].threejs_group.position.x = gwiazdy[i].x;
		gwiazdy[i].threejs_group.position.y = gwiazdy[i].y;
		gwiazdy[i].threejs_group.position.z = gwiazdy[i].z;

	}
  
}

/********************/

function animate() {

	przesun_gwiazdy(gwiazdy, 0.00001);

	renderer.render( scene, camera );

}

renderer.setAnimationLoop( animate );