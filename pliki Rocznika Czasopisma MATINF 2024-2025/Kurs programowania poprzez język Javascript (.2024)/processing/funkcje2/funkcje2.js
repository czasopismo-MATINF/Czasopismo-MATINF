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
  
  minx : function() {
    return this.przelicznaf({x:0,y:0}).x; 
  },
  
  maxx : function() {
     return this.przelicznaf({x:width,y:0}).x; 
  },
  
  miny : function() {
     return this.przelicznaf({x:0,y:0}).y; 
  },
  
  maxy : function() {
      return this.przelicznaf({x:0,y:height}).y;
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

let funkcje = {
  
    step : 0.1,
  
    funkcje : [
      x => x*x,
      x => 2*x*x*x - 3*x +4,
      x => Math.pow(2, x) + 1,
      x => Math.abs(x - 2) + 3
    ],
    
    rysuj : function() {
      this.funkcje.forEach(f => {
        
        let minx = uklad.minx();
        let maxx = uklad.maxx();
        
        let x = minx;
        while(x < maxx) {
          let point = uklad.przeliczzf({x:x, y:f(x)});
          circle(point.x, point.y, 3);
          x += this.step;
        }
        
      });
    }
  
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
  funkcje.rysuj();
}
