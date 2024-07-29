class Efekt:
    
    def __init__(self, typ, rozmiar):
        self.typ = typ
        self.rozmiar = rozmiar
    
    def rysuj(self, x, y, skala):
        # efekty 0 do 4 usunac lub zmienic na bardziej efektowne
        if self.typ == 0:
            circle(x, y, self.rozmiar*skala)
        elif self.typ == 1:
            line(x - self.rozmiar*skala/2, y + self.rozmiar*skala/2, x + self.rozmiar*skala/2, y - self.rozmiar*skala/2)
        elif self.typ == 2:
            line(x - self.rozmiar*skala/2, y - self.rozmiar*skala/2, x + self.rozmiar*skala/2, y + self.rozmiar*skala/2)
        elif self.typ == 3:
            triangle(x - self.rozmiar*skala/2, y - self.rozmiar*skala/2, x + self.rozmiar*skala/2, y + self.rozmiar*skala/2, x, y + self.rozmiar*skala/2)
        elif self.typ == 4:
            rect(x - self.rozmiar*skala/2, y - self.rozmiar*skala/2, self.rozmiar*skala, self.rozmiar*skala)
        elif self.typ == 5:
            for i in range(1, 10):
                circle( x + self.rozmiar*skala*random(-1, 1), y + self.rozmiar*skala*random(-1, 1), self.rozmiar*skala*random(-1, 1) )
        elif self.typ == 6:
            for i in range(1, 10):
                fill(random(0, 255), random(0, 255), random(0, 255))
                rect( x + self.rozmiar*skala*random(-1, 0), y + self.rozmiar*skala*random(-1, 0), self.rozmiar*skala*random(0, 1), self.rozmiar*skala*random(0, 1) )
                fill(255, 255, 255)
        elif self.typ == 7:
            for i in range(1, 10):
                line( x + self.rozmiar*skala*random(-1, 1), y + self.rozmiar*skala*random(-1, 1), x + self.rozmiar*skala*random(-1, 1), y + self.rozmiar*skala*random(-1, 1) )
