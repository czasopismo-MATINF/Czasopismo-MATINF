import Efekt as e
import Robot as r

class Mapa:

    def __init__(self, lista_wierszy_pol, rozmiar_klatki_mapy):
        self.pola = lista_wierszy_pol
        # na razie program dziala tylko z prostokatnym planem mapy
        self.szerokosc = len(lista_wierszy_pol[0])
        self.wysokosc = len(lista_wierszy_pol)
        self.rozmiar_klatki_mapy = rozmiar_klatki_mapy
        
        self.pola_elementow = dict()

        for j in range(0, self.wysokosc) :
            for i in range(0, self.szerokosc) :
                if self.pola[j][i] != '.' :
                    if self.pola[j][i] in "0123456789" :
                        self.pola_elementow[(i,j)] = e.Efekt(int(self.pola[j][i]), self.rozmiar_klatki_mapy)
                    if self.pola[j][i] == 'r' :
                        self.pola_elementow[(i,j)] = r.Robot(self, self.rozmiar_klatki_mapy)
                        self.x = i
                        self.y = j
                        self.robot = self.pola_elementow[(i,j)]                 

    def rysuj(self, skala):
        
        for i in range(0, self.wysokosc + 1):
            line(0, i * self.rozmiar_klatki_mapy, self.rozmiar_klatki_mapy * self.szerokosc, i * self.rozmiar_klatki_mapy)
            
        for i in range(0, self.szerokosc + 1):
            line(i * self.rozmiar_klatki_mapy, 0, i * self.rozmiar_klatki_mapy, self.rozmiar_klatki_mapy * self.wysokosc)
            
        for x in self.pola_elementow.items() :
            if x != None :
                x[1].rysuj( x[0][0] * self.rozmiar_klatki_mapy, x[0][1] * self.rozmiar_klatki_mapy, skala)

    def czyZajete(self, x, y) :
        return self.pola_elementow.get((x,y)) != None

    def przesunRobota(self, xp, yp, xk, yk) :
        self.pola_elementow[(xk,yk)] = self.pola_elementow[(xp,yp)]
        self.x = xk
        self.y = yk
        del self.pola_elementow[(xp,yp)]

    def krokNaPolnoc(self) :
        if self.y == 0 or self.czyZajete(self.x, self.y-1) :
            return False
        self.przesunRobota(self.x,self.y,self.x,self.y-1)
        return True

    def krokNaWschod(self) :
        if self.x+1 == self.szerokosc or self.czyZajete(self.x+1, self.y) :
            return False
        self.przesunRobota(self.x,self.y,self.x+1,self.y)
        return True

    def krokNaPoludnie(self) :
        if self.y+1 == self.wysokosc or self.czyZajete(self.x, self.y+1) :
            return False
        self.przesunRobota(self.x,self.y,self.x,self.y+1)
        return True
    
    def krokNaZachod(self) :
        if self.x == 0 or self.czyZajete(self.x-1, self.y) :
            return False
        self.przesunRobota(self.x,self.y,self.x-1,self.y)
        return True

    def naPolnocyWolne(self) :
        return self.czyZajete(self.x, self.y-1)
    def naWschodzieWolne(self) :
        return self.czyZajete(self.x+1, self.y)
    def naPoludniuWolne(self) :
        return self.czyZajete(self.x, self.y+1)
    def naZachodzieWolne(self) :
        return self.czyZajete(self.x-1, self.y)
