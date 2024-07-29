def wypisz(do_wypisania):
    print(do_wypisania)
    
def odkresl(do_wypisania = None):
    if do_wypisania != None:
        print(do_wypisania)
    print("*************************")

#***** KOLEKCJE, LISTY *****#
wypisz("#***** KOLEKCJE I LISTY *****#")

l = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
t = tuple(l)
s = set(l)
fs = frozenset(l)

kolekcje = [l, t, s, fs]
uporzadkowane_kolekcje = [l, t]
zbiory = [s, fs]
modyfikowalne_kolekcje = [l]

parzyste = lambda n : n % 2 == 0
duze = lambda n : n > 50
male = lambda n : n < 30
bardzo_male = lambda n : n < 3

print(len(l), len(t), len(s), len(fs))
odkresl()

for k in kolekcje:
    for n in filter(parzyste, k):
        wypisz(n)
    wypisz(any(map(duze, k)))
    wypisz(any(map(bardzo_male, k)))
    wypisz(all(map(male, k)))
    wypisz(all(map(bardzo_male, k)))

    #ani set, ani frozen set nie sa odwracalne
    wypisz(sorted(k))
    wypisz(sorted(k, reverse = True))
    #wypisz(reversed(k))
    print(max(k), min(k), sum(k, start = 100))
    odkresl()

for n in map(lambda x, y, z, w : x*y + z + w, l, t, s, fs):
    wypisz(n)
odkresl()

#nie dziala ze zbiorami, ostatni oznacza przeskok:
for k in uporzadkowane_kolekcje:
    print(k[2], k[2:8], k[2:8:2])
odkresl()

for e in zip(l,t):
    wypisz(e)
odkresl()

#nie dziala z tuplami:

kopia_l = l.copy()
del l[1:10:2]
l.append(20)
l.extend(kopia_l)
l *= 2
l.pop()
l.pop(1)
l.remove(5)
l.reverse()
l.insert(1, 40)
wypisz(l)
l.clear()
wypisz(l)
l = kopia_l
wypisz(l)
odkresl()

print(kolekcje, uporzadkowane_kolekcje, zbiory, modyfikowalne_kolekcje)
kolekcje[0] = l
uporzadkowane_kolekcje[0] = l
modyfikowalne_kolekcje[0] = l
print(kolekcje, uporzadkowane_kolekcje, zbiory, modyfikowalne_kolekcje)

odkresl()

for k in kolekcje:
    wypisz(5 in k)
    wypisz(5 not in k)
    wypisz(101 in k)
    wypisz(101 not in k)

odkresl()

#lista - brak add, update; set - brak append
wypisz([1,2,3] <= [1,2,3])
wypisz([1,2,3] < [-1,3,4,5])
wypisz((1,2,3) <= (1,2,3))
wypisz((1,2,3) < (-1,3,4,5))
wypisz({1,2,3} <= {1,2,3})
wypisz({1,2,3} < {3,4,5,-1})

#***** ZBIORY *****#
wypisz("#***** ZBIORY *****#")

s1 = {1,2,3,4,5}
s2 = {6,7,8,9,10}
s3 = {2,3}
s4 = {2,3,6,7}

wypisz(s1.isdisjoint(s2))
wypisz(s3.issubset(s1))
wypisz(s1.issuperset(s3))
wypisz(s4.issubset(s2))
wypisz(s2.issuperset(s4))

odkresl()

wypisz(s1 | s2)
wypisz(s1 & s4)
wypisz(s1 - s4)
wypisz(s1 ^ s4)

s1 |= s4
wypisz(s1)
s1 &= s2
wypisz(s1)
s1 -= s2
wypisz(s1)
s1 ^= s2
wypisz(s1)
s1.remove(7)
wypisz(s1)
s1.discard(9)
wypisz(s1)
s1.pop()
wypisz(s1)
#wyjatek, jesli nie ma elementu do usuniecia
#s1.remove(100)
s1.discard(100)
wypisz(s1)

odkresl()

#***** SLOWNIKI *****#
wypisz("#***** SLOWNIKI *****#")

d1 = dict([('a', 1), ('b', 2), ('c', 3)])
d2 = d1 | {'a': 4, 'd': 5}
wypisz(d1)
wypisz(d2)
wypisz(len(d1))
wypisz(d1.items())
wypisz(d1.keys())
wypisz(d1.values())
d2.update(d1)
wypisz(d2)

d2.setdefault('y', "BRAK")
#wyjatek, jesli nie ma klucza
#wypisz(d2['z'])
wypisz(d2.get('z', 'brak'))
wypisz(d2['y'])
del d2['a']
wypisz(d2)
wypisz(d2.pop('b', 'brak'))
wypisz(d2)
wypisz(d2.pop('y', 'brak'))
wypisz(d2)
wypisz(d2.popitem())
wypisz(d2)

odkresl()

for e in iter(d1):
    wypisz(e)
for e in reversed(d1):
    wypisz(e)

wypisz(dict.fromkeys([1,2,3,4,5],100))

odkresl()

