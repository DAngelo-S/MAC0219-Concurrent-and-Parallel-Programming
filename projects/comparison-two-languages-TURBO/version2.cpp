// miniEP2
// Débora D'Angelo Reina de Araujo, NUSP 11221668
// comando para executar o programa: python3 version1.py

#include<stdio.h>
#include<bits/stdc++.h>
#include<vector>

using namespace std;

int main() {
    vector<short> crivo;
    long long N, primos = 0, primosEspeciais = 0;
    scanf("%lld", &N);
    N = 1 << N;
    crivo.resize(N/2 + 1, 1);
    if(N >= 2) {
        primos++;
        primosEspeciais++;
    }
    for(long long i = 3; i <= N; i+=2) {
        if(crivo[i/2] == 1) {
            primos++;
            if( i % 4 != 3)
                primosEspeciais++;
            for(long long j = i*i; j <= N; j+=i)
                if (j % 2 == 1) crivo[j/2] = 0;
        }
    }
    printf("%lld %lld\n", primos, primosEspeciais);
}