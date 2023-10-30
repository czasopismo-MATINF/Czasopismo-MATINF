class Mapa:
    def __init__(self, lista_pol, rozmiar_klatki_mapy):
        self.pola = lista_pol
        self.szerokosc = len(lista_pol[0])
        self.wysokosc = len(lista_pol)
        self.rozmiar_klatki_mapy = rozmiar_klatki_mapy
    def wyswietl(self):
        for i in range(0, self.wysokosc + 1):
            line(0, i * self.rozmiar_klatki_mapy, self.rozmiar_klatki_mapy * self.szerokosc, i * self.rozmiar_klatki_mapy)
        for i in range(0, self.szerokosc + 1):
            line(i * self.rozmiar_klatki_mapy, 0, i * self.rozmiar_klatki_mapy, self.rozmiar_klatki_mapy * self.wysokosc)
