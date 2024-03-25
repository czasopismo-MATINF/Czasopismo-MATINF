# klasa efektow umieszczanych na mapie
class Efekt:
    
    def __init__(self, typ, rozmiar):
        self.typ = typ
        self.rozmiar = rozmiar
        
    def resetStroke(self) :
        stroke(0,0,0);
        
    def resetFill(self) :
        fill(255,255,255)
    
    # efekty rysuja sie w punkcie (0,0), przesuniecie do pola mapy jest wykonywane podczas rysowania mapy przy pomocy metody translate
    def rysuj(self, skala):
        
        # proponowany efekt zderzenia, dymu
        if self.typ == 4:
            fill(120, 120, 120)
            for yl in range(1, 10) :
                for i in range(1, 10):
                    (xt, yt) = (random(-1, 1) * self.rozmiar * skala / 2 * yl / 10, - yl * self.rozmiar * skala / 10)
                    translate(xt, yt)
                    circle(0, 0, self.rozmiar * skala * random(-1, 1) * yl / 20 )
                    translate(-xt, -yt)
        
        # proponowany efekt niszczacej pulapki
        elif self.typ == 5:
            for i in range(1, 10):
                (xt, yt) = (random(-1, 1) * self.rozmiar * skala / 2, random(-1, 1) * self.rozmiar * skala / 2)
                translate(xt, yt)
                circle(0, 0, self.rozmiar * skala * random(-1, 1) )
                translate(-xt, -yt)
        
        # proponowany efekt teleportacji
        elif self.typ == 6:
            for i in range(1, 10):
                (xt, yt) = (random(-1, 0) * self.rozmiar * skala, random(-1, 0) * self.rozmiar * skala)
                translate(xt, yt)
                fill(random(0, 255), random(0, 255), random(0, 255))
                rect(0, 0, self.rozmiar * skala * random(0, 1), self.rozmiar * skala * random(0, 1))
                translate(-xt, -yt)
        
        # proponowany efekt ladowania
        elif self.typ == 7:
            for i in range(1, 10):
                line( self.rozmiar*skala*random(-1, 1), self.rozmiar*skala*random(-1, 1), self.rozmiar*skala*random(-1, 1), self.rozmiar*skala*random(-1, 1) )

        self.resetFill()
