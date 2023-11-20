
class Kolo:
    def __init__(self, typ, rozmiar):
        self.typ = typ
        self.rozmiar = rozmiar
    def rysuj(self,x, y, skala):
        circle(x, y, self.rozmiar*skala)

class Kwadrat:
    def __init__(self, typ, rozmiar):
        self.typ = typ
        self.rozmiar = rozmiar
    def rysuj(self, x, y, skala):
        rect(x, y, self.rozmiar*skala, self.rozmiar*skala)
        
do_rysowania = set()

class Efekt:
    def __init__(self, typ, rozmiar):
        self.typ = typ
        self.rozmiar = rozmiar
    def rysuj(self, x, y, skala):
        if self.typ == 0:
            circle(x, y, self.rozmiar*skala)
        elif self.typ == 1:
            line(x, y, x + self.rozmiar*skala, y)
        elif self.typ == 2:
            line(x, y, x, y + self.rozmiar*skala)
        elif self.typ == 3:
            triangle(x, y, x + self.rozmiar*skala, y + self.rozmiar*skala, x, y + self.rozmiar*skala)
        elif self.typ == 4:
            rect(x, y, self.rozmiar*skala, self.rozmiar*skala)
        elif self.typ == 5:
            for i in range(1, 10):
                circle( x + self.rozmiar*skala*random(0, 1), y + self.rozmiar*skala*random(0, 1), self.rozmiar*skala*random(0, 1) )
        elif self.typ == 6:
            for i in range(1, 10):
                fill(200,100,50)
                rect( x + self.rozmiar*skala*random(0, 1), y + self.rozmiar*skala*random(0, 1), self.rozmiar*skala, self.rozmiar*skala )
                fill(*kolor_wypelnienia)
        elif self.typ == 7:
            for i in range(1, 10):
                line( x + self.rozmiar*skala*random(0, 1), y + self.rozmiar*skala*random(0, 1), x + self.rozmiar*skala*random(0, 1), y + self.rozmiar*skala*random(0, 1) )         

def setup():
    
    size(800,600)
    
    do_rysowania.add( (Kwadrat(1, 40), 200, 100) )
    do_rysowania.add( (Kolo(1, 40), 100, 200) )
 
#    dlaczego rysuje różne rozmiary?
#    for i in range(1,10):
#        for j in range(1, 10):
#            do_rysowania.add( (Kwadrat(1, 40), i*40, j*40) )

    for i in range(1,10):
        for j in range(1, 10):
            if (i+j) % 2 == 0 :
                do_rysowania.add( (Kwadrat(1, 40), i*40, j*40) )
            else:
                do_rysowania.add( (Kolo(1, 40), i*40, j*40) )

#    for i in range(1,10):
#        for j in range(1, 10):
#                do_rysowania.add( (Efekt( (i+j) % 5, 40), i*40, j*40) )

#    for i in range(1,10):
#        for j in range(1, 10):
#                do_rysowania.add( (Efekt( 5 + ((i+j) % 3), 40), i*40, j*40) )

kolor_wypelnienia = (100,200,75)

def draw():
    background(255,255,0)
    fill(*kolor_wypelnienia)
    for r in do_rysowania:
        r[0].rysuj(r[1], r[2], sin(millis()))

    delay(200)
    
