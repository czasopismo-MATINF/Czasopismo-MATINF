import Mapa as m
import Robot as r

rozmiar_klatki_mapy = 50

mapa = m.Mapa(
["...............",
 "...............",
 "...............",
 "...............",
 "...............",
 "...............",
 "...............",
 "...............",
 "...............",
 "..............."
], rozmiar_klatki_mapy)

robot = r.Robot(mapa, rozmiar_klatki_mapy, [2,4])

def setup():
    size(800, 600)

def draw():
    mapa.wyswietl()
    robot.wyswietl()

    #tutaj rozkazy dla robota
    robot.krok_w_kierunku(1)

    delay(500)
