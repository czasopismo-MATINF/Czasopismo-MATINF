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
        
        # glownym skladnikiem mapy jest pole elementow
        # wewnetrzna mapa obiektowa
        self.pola_elementow = dict()
        
        # pomocnicza lista robotow na mapie obiektowej, udostepniona uzytkownikowi
        # zawiera rowniez roboty usuniete z mapy n.p. po zderzeniach
        self.roboty = []

        # w konstruktorze mapy przygotowujemy struktury danych ulatwiajace jej zadania
        # na pojedynczych polach mapy moze byc teraz wiecej obiektow
        for j in range(0, self.wysokosc) :
            for i in range(0, self.szerokosc) :
                # pole jest lista elementow
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
        
        # rysowanie siatki mapy
        for i in range(0, self.wysokosc + 1):
            line(0, i * self.rozmiar_klatki_mapy, self.rozmiar_klatki_mapy * self.szerokosc, i * self.rozmiar_klatki_mapy)
            
        for i in range(0, self.szerokosc + 1):
            line(i * self.rozmiar_klatki_mapy, 0, i * self.rozmiar_klatki_mapy, self.rozmiar_klatki_mapy * self.wysokosc)
        
        # rysowanie elementow
        # iterator jest zestawem podwojnej wspolrzedna pola oraz lista obiektow na nim sie znajdujacych ((i,j),[...])
        for ((i,j),obiekty) in self.pola_elementow.items() :
            translate( i * self.rozmiar_klatki_mapy, j * self.rozmiar_klatki_mapy)
            for obiekt in obiekty :
                obiekt.rysuj(skala)
            translate( - i * self.rozmiar_klatki_mapy, - j * self.rozmiar_klatki_mapy)

    # **********************************************
    # PROCEDURY MECHANIKI NA MAPIE
    
    # wykonanie po jednym rozkazie z kolejek rozkazow robotow
    def dzialaj(self):
        # odczytanie i wykonanie pojedynczego rozkazu kazdego robota na mapie
        robot_na_mapie = self.lista_wszystkich_robotow_na_mapie()
        for robot in robot_na_mapie :
            if len(robot.rozkazy) >= 1 :
                rozkaz = robot.rozkazy.pop()
                self.wykonaj_rozkaz(robot, rozkaz)
        
        # pulapki niszczace roboty
        for ((i,j),obiekty) in self.pola_elementow.items() :
            if len(obiekty) >= 2 :
                 if self.czy_na_polu_jest_pulapka(i, j) :
                     self.usun_roboty_z_pola(i, j)
                     
        # teleportacje robotow
        for ((i,j),obiekty) in self.pola_elementow.items() :
            if len(obiekty) >= 2 :
                 if self.czy_na_polu_jest_teleportacja(i, j) :
                     self.teleportuj_roboty_z_pola(i, j)
        
        # kolizje co najmniej dwoch robotow
        for ((i,j),obiekty) in self.pola_elementow.items() :
            if len(obiekty) >= 2 :
                if len(self.roboty_na_polu(i, j)) >= 2 or self.czy_na_polu_jest_kraksa(i, j) :
                    # problemy z obiekty.clear()
                    for o in obiekty :
                        self.pola_elementow[(i, j)].remove(o)
                    obiekty.append(e.Efekt(4, self.rozmiar_klatki_mapy))
                    pass
                 
    def lista_wszystkich_robotow_na_mapie(self) :
        roboty = []
        for ((i,j),obiekty) in self.pola_elementow.items() :
            for obiekt in obiekty :
                if isinstance(obiekt, r.Robot) :
                    roboty.append(obiekt)
        return roboty
    
    def roboty_na_polu(self, i, j) :
        roboty = []
        for obiekt in self.pola_elementow[(i,j)] :
            if obiekt.typ == 'r' :
                roboty.append(obiekt)
        return roboty
    
    def czy_na_polu_jest_kraksa(self, i, j) :
        for obiekt in self.pola_elementow[(i,j)] :
            if obiekt.typ == 4 :
                return True
        return False
    
    def czy_na_polu_jest_pulapka(self, i, j) :
        for obiekt in self.pola_elementow[(i,j)] :
            if obiekt.typ == 5 :
                return True
        return False
    
    def czy_na_polu_jest_teleportacja(self, i, j) :
        for obiekt in self.pola_elementow[(i,j)] :
            if obiekt.typ == 6 :
                return True
        return False
    
    def usun_roboty_z_pola(self, i, j) :
        roboty = self.roboty_na_polu(i, j)
        for robot in roboty :
            self.pola_elementow[(i,j)].remove(robot)

    def teleportuj_roboty_z_pola(self, i, j) :
        roboty = self.roboty_na_polu(i, j)
        for robot in roboty :
            self.pola_elementow[(i,j)].remove(robot)
        for robot in roboty :
            x = int(random(0,self.szerokosc))
            y = int(random(0,self.wysokosc))
            self.pola_elementow[(x,y)].append(robot)
    
    def gdzie_jest_obiekt(self, obiekt):
        for ((i,j),obiekty) in self.pola_elementow.items() :
            if obiekt in obiekty :
                return (i,j)
        return None
    
    def czy_poza_mapa(self, i, j) :
        if i < 0 or i+1 > self.szerokosc :
            return True
        if j < 0 or j+1 > self.wysokosc :
            return True
        return False
    
    def czy_zajete(self, i, j) :
        if self.czy_poza_mapa(i, j) :
            return True
        return len(self.pola_elementow.get((i,j))) >= 1
    
    def czy_zablokowane(self, i, j) :
        # ta linijka odblokowuje kolizje
        return False
        if self.czy_poza_mapa(i, j) :
            return True
        return len(self.pola_elementow.get((i,j))) >= 1
    
    # na razie, sposrod obiektow na mapie, tylko roboty wykonuja rozkazy
    def wykonaj_rozkaz(self, robot, rozkaz) :
        (i,j) = self.gdzie_jest_obiekt(robot)
        if rozkaz == 0 :
            self.krokNaPolnoc(robot, i,j)
        elif rozkaz == 1 :
            self.krokNaWschod(robot, i,j)
        elif rozkaz == 2 :
            self.krokNaPoludnie(robot, i,j)
        elif rozkaz == 3 :
            self.krokNaZachod(robot, i,j)

    # metoda nie sprawdza poprawnosci: n.p. czy docelowe miejsce jest wolne
    def przesun_robota(self, robot, xp, yp, xk, yk) :
        # przesuniecie robota jest usunieciem go z listy pola (xp,yp) i dodaniem do listy pola (xk, yk)
        self.pola_elementow.get((xp,yp)).remove(robot)
        self.pola_elementow.get((xk,yk)).append(robot)

    def czy_na_granicy_mapy(self, i, j) :
        if i == 0 or i+1 == self.szerokosc :
            return True
        if j == 0 or j+1 == self.wysokosc :
            return True
        return False

    def krokNaPolnoc(self, robot, i, j) :
        if j == 0 or self.czy_zablokowane(i, j-1) :
            return False
        self.przesun_robota(robot,i,j,i,j-1)
        return True

    def krokNaWschod(self, robot, i, j) :
        if i+1 == self.szerokosc or self.czy_zablokowane(i+1, j) :
            return False
        self.przesun_robota(robot,i,j,i+1,j)
        return True

    def krokNaPoludnie(self, robot, i, j) :
        if j+1 == self.wysokosc or self.czy_zablokowane(i, j+1) :
            return False
        self.przesun_robota(robot,i,j,i,j+1)
        return True
    
    def krokNaZachod(self, robot, i, j) :
        if i == 0 or self.czy_zablokowane(i-1, j) :
            return False
        self.przesun_robota(robot,i,j,i-1,j)
        return True
        
    def naPolnocyWolne(self, robot) :
        (i,j) = self.gdzie_jest_obiekt(robot)
        return self.czy_zajete(i, j-1)
    def naWschodzieWolne(self, robot) :
        (i,j) = self.gdzie_jest_obiekt(robot)
        return self.czy_zajete(i+1, j)
    def naPoludniuWolne(self, robot) :
        (i,j) = self.gdzie_jest_obiekt(robot)
        return self.czy_zajete(i, j+1)
    def naZachodzieWolne(self, robot) :
        (i,j) = self.gdzie_jest_obiekt(robot)
        return self.czy_zajete(i-1, j)
