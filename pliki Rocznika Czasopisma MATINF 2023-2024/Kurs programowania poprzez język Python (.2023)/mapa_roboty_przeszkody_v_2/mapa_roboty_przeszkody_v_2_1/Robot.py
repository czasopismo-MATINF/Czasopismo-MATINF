class Robot:

    def __init__(self, mapa, rozmiar):
        
        self.mapa = mapa
        self.rozmiar = rozmiar
        
        # kolejka rozkazow robota
        self.rozkazy = []
        
    def rysuj(self, x, y, skala):
        translate(x, y)
        circle(0, 0, self.rozmiar*skala/2)
        translate(-x, -y)

    def na_polnocy_wolne(self):
        return self.mapa.naPolnocyWolne(self)
    def na_wschodzie_wolne(self):
        return self.mapa.naWschodzieWolne(self)
    def na_poludnie_wolne(self):
        return self.mapa.naPoludniuWolne(self)
    def na_zachodzie_wolne(self):
        return self.mapa.naZachodzieWolne(self)

    def krok_w_kierunku(self, kierunek):
        self.rozkazy.append(kierunek)
