import * as THREE from 'three';

/*
kod ze strony:
https://threejs.org/docs/#manual/en/introduction/Loading-3D-models
*/

import { GLTFLoader } from 'three/addons/loaders/GLTFLoader.js';

const scene = new THREE.Scene();

const camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000 );

camera.position.x = 0;
camera.position.y = 0;
camera.position.z = 10;

//grupa do obracania kamery
var cameraGroup = new THREE.Group();
cameraGroup.position.x = 0.0;
cameraGroup.position.y = 0.0;
cameraGroup.position.z = 0.0;

cameraGroup.add(camera);
scene.add(cameraGroup);

const renderer = new THREE.WebGLRenderer();
renderer.setSize( window.innerWidth, window.innerHeight );
document.body.appendChild( renderer.domElement );

var directionalLight = new THREE.DirectionalLight( 0xFFFFFF, 0.5 );
directionalLight.position.x = 0;
directionalLight.position.y = 0;
directionalLight.position.z = 10;
directionalLight.intensity = 1.0;
scene.add( directionalLight );

var ambientLight = new THREE.AmbientLight('white', 1.0);
scene.add(ambientLight);

/********************/

/*
kod ze strony:
https://threejs.org/docs/#manual/en/introduction/Loading-3D-models
*/

const loader = new GLTFLoader();

loader.load( '/path to gltf file', function ( gltf ) {

	scene.add( gltf.scene );

}, undefined, function ( error ) {

	console.error( error );

} );

/********************/

//wsad
document.addEventListener("keydown", function(event) {
	if (event.keyCode == 65) {
		cameraGroup.rotation.y += 0.1;
	} else if (event.keyCode == 68) {
		cameraGroup.rotation.y -= 0.1;
	} else if(event.keyCode == 87) {
		camera.position.z -= 0.1;
	} else if(event.keyCode == 83) {
		camera.position.z += 0.1;
	}}, false
);

/********************/

function animate() {

	renderer.render( scene, camera );

}

renderer.setAnimationLoop( animate );