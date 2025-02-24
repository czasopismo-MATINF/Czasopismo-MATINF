/*
kod zlozony ze strony:
https://p5js.org/reference/
*/

let shape;
 
function setup() {
  createCanvas(500, 500, WEBGL);
  shape = loadModel("/path to obj file");
}

function draw() {

  background(100);
  
  orbitControl(10,10,10);
  
  ambientLight(200);
  pointLight(255, 255, 255, 50, 50, 200);
  pointLight(255, 255, 255, 50, 50, -200);
  
  scale(20);
  model(shape);

}
