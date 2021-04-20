# miniEP1
# Débora D'Angelo Reina de Araujo, NUSP 11221668
# comando para executar o programa: python3 version1.py

N = 1 << int(input(""))
primos = 0
primosEspeciais = 0
crivo = [True] * (N+1)
for i in range(2, N+1):
    if crivo[i]:
        primos = primos + 1
        if i % 4 != 3:
            primosEspeciais = primosEspeciais + 1;
        for j in range(i*2, N+1, i):
            crivo[j] = False;
print(primos, primosEspeciais)