import random


imię = input("Imię : ")
print("Dzień dobry ? : " + imię)


input("Pomyśl liczbę naturalną z przedziału [0,10]")
czy_zgadłem = False
while not czy_zgadłem :
    losowana_liczba = random.randint(0, 10)
    print("Czy wybrana liczba to : " + str(losowana_liczba))
    odpowiedz = input("Podaj odpowiedź Tak lub Nie : ")
    if odpowiedz.strip().lower() == "Tak".strip().lower() :
        czy_zgadłem = True
print("KONIEC GRY")
print()


input("Pomyśl liczbę naturalną z przedziału [0,10]")
czy_zgadłem = False
odgadywane = []
while not czy_zgadłem :
    losowana_liczba = random.randint(0, 10)
    print("Czy wybrana liczba to : " + str(losowana_liczba))
    odpowiedz = input("Podaj odpowiedź Tak lub Nie : ")
    if odpowiedz.strip().lower() == "Tak".strip().lower() :
        czy_zgadłem = True
    elif losowana_liczba not in odgadywane :
        odgadywane.append(losowana_liczba)
        print(odgadywane)
    elif len(odgadywane) == 11 :
        print("Sprawdzałem już wszystkie liczby : " + str(sorted(odgadywane)) + "!")
        break
print("KONIEC GRY")
print()


input("Pomyśl liczbę naturalną z przedziału [0,10]")

losowana_liczba
odgadywane = []
czy_zgadłem = False

while True :
    losowana_liczba = random.randint(0, 10)
    if losowana_liczba not in odgadywane :
        odgadywane.append(losowana_liczba)
        print("Czy wybrana liczba to : " + str(losowana_liczba))
        odpowiedz = input("Podaj odpowiedź Tak lub Nie : ")
        if odpowiedz.strip().lower() == "Tak".strip().lower() :
            czy_zgadłem = True
    if czy_zgadłem == True or len(odgadywane) == 11 :
        break

print("Wypróbowałem odpowiedzi: " + str(sorted(odgadywane)))

if czy_zgadłem :
    print("Udało mi się odgadnąć liczbę : " + str(losowana_liczba))
else :
    print("Sprawdziłem już wszystkie liczby!")

print("KONIEC GRY")