import Efekt as e

class Mapa:
    
    def __init__(self, lista_wierszy_pol, rozmiar_klatki_mapy):
        self.pola = lista_wierszy_pol
        # na razie program dziala tylko z prostokatnym planem mapy
        self.szerokosc = len(lista_wierszy_pol[0])
        self.wysokosc = len(lista_wierszy_pol)
        self.rozmiar_klatki_mapy = rozmiar_klatki_mapy

        for j in range(0, len(self.pola)):
            for i in range(0, len(self.pola[j])):
                if self.pola[j][i] != '.':
                    self.pola[j][i] = e.Efekt(int(self.pola[j][i]), self.rozmiar_klatki_mapy)
        
            
    def rysuj(self, skala):
        for i in range(0, self.wysokosc + 1):
            line(0, i * self.rozmiar_klatki_mapy, self.rozmiar_klatki_mapy * self.szerokosc, i * self.rozmiar_klatki_mapy)
        for i in range(0, self.szerokosc + 1):
            line(i * self.rozmiar_klatki_mapy, 0, i * self.rozmiar_klatki_mapy, self.rozmiar_klatki_mapy * self.wysokosc)
        for j in range(0, len(self.pola)):
            for i in range(0, len(self.pola[j])):
                if self.pola[j][i] != '.':
                    self.pola[j][i].rysuj( i * self.rozmiar_klatki_mapy, j * self.rozmiar_klatki_mapy, skala)
