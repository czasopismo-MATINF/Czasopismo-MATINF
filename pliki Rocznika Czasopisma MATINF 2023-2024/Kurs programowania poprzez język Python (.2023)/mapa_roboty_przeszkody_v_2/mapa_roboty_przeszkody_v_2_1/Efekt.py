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
        
        # proponowany efekt zderzenia
        elif self.typ == 4:
            translate(x, y)
            fill(120, 120, 120)
            for yl in range(1, 10) :
                for i in range(1, 10):
                    (xt, yt) = (random(-1, 1) * self.rozmiar * skala / 2 * yl / 10, - yl * self.rozmiar * skala / 10)
                    translate(xt, yt)
                    circle(0, 0, self.rozmiar * skala * random(-1, 1) * yl / 20 )
                    translate(-xt, -yt)
            translate(-x, -y)
            fill(255, 255, 255)
        
        elif self.typ == 5:
            translate(x, y)
            for i in range(1, 10):
                (xt, yt) = (random(-1, 1) * self.rozmiar * skala / 2, random(-1, 1) * self.rozmiar * skala / 2)
                translate(xt, yt)
                circle(0, 0, self.rozmiar * skala * random(-1, 1) )
                translate(-xt, -yt)
            translate(-x, -y)
        
        elif self.typ == 6:
            translate(x, y)
            for i in range(1, 10):
                (xt, yt) = (random(-1, 0) * self.rozmiar * skala, random(-1, 0) * self.rozmiar * skala)
                translate(xt, yt)
                fill(random(0, 255), random(0, 255), random(0, 255))
                rect(0, 0, self.rozmiar * skala * random(0, 1), self.rozmiar * skala * random(0, 1))
                fill(255, 255, 255)
                translate(-xt, -yt)
            translate(-x, -y)
        
        # proponowany efekt ladowania
        elif self.typ == 7:
            translate(x, y)
            for i in range(1, 10):
                line( self.rozmiar*skala*random(-1, 1), self.rozmiar*skala*random(-1, 1), self.rozmiar*skala*random(-1, 1), self.rozmiar*skala*random(-1, 1) )
            translate(-x, -y)
