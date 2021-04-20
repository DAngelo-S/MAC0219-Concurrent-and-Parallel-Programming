// miniEP1
// Débora D'Angelo Reina de Araujo, NUSP 11221668
// comando para executar o programa: python3 version1.py

#include<stdio.h>
#include<vector>

using namespace std;

int main() {
    vector<short> crivo;
    long long N, primos = 0, primosEspeciais = 0;
    scanf("%lld", &N);
    N = 1 << N;
    crivo.resize(N + 1, 1);
    for(long long i = 2; i <= N; i++) {
        if(crivo[i] == 1) {
            primos++;
            if( i % 4 != 3)
                primosEspeciais++;
            for(long long j = i*i; j <= N; j+=i)
                crivo[j] = 0;
        }
    }
    printf("%lld %lld\n", primos, primosEspeciais);
}
