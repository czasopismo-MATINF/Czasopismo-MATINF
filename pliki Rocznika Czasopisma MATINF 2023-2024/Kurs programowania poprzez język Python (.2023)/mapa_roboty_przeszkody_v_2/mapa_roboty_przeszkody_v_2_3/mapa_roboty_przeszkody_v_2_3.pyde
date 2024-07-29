import Mapa as m
import Robot as r
import Efekt as e

rozmiar_klatki_mapy = 20

# poprawic tak, by wyswietlaly sie mapy innych ksztaltow niz prostokatne
mapa = m.Mapa(
[
 list("....7..r...6.......................r.."),
 list(".7...5................................"),
 list("..r..6....r......................5.r.."),
 list("...........7.........................."),
 list("..5...r...r......................6.r.."),
 list(".7.6.5................................"),
 list("....r.....r......................5.r.."),
 list("..r....5...r.........................."),
 list(".......r....r....................6.r.."),
 list("..7.....r.............................")
], rozmiar_klatki_mapy)

roboty = mapa.roboty_na_mapie()

def setup():
    size(800, 600)

def draw():
    # bez sladow robota
    background(200,200,200);
    mapa.dzialaj()
    mapa.rysuj(1)

    # tutaj rozkazy dla robotów
    #roboty[0].krok_w_kierunku(1)
    
    # roboty chodzace losowo, kolizje ze soba
    # 0 - polnoc, 1 - wschod, 2 - poludnie, 4 - zachod
    for robot in roboty :
        robot.krok_w_kierunku(int(random(0,4)))

    delay(100)
