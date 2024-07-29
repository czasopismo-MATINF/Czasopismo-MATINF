import Mapa as m
import Robot as r
import Efekt as e

rozmiar_klatki_mapy = 50

# poprawic tak, by wyswietlaly sie mapy innych ksztaltow niz prostokatne
mapa = m.Mapa(
[
 list(".7.6..........."),
 list("..............."),
 list("..............."),
 list("..............."),
 list("..............."),
 list(".7.5..........."),
 list("..............."),
 list("..r............"),
 list("..............."),
 list("...............")
], rozmiar_klatki_mapy)

def setup():
    size(800, 600)

def draw():
    # bez sladow robota
    # background(200,200,200);
    mapa.rysuj(1)

    # tutaj rozkazy dla robota
    #mapa.robot.krok_w_kierunku(1)
    
    # robot chodzacy losowo, ruch kolizyjny nie jest wykonywany
    mapa.robot.krok_w_kierunku(int(random(0,4)))

    delay(100)
