class Robot:

    def __init__(self, mapa, rozmiar):
        self.mapa = mapa
        self.rozmiar = rozmiar

    def na_polnocy_wolne(self):
        return self.mapa.naPolnocyWolne()
    def na_wschodzie_wolne(self):
        return self.mapa.naWschodzieWolne()
    def na_poludnie_wolne(self):
        return self.mapa.naPoludniuWolne()
    def na_zachodzie_wolne(self):
        return self.mapa.naZachodzieWolne()

    def rysuj(self, x, y, skala):
        circle(x, y, self.rozmiar*skala/2)

    def krok_w_kierunku(self, kierunek):
        if kierunek == 0:
            self.mapa.krokNaPolnoc()
        elif kierunek == 1:
            self.mapa.krokNaWschod()
        elif kierunek == 2:
            self.mapa.krokNaPoludnie()
        elif kierunek == 3:
            self.mapa.krokNaZachod()
