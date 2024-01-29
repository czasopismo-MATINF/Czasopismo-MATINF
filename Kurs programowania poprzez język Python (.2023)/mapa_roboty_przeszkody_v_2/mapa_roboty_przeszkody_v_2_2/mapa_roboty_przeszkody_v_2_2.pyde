import Mapa as m
import Robot as r
import Efekt as e

rozmiar_klatki_mapy = 50

# poprawic tak, by wyswietlaly sie mapy innych ksztaltow niz prostokatne
mapa = m.Mapa(
[
 list("..............."),
 list(".7.6.5.4......."),
 list("..r.......r...."),
 list("..............."),
 list("......r........"),
 list(".7.6.5.4......."),
 list("..............."),
 list("..r........r..."),
 list("....4.........."),
 list("........r......")
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
    
    # roboty chodzace losowo, kto pierwszy ten lepszy, ruch kolizyjny nie jest wykonywany
    # 0 - polnoc, 1 - wschod, 2 - poludnie, 4 - zachod
    for robot in roboty :
        robot.krok_w_kierunku(int(random(0,4)))

    delay(100)
