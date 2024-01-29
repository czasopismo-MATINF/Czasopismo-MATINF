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

        for j in range(0, self.wysokosc) :
            for i in range(0, self.szerokosc) :
                if self.pola[j][i] != '.' :
                    if self.pola[j][i] in "0123456789" :
                        self.pola_elementow[(i,j)] = e.Efekt(int(self.pola[j][i]), self.rozmiar_klatki_mapy)
                    if self.pola[j][i] == 'r' :
                        nowy_robot = r.Robot(self, self.rozmiar_klatki_mapy)
                        self.roboty.append(nowy_robot)
                        self.pola_elementow[(i,j)] = nowy_robot               

    # pomocnicza lista robotow jest udostepniana uzytkownikowi do operowania stadem
    def roboty_na_mapie(self):
        return self.roboty

    def rysuj(self, skala):
        
        for i in range(0, self.wysokosc + 1):
            line(0, i * self.rozmiar_klatki_mapy, self.rozmiar_klatki_mapy * self.szerokosc, i * self.rozmiar_klatki_mapy)
            
        for i in range(0, self.szerokosc + 1):
            line(i * self.rozmiar_klatki_mapy, 0, i * self.rozmiar_klatki_mapy, self.rozmiar_klatki_mapy * self.wysokosc)
            
        for x in self.pola_elementow.items() :
            if x != None :
                x[1].rysuj( x[0][0] * self.rozmiar_klatki_mapy, x[0][1] * self.rozmiar_klatki_mapy, skala)

    # wykonanie po jednym rozkazie z kolejek rozkazow robotow
    def dzialaj(self):
        # odczytanie pojedynczego rozkazu kazdego robota na mapie
        for robot in self.roboty :
            if len(robot.rozkazy) >= 1 :
                rozkaz = robot.rozkazy.pop()
                self.wykonajRozkaz(robot, rozkaz)
    
    def wykonajRozkaz(self, robot, rozkaz) :
        (i,j) = self.gdzieJestRobot(robot)
        if rozkaz == 0 :
            self.krokNaPolnoc(i,j)
        elif rozkaz == 1 :
            self.krokNaWschod(i,j)
        elif rozkaz == 2 :
            self.krokNaPoludnie(i,j)
        elif rozkaz == 3 :
            self.krokNaZachod(i,j)

    def czyZajete(self, x, y) :
        return self.pola_elementow.get((x,y)) != None


    def przesunRobota(self, xp, yp, xk, yk) :
        self.pola_elementow[(xk,yk)] = self.pola_elementow[(xp,yp)]
        self.x = xk
        self.y = yk
        del self.pola_elementow[(xp,yp)]

    def krokNaPolnoc(self, i, j) :
        if j == 0 or self.czyZajete(i, j-1) :
            return False
        self.przesunRobota(i,j,i,j-1)
        return True

    def krokNaWschod(self, i, j) :
        if i+1 == self.szerokosc or self.czyZajete(i+1, j) :
            return False
        self.przesunRobota(i,j,i+1,j)
        return True

    def krokNaPoludnie(self, i, j) :
        if j+1 == self.wysokosc or self.czyZajete(i, j+1) :
            return False
        self.przesunRobota(i,j,i,j+1)
        return True
    
    def krokNaZachod(self, i, j) :
        if i == 0 or self.czyZajete(i-1, j) :
            return False
        self.przesunRobota(i,j,i-1,j)
        return True
    
    
    def gdzieJestRobot(self, robot):
        for j in range(0, self.wysokosc) :
            for i in range(0, self.szerokosc) :
                if self.pola_elementow.get((i,j)) == robot :
                    return (i,j)
        return None
        
    def naPolnocyWolne(self, robot) :
        (i,j) = self.gdzieJestRobot(robot)
        return self.czyZajete(i, j-1)
    def naWschodzieWolne(self, robot) :
        (i,j) = self.gdzieJestRobot(robot)
        return self.czyZajete(i+1, j)
    def naPoludniuWolne(self, robot) :
        (i,j) = self.gdzieJestRobot(robot)
        return self.czyZajete(i, j+1)
    def naZachodzieWolne(self, robot) :
        (i,j) = self.gdzieJestRobot(robot)
        return self.czyZajete(i-1, j)
