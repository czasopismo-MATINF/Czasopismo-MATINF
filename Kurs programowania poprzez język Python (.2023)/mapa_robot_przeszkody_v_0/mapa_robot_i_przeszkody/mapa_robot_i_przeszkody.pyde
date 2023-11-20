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
 list("..6............"),
 list("..............."),
 list("...............")
], rozmiar_klatki_mapy)

# przeniesc punkt poczatkowy robota na mape
robot = r.Robot(mapa, rozmiar_klatki_mapy, [2,4])

def setup():
    size(800, 600)

def draw():
    mapa.rysuj(1)
    robot.rysuj()

    #tutaj rozkazy dla robota
    robot.krok_w_kierunku(1)

    delay(100)
