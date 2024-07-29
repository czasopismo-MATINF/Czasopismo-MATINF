class Robot:
    def __init__(self, mapa, rozmiar_klatki_mapy, pole_startowe):
        self.mapa = mapa
        self.x = pole_startowe[0]
        self.y = pole_startowe[1]
        self.rozmiar_klatki_mapy = rozmiar_klatki_mapy
        self.rozmiar = rozmiar_klatki_mapy/2
    def na_zachodzie_wolne(self):
        return True
    def na_wschodzie_wolne(self):
        return True
    def na_polnocy_wolne(self):
        return True
    def na_poludnie_wolne(self):
        return True
    def wyswietl(self):
        circle(self.x * self.rozmiar_klatki_mapy, self.y * self.rozmiar_klatki_mapy, self.rozmiar)
    def krok_w_kierunku(self, kierunek):
        if kierunek == 0:
            self.x = self.x
            self.y = self.y - 1
        elif kierunek == 1:
            self.x = self.x + 1
            self.y
        elif kierunek == 2:
                self.x = self.x
                self.y = self.y + 1
        elif kierunek == 3:
                self.x = self.x - 1
                self.y = self.y
