function sasiedzi_w_kracie(i, j, n, m) {
 
  if(i > 0 && i < n - 1 && j > 0 && j < m - 1) {
     return [[i-1,j],[i+1,j],[i,j-1],[i,j+1]]; 
  }
  
  if(i == 0 && j > 0 && j < m - 1) {
     return [[i,j-1],[i,j+1],[i+1,j]];
  }
  
  if(j == 0 && i > 0 && i < n - 1) {
     return [[i-1,j],[i+1,j],[i,j+1]];
  }
  
  if(i == n - 1 && j > 0 && j < m - 1) {
     return [[i,j-1],[i,j+1],[i-1,j]];
  }
  
  if(j == m - 1 && i > 0 && i < m - 1) {
     return [[i-1,j],[i+1,j],[i,j-1]];
  }
  
  if(i == 0) {
     if(j == 0) {
        return [[1,0],[0,1]]; 
     }
     if(j == m - 1) {
       return [[0,m-2],[1,m-1]];
     }
  }
  
  if(i == n - 1) {
     if(j == 0) {
       return [[n-1,1],[n-2,0]];
     }
     if(j == m - 1) {
       return [[n-1,m-2],[n-2,m-1]];
     }
  }
  
}

function rysuj_labirynt(pamiec, n, m, size) {
  
  var shift_x = size;
  var shift_y = size;
  
  line(shift_x,shift_y,shift_x+n*size,shift_y);
  line(shift_x,shift_y+m*size,shift_x+n*size,shift_y+m*size);
  line(shift_x,shift_y,shift_x,shift_y+m*size);
  line(shift_x+n*size,shift_y,shift_x+n*size,shift_y+m*size);
  
  function czy_jest_przejscie(przejscia, sasiad) {
    for(var i = 0; i < przejscia.length; ++i) {
       if(przejscia[i][0] == sasiad[0] && przejscia[i][1] == sasiad[1]) {
         return true;
        }
    }
    return false;
  }
  
  function rysuj_sciane(s1,s2,t1,t2,size) {

    if(s1 == t1) {
      var l = s2;
      if(s2 > t2) {
        l = t2;
      }
      line(shift_x+s1*size,shift_y+(l+1)*size,shift_x+(s1+1)*size,shift_y+(l+1)*size);
    } else {
      if(s2 == t2) {
        var k = s1;
        if(s1 > t1) {
          k = t1; 
        }
        line(shift_x+(k+1)*size,shift_y+s2*size,shift_x+(k+1)*size,shift_y+(s2+1)*size);
       }
    }
  }
  
  for(var i = 0; i < n; ++i) {
     for(var j = 0; j < m; ++j) {
      
       var sasiedzi = sasiedzi_w_kracie(i,j,n,m);
       for(var s = 0; s < sasiedzi.length; ++s) {
        
         if(czy_jest_przejscie(pamiec[i][j].przejscia, sasiedzi[s]) == false) {
           
           //rysuj sciane pomiedzy komnata [i][j] a jej sasiadem sasiedzi[s]
           rysuj_sciane(i,j,sasiedzi[s][0],sasiedzi[s][1],size);
           
         }
         
       }
       
     }
  }
  
}

/* kod ze strony https://stackoverflow.com/questions/2450954/how-to-randomize-shuffle-a-javascript-array */
/* Randomize array in-place using Durstenfeld shuffle algorithm */
function shuffleArray(array) {
    for (var i = array.length - 1; i > 0; i--) {
        var j = Math.floor(Math.random() * (i + 1));
        var temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
}

function generuj_labirynt(n, m) {
  
  //uruchamia algorytm BFS na kracie komnat
  //uruchamiac z n >= 2, m >= 2
  
  var pamiec = [];
  for(var i = 0; i < n; ++i) {
    pamiec[i] = [];
    for(var j = 0; j < m; ++j) {
       pamiec[i][j] = {
         "odwiedzone" : false,
         "przejscia" : []
         
       };
    }
  }
  
  var stos = [[0,0]];
  pamiec[0][0].odwiedzone = true;
  pamiec[0][0].przejscia = [];

  while(true) {
    
    shuffleArray(stos);
    ze_stosu = stos.pop();
    sasiedzi = sasiedzi_w_kracie(ze_stosu[0],ze_stosu[1],m,n);
    for(var i = 0; i < sasiedzi.length; ++i) {
       if(pamiec[sasiedzi[i][0]][sasiedzi[i][1]].odwiedzone == false) {
          pamiec[sasiedzi[i][0]][sasiedzi[i][1]].odwiedzone = true;
          stos.push(sasiedzi[i]);
          pamiec[sasiedzi[i][0]][sasiedzi[i][1]].przejscia.push(ze_stosu);
          pamiec[ze_stosu[0]][ze_stosu[1]].przejscia.push(sasiedzi[i]);
       }
    }

    if(stos.length == 0) {
      console.log(pamiec);
      return pamiec;
    }
    
  }
  
}

var n_lab_dlugosc = 20;
var m_lab_wysokosc = 20;
var rozmiar_komnaty = 20;

function setup() {
  createCanvas(windowWidth, windowHeight);
  background(100,150,100);
  pamiec = generuj_labirynt(n_lab_dlugosc,m_lab_wysokosc);
  rysuj_labirynt(pamiec, n_lab_dlugosc, m_lab_wysokosc, rozmiar_komnaty);
}


function draw() {

}
