echo "Sistema Operacional" > test_result
lsb_release -d >> test_result
echo "" >> test_result

echo "CPU" >> test_result
lscpu | grep "Nome do modelo: " >> test_result
echo "" >> test_result

echo "Versões" >> test_result
python3 --version >> test_result
g++ --version >> test_result

echo "24" >> 24
echo "26" >> 26

echo "" >> test_result

echo "Teste Python ---- Entrada: 24" >> test_result
echo "" >> test_result

CNT=1
while [ $CNT -lt 6 ]; do
	echo "Teste $CNT : " >> test_result 
	/usr/bin/time -ao test_result python3 version1.py < 24
	echo "" >> test_result
	let CNT=CNT+1;
done

echo "" >> test_result

echo "Teste Python --- Entrada: 26" >> test_result
echo "" >> test_result

CNT=1
while [ $CNT -lt 6 ]; do
	echo "Teste $CNT : " >> test_result
	/usr/bin/time -ao test_result python3 version1.py < 26
	echo "" >> test_result
	let CNT=CNT+1;
done

echo "" >> test_result
echo "" >> test_result
echo "" >> test_result

g++ version2.cpp
echo "Teste C++ ---- Entrada: 24" >> test_result
echo "" >> test_result

CNT=1
while [ $CNT -lt 6 ]; do
	echo "Teste $CNT: " >> test_result
	/usr/bin/time -ao test_result ./a.out < 24
	echo "" >> test_result
	let CNT=CNT+1;
done

echo "" >> test_result

echo "Teste C++ --- Entrada: 26" >> test_result
echo "" >> test_result

CNT=1
while [ $CNT -lt 6 ]; do
	echo "Teste $CNT: " >> test_result
	/usr/bin/time -ao test_result ./a.out < 26
	echo -n "" >> test_result
	let CNT=CNT+1;
done

rm -f 24 26 a.out