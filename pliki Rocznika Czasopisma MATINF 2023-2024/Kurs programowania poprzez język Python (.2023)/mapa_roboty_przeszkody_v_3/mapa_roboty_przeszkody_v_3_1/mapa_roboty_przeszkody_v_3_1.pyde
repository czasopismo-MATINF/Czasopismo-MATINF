import Mapa as m
import Robot as r
import Efekt as e

rozmiar_klatki_mapy = 20

# poprawic tak, by wyswietlaly sie mapy innych ksztaltow niz prostokatne
mapa = m.Mapa(
[
 
 list("........................................"),
 list("........................................"),
 list("55555555555.5555555555555555555555555555"),
 list("..r.......r..........r......r........r.."),
 list("..................r..................r.."),
 list("......r...r.............r...r........r.."),
 list("..................r..................r.."),
 list("....r.....r....r.......r.....r.......r.."),
 list("..r........r........r................r.."),
 list(".......r....r.....r..........r.......r.."),
 list("6666666666666666666666666666666666666666")
], rozmiar_klatki_mapy)

roboty = mapa.roboty_na_mapie()

for robot in roboty :
    robot.set_color(int(random(0,255)),int(random(0,255)),int(random(0,255)))

def setup():
    size(800, 600)

def draw():
    # bez sladow robota
    background(200,200,200);
    mapa.dzialaj()
    mapa.rysuj(1)

    # tutaj rozkazy dla robotow na najblizsza ture

    # zmasowany pochod na polnoc
    #for robot in roboty :
    #    robot.krok_w_kierunku(0)
    
    # roboty chodzace losowo, kolizje ze wszystkim
    # 0 - polnoc, 1 - wschod, 2 - poludnie, 4 - zachod
    for robot in roboty :
        robot.krok_w_kierunku(int(random(0,4)))

    delay(100)
