# klasa robotow przyjmujacych rozkazy od uzytkownika
class Robot:
    
    def resetStroke(self) :
        stroke(0,0,0);
        
    def resetFill(self) :
        fill(255,255,255)

    def __init__(self, mapa, rozmiar):
        
        self.typ = 'r'
        
        self.mapa = mapa
        self.rozmiar = rozmiar
        
        # kolor robota nadawany przez uzytkownika po jego utworzeniu
        self.r = 255
        self.g = 255
        self.b = 255
        
        # kolejka rozkazow robota
        self.rozkazy = []
        
    def set_color(self, r, g, b) :
        self.r = r
        self.g = g
        self.b = b
        
    # roboty rysuja sie w punkcie (0,0), przesuniecie do pola mapy jest wykonywane podczas rysowania mapy przy pomocy metody translate
    def rysuj(self, skala):
        stroke(self.r, self.g, self.b)
        fill(self.r, self.g, self.b)
        circle(0, 0, self.rozmiar*skala/2)
        self.resetStroke()
        self.resetFill()

    # robot sprawdza swoje otoczenie na mapie
    def na_polnocy_wolne(self):
        return self.mapa.naPolnocyWolne(self)
    def na_wschodzie_wolne(self):
        return self.mapa.naWschodzieWolne(self)
    def na_poludnie_wolne(self):
        return self.mapa.naPoludniuWolne(self)
    def na_zachodzie_wolne(self):
        return self.mapa.naZachodzieWolne(self)

    def obiekty_w_sasiedztwie(self, kierunek) :
        return self.mapa.obiekty_w_sasiedztwie(self, kierunek)

    # robot porusza sie po mapie
    def krok_w_kierunku(self, kierunek):
        self.rozkazy.append(kierunek)
