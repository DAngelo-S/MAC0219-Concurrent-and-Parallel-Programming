# miniEP2
# Débora D'Angelo Reina de Araujo, NUSP 11221668
# comando para executar o programa: python3 version1.py

N = 1 << int(input(""))
primos = 0
primosEspeciais = 0
crivo = [True] * int(N/2+1)
if N >= 2:
    primos = 1
    primosEspeciais = 1
    crivo[0] = 0;
for i in range(3, N+1, 2):
    if crivo[int(i/2)]:
        primos = primos + 1
        if i % 4 != 3:
            primosEspeciais = primosEspeciais + 1;
        for j in range(i*i, N+1, i):
            if j % 2 == 1:
                crivo[int(j/2)] = 0;
print(primos, primosEspeciais)