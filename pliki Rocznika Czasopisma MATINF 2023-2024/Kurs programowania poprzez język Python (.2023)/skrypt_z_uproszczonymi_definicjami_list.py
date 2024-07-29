napisy = [ 'Liczba : ' + str(x) for x in range(1,20)]

numery = [x for x in range(0,20) if x > 0]

pary = [ x for x in zip(numery, napisy)]

parzyste = [ (x,y) for x,y in pary if x % 2 == 0]

suma1 = sum([x for x,y in parzyste])

# prawie to samo w jednej linijce:

suma2 = sum([ z for y,z in [ (a,b) for a,b in zip([ 'Liczba : ' + str(x) for x in range(1,20)], [x for x in range(0,20) if x > 0]) if b % 2 == 0] ])

print(suma1, suma2)