#***** LICZBY *****#
wypisz("#***** LICZBY *****#")

import math

pi = 3.1415
r = 2
q = 1.0000001

print(divmod(100,7), divmod(100, 10))
print(divmod(11111222223333344444555556666677777888889999900000,9))
print(divmod(11111222223333344444555556666677777888889999900000,7))
#print(pow(11111222223333344444555556666677777888889999900000,987654321))
print(pow(11111222223333344444555556666677777888889999900000,987654321,111))

print(pi * pow(r ,2), pow(r, 2) * pi, pi * r ** 2)
print( pi * r + pi * r, 2*pi*r)
print(r+q,r-q,r*q,r/q,r//q,r%q)

print(round(pi,2), round(pi), math.trunc(pi), math.floor(pi), math.ceil(pi))
print(pi.is_integer(), pi.as_integer_ratio())
print(abs(-pi), int(-pi), float(-pi), complex(-pi), complex(-pi).conjugate())

j = complex(0, 1)
liczby_zespolone = [complex(1), complex(2), complex(2,2), complex(0, -1)]
for z in liczby_zespolone:
    wypisz(pow(z, j))

# ?
print(pi is int, pi is float, pi is complex)

#***** NAPISY *****#
wypisz("#***** NAPISY *****#")

tytul = "Czasopismo MATINF"
print(tytul)
print(tytul.find("MAT"), tytul.rfind('o'))
print(tytul.index("MAT"), tytul.rindex('o'))
print(tytul.count('o'))
print(tytul.replace("MATINF", "MAT-INF"))
print(tytul.startswith("Cza") and tytul.endswith("INF"))
print(tytul.split('o'), (tytul * 2).rsplit("o"))
print(tytul.join(tytul.split()))
print(tytul.join(['1','2','3','4','5']))
print(tytul.partition('o'), tytul.rpartition('o'))
print("-----")
print(tytul.capitalize(), tytul.casefold(), tytul.lower(), tytul.upper(), tytul.swapcase(), tytul.title())
tytul = "......." + tytul + "......."
print(tytul, tytul.strip("."))
print(tytul, tytul.lstrip("."))
print(tytul, tytul.rstrip("."))
print(tytul, tytul.removeprefix("....."))
print(tytul, tytul.removesuffix("....."))
print(tytul.ljust(50,"_"))
print(tytul.rjust(50,"_"))
print(tytul.center(50,"_"))
print(tytul.zfill(50))
print("-----")
print("zaq1xsw2".isalnum())
print("zaq1xsw2".isalpha())
print("zaq1xsw2".isascii())
print("123123".isdecimal(),"123,123".isdecimal(),"123.123".isdecimal())
print("1".isdigit(),"123".isdigit(),"123".isnumeric(),"123,123".isnumeric(),"123.123".isnumeric())
print("nazwa_zmiennej".isidentifier(), "     ".isspace(), "Asdf Asdf".istitle())
print("asdf".islower(),"Asdf".islower())
print("ASDF".isupper(),"ASDf".isupper())
print("§1".isascii(), "§1???".isprintable())
print("-----")
liczba = 123123
print(ascii(liczba))
print(bin(liczba))
print(oct(liczba))
print(hex(liczba))
print(chr(65), chr(90), ord('A'), ord('Z'))
print("-----")
tablica_translacji = "123".maketrans("123", "789")
print(tablica_translacji)
print("123123".translate(tablica_translacji))
print("123\t4512\t3123".expandtabs(4))

#***** LICZBY *****#
wypisz("#***** WEJŚCIE WYJŚCIE *****#")

#x = input("Podaj liczbę: ")
#y = input("Podja druga liczbę: ")
#print("Suma: " + str(float(x) + float(y)))
#print("Suma: {} iloczyn: {}".format(str(float(x)+float(y)), str(float(x)*float(y))))
#print("Lista: {}".format(repr([1,2,3,4,5])))

#help()
#help("str")

#***** KLASY, OBIEKTY, ATRYBUTY *****#
wypisz("#***** KLASY, OBIEKTY, ATRYBUTY *****#")

l = [1,2,3,4,5]
print(dir(l))
print(isinstance(dir(l), list))
# co opisuje bez parametrow?
print(dir())
print(id(l))
print(hash((1,2,3,4,5)))

#input()

print(locals())
print(globals())
print(isinstance(locals(), dict))
print(isinstance(globals(), dict))
print(issubclass(locals().__class__, dict))
print(issubclass(globals().__class__, dict))
print(callable(locals()))

wypisz("\nsetattr, delattr, getattr: ")
class A:
    pass

a = A()
print(dir(a))
setattr(a, "wymiar_x", 10)
setattr(a, "wymiar_y", 20)
print(dir(a))
print(hasattr(a, "wymiar_x") and hasattr(a, "wymiar_y"))
print(getattr(a, "wymiar_x"), getattr(a, "wymiar_y"))
delattr(a, "wymiar_y")
print(hasattr(a, "wymiar_x"), hasattr(a, "wymiar_y"))

