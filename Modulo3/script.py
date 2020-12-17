import subprocess as sp

def compilar():
    sp.call("gcc -o0 cache_not_friendly.c -o cache_not_friendly",shell=True)

def gerador():
    es = "(sudo perf stat -e cache-references,cache-misses  ./cache_not_friendly "
    di = " > /dev/null) > out 2>&1 && cat out | grep \"%\" >> miss"
    valor = 10
    while valor <= 1000:
        i = 0
        comando = es + str(valor) + di
        while i < 10:  
            sp.call(comando, shell=True)
            i += 1
        valor += 10

def geraMedias():
    arquivo = open("miss", "r")
    exe = []
    i = 0
    while i < 100:
        j = 0
        result = 0
        while j < 10:
            num = arquivo.readline(85)
            num = num[54:60]
            num = num[0:2]+"."+num[3:]
            result += float(num)
            j += 1
        exe.append(result/10)
        i += 1
    return exe

compilar()
gerador()
medias = geraMedias()
arquivo = open("medias", "w")

i = 0
while i < 100:
    media = str(round(medias[i]/100,4)).split('.')
    arquivo.write(media[0] + "," + media[1] + "\n")
    i += 1