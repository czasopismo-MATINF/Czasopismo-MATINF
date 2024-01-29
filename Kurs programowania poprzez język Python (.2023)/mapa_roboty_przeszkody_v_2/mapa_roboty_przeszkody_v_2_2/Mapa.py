import Efekt as e
import Robot as r

class Mapa:

    def __init__(self, pola, rozmiar_klatki_mapy):
        
        # mapa utworzona przez uzytkownika w formie napisow list
        self.pola = pola
        
        # na razie program dziala tylko z prostokatnym planem mapy
        self.szerokosc = len(pola[0])
        self.wysokosc = len(pola)
        
        self.rozmiar_klatki_mapy = rozmiar_klatki_mapy
        
        # wewnetrzna mapa obiektowa
        self.pola_elementow = dict()
        
        # pomocnicza lista robotow na mapie obiektowej
        self.roboty = []

        # na pojedynczych polach mapy moze byc teraz wiecej obiektow
        for j in range(0, self.wysokosc) :
            for i in range(0, self.szerokosc) :
                # pole jest lista obiektow
                pole = []
                if self.pola[j][i] != '.' :
                    if self.pola[j][i] in "0123456789" :
                        pole.append(e.Efekt(int(self.pola[j][i]), self.rozmiar_klatki_mapy))
                    if self.pola[j][i] == 'r' :
                        nowy_robot = r.Robot(self, self.rozmiar_klatki_mapy)
                        self.roboty.append(nowy_robot)
                        pole.append(nowy_robot)
                self.pola_elementow[(i,j)] = pole
                    

    # pomocnicza lista robotow jest udostepniana uzytkownikowi do operowania stadem
    def roboty_na_mapie(self):
        return self.roboty

    def rysuj(self, skala):
        
        for i in range(0, self.wysokosc + 1):
            line(0, i * self.rozmiar_klatki_mapy, self.rozmiar_klatki_mapy * self.szerokosc, i * self.rozmiar_klatki_mapy)
            
        for i in range(0, self.szerokosc + 1):
            line(i * self.rozmiar_klatki_mapy, 0, i * self.rozmiar_klatki_mapy, self.rozmiar_klatki_mapy * self.wysokosc)
            
        # iterator jest zestawem podwojnej wspolrzedna pola oraz lista obiektow na nim sie znajdujacych ((i,j),[...])
        for ((i,j),obiekty) in self.pola_elementow.items() :
            translate( i * self.rozmiar_klatki_mapy, j * self.rozmiar_klatki_mapy)
            for obiekt in obiekty :
                obiekt.rysuj(skala)
            translate( - i * self.rozmiar_klatki_mapy, - j * self.rozmiar_klatki_mapy)

    # wykonanie po jednym rozkazie z kolejek rozkazow robotow
    def dzialaj(self):
        # odczytanie pojedynczego rozkazu kazdego robota na mapie
        for robot in self.roboty :
            if len(robot.rozkazy) >= 1 :
                rozkaz = robot.rozkazy.pop()
                self.wykonajRozkaz(robot, rozkaz)
            
    
    # na razie, sposrod obiektow na mapie, tylko roboty wykonuja rozkazy
    def wykonajRozkaz(self, robot, rozkaz) :
        (i,j) = self.gdzieJestObiekt(robot)
        if rozkaz == 0 :
            self.krokNaPolnoc(robot, i,j)
        elif rozkaz == 1 :
            self.krokNaWschod(robot, i,j)
        elif rozkaz == 2 :
            self.krokNaPoludnie(robot, i,j)
        elif rozkaz == 3 :
            self.krokNaZachod(robot, i,j)

    def czyNaGranicyMapy(self, i, j) :
        if i == 0 or i+1 == self.szerokosc :
            return True
        if j == 0 or j+1 == self.wysokosc :
            return True
        return False
    
    def czyPozaMapa(self, i, j) :
        if i < 0 or i+1 > self.szerokosc :
            return True
        if j < 0 or j+1 > self.wysokosc :
            return True
        return False
    
    def czyZajete(self, i, j) :
        if self.czyPozaMapa(i, j) :
            return True
        return len(self.pola_elementow.get((i,j))) >= 1
    
    def czyZablokowane(self, i, j) :
        # ta linijka odblokowuje kolizje
        return False
        if self.czyPozaMapa(i, j) :
            return True
        return len(self.pola_elementow.get((i,j))) >= 1
    
    def przesunRobota(self, robot, xp, yp, xk, yk) :
        # przesuniecie robota jest usunieciem go z listy pola (xp,yp) i dodaniem do listy pola (xk, yk)
        self.pola_elementow.get((xp,yp)).remove(robot)
        self.pola_elementow.get((xk,yk)).append(robot)

    def krokNaPolnoc(self, robot, i, j) :
        if j == 0 or self.czyZablokowane(i, j-1) :
            return False
        self.przesunRobota(robot,i,j,i,j-1)
        return True

    def krokNaWschod(self, robot, i, j) :
        if i+1 == self.szerokosc or self.czyZablokowane(i+1, j) :
            return False
        self.przesunRobota(robot,i,j,i+1,j)
        return True

    def krokNaPoludnie(self, robot, i, j) :
        if j+1 == self.wysokosc or self.czyZablokowane(i, j+1) :
            return False
        self.przesunRobota(robot,i,j,i,j+1)
        return True
    
    def krokNaZachod(self, robot, i, j) :
        if i == 0 or self.czyZablokowane(i-1, j) :
            return False
        self.przesunRobota(robot,i,j,i-1,j)
        return True
    
    def gdzieJestObiekt(self, obiekt):
        for ((i,j),obiekty) in self.pola_elementow.items() :
            if obiekt in obiekty :
                return (i,j)
        return None
        
    def naPolnocyWolne(self, robot) :
        (i,j) = self.gdzieJestObiekt(robot)
        return self.czyZajete(i, j-1)
    def naWschodzieWolne(self, robot) :
        (i,j) = self.gdzieJestObiekt(robot)
        return self.czyZajete(i+1, j)
    def naPoludniuWolne(self, robot) :
        (i,j) = self.gdzieJestObiekt(robot)
        return self.czyZajete(i, j+1)
    def naZachodzieWolne(self, robot) :
        (i,j) = self.gdzieJestObiekt(robot)
        return self.czyZajete(i-1, j)
