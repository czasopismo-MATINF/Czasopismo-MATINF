let width = 500;
let height = 500;

let uklad = {
  
  uklad : this,

  skala : 20.0,
  
  poczatekx : width/2,
  poczateky : height/2,
  
  poczatekfx : 0.0,
  poczatekfy : 0.0,
  
  przelicznaf : function(coords) {
    return {
      x : (coords.x - uklad.poczatekx)/uklad.skala,
      y : (coords.y - uklad.poczateky)/uklad.skala
    };
  },
  
  przeliczzf : function(coordsf) {
    return {
       x : uklad.poczatekx + uklad.skala * coordsf.x,
       y : uklad.poczateky - uklad.skala * coordsf.y
    };
  },
  
  liniax : function() {
    line(0,this.poczateky,width,this.poczateky);
  },
  
  liniay : function() {
    line(this.poczatekx,0,this.poczatekx,height);
  },
  
  rysuj : function(unit) {
     this.liniax();
     this.liniay();

     let x = 0.0;
     while(true) {
        let z1 = this.przeliczzf({x:x,y:0});
        if(z1.x > width) {
          break; 
        }
        translate(z1.x,z1.y);
        rotate(0.6);
        text(x,0,0);
        resetMatrix();
        
        x += unit;
     }

     x = 0.0;
     while(true) {
        let z1 = this.przeliczzf({x:x,y:0});
        if(z1.x < 0) {
          break; 
        }
        translate(z1.x,z1.y);
        rotate(0.6);
        text(x,0,0);
        resetMatrix();
        
        x -= unit;
     }
     
     let y = 0.0;
     while(true) {
        let z1 = this.przeliczzf({x:0,y:y});
        if(z1.y < 0) {
          break; 
        }
        translate(z1.x,z1.y);
        rotate(0.6);
        text(y,0,0);
        resetMatrix();
        
        y += unit;
     }
     
     y = 0.0;
     while(true) {
        let z1 = this.przeliczzf({x:0,y:y});
        if(z1.y > height) {
          break; 
        }
        translate(z1.x,z1.y);
        rotate(0.6);
        text(y,0,0);
        resetMatrix();
        
        y -= unit;
     }
     
  },
  
};

function keyPressed() {
  if(key == 'q') {
    uklad.skala += 1.0;
  }
  if(key == 'e') {
    uklad.skala -= 1.0;
  }
  if(key == 'w') {
    uklad.poczateky -= 10;
  }
  if(key == 's') {
    uklad.poczateky += 10;
  }
  if(key == 'a') {
    uklad.poczatekx -= 10;
  }
  if(key == 'd') {
    uklad.poczatekx += 10;
  }
  
}

function setup() {
  createCanvas(windowWidth, windowHeight);
}

function draw() {
  background(100,150,100);
  uklad.rysuj(1.0);
}
