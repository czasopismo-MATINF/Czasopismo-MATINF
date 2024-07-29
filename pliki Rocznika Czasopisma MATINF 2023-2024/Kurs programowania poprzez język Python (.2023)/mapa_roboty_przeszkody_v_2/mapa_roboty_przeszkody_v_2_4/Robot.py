class Robot:

    def __init__(self, mapa, rozmiar):
        
        self.mapa = mapa
        self.rozmiar = rozmiar
        
        # kolejka rozkazow robota
        self.rozkazy = []
        
    # roboty rysuja sie w punkcie (0,0), przesuniecie do pola mapy jest wykonywane podczas rysowania mapy przy pomocy metody translate
    def rysuj(self, skala):
        circle(0, 0, self.rozmiar*skala/2)

    # robot sprawdza swoje otoczenie na mapie
    def na_polnocy_wolne(self):
        return self.mapa.naPolnocyWolne(self)
    def na_wschodzie_wolne(self):
        return self.mapa.naWschodzieWolne(self)
    def na_poludnie_wolne(self):
        return self.mapa.naPoludniuWolne(self)
    def na_zachodzie_wolne(self):
        return self.mapa.naZachodzieWolne(self)

    # robot porusza sie po mapie
    def krok_w_kierunku(self, kierunek):
        self.rozkazy.append(kierunek)
