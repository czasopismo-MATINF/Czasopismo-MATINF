# Przygotowane z udziałem Microsoft Copilota
# Skrypt korzysta z plików w repozytorium https://github.com/mbornet-hl/MNIST
import os
import re
from PIL import Image
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import time
import numpy as np

folder_path = 'MNIST/IMAGES/GROUPS'

folder = 'cyfry'
os.makedirs(folder, exist_ok=True)

os.makedirs('tablice', exist_ok=True)

pattern = re.compile(r'.*MNIST_TESTS-(\d)_0\d001-0\d000_25x40\.png')

testdata=[]
for filename in os.listdir(folder_path):
    dopasowanie=pattern.match(filename)
    if dopasowanie:
        full_path = os.path.join(folder_path, filename)
        with open(full_path, 'r') as f:
            print(f'{filename}')
            #img = mpimg.imread(full_path)
            #plt.imshow(img)
            #plt.axis('off')
            #plt.show()
            img=Image.open(full_path).convert('L')
            print(img.mode)
            for i in range(0, 40):
                for j in range(0, 25):
                    #time.sleep(0.1)
                    digit=img.crop((300+36*i,200+j*30.88,300+36*i+35,200+j*30.88+30))
                    filename='cyfra.png'
                    path = os.path.join(folder, filename)
                    #digit.save(path)
                    arr=np.array(digit)
                    flatarr=arr.flatten()
                    label=int(dopasowanie.group(1))
                    td = np.insert(flatarr, 0, label)
                    testdata.append(td.tolist())

# zapisanie przygotowanej tablicy
with open("tablice/cyfry_testowe.txt", "w") as f:
    for wiersz in testdata:
        linia = " ".join(map(str, wiersz))
        f.write(linia + "\n")


pattern = re.compile(r'.*MNIST-(\d)_0\d001-0\d000_25x40\.png')

teachdata=[]
for filename in os.listdir(folder_path):
    dopasowanie=pattern.match(filename)
    if dopasowanie:
        full_path = os.path.join(folder_path, filename)
        with open(full_path, 'r') as f:
            print(f'{filename}')
            #img = mpimg.imread(full_path)
            #plt.imshow(img)
            #plt.axis('off')
            #plt.show()
            img=Image.open(full_path).convert('L')
            print(img.mode)
            for i in range(0, 40):
                for j in range(0, 25):
                    #time.sleep(0.1)
                    digit=img.crop((300+36*i,200+j*30.88,300+36*i+35,200+j*30.88+30))
                    filename='cyfra.png'
                    path = os.path.join(folder, filename)
                    #digit.save(path)
                    arr=np.array(digit)
                    flatarr=arr.flatten()
                    label=int(dopasowanie.group(1))
                    td = np.insert(flatarr, 0, label)
                    teachdata.append(td.tolist())

# zapisanie przygotowanej tablicy
with open("tablice/cyfry_uczace.txt", "w") as f:
    for wiersz in teachdata:
        linia = " ".join(map(str, wiersz))
        f.write(linia + "\n")




