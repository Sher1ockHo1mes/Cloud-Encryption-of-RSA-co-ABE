#!/bin/bash 

for l in {1..1000};
do
./oabe_setup -s CP
#encryption

str01="aa"
echo $str01 >> abeencrypttime.txt
{ time ./oabe_enc -s CP -e "($str01)"  -i file.zip -o file$str01.cpabe 2>> sleep.stderr ; } 2>> abeencrypttime.txt
for i in Aa Ba Ca Da Ea Fa Ga Ha Ia Ja Ka La Ma Na Oa Pa Qa Ra Sa Ta Ua Va Wa Xa Ya Za Ab Bb Cb Db Eb Fb Gb Hb Ib Jb Kb Lb Mb Nb Ob Pb Qb Rb Sb Tb Ub Vb Wb Xb Yb Zb Ac Bc Cc Dc Ec Fc Gc Hc Ic Jc Kc Lc Mc Nc Oc Pc Qc Rc Sc Tc Uc Vc Wc Xc Yc Zc Ad Bd Cd Dd Ed Fd Gd Hd Id Jd Kd Ld Md Nd Od Pd Qd Rd Sd Td Ud
do
#       echo $i >> time.txt
        str01=${str01}" or "${i}
        echo $str01 >> abeencrypttime.txt
{ time ./oabe_enc -s CP -e "($str01)"  -i file.zip -o file$i.cpabe 2>> sleep.stderr ; } 2>> abeencrypttime.txt
#       echo "the arg is $i"
done

#generate key
str02="aa"
echo $str02 >> abegeneratekeytime.txt
{ time ./oabe_keygen -s CP  -i "$str02"  -o studentCP$str02 2>> sleep.stderr ; } 2>> abegeneratekeytime.txt
for i in Aa Ba Ca Da Ea Fa Ga Ha Ia Ja Ka La Ma Na Oa Pa Qa Ra Sa Ta Ua Va Wa Xa Ya Za Ab Bb Cb Db Eb Fb Gb Hb Ib Jb Kb Lb Mb Nb Ob Pb Qb Rb Sb Tb Ub Vb Wb Xb Yb Zb Ac Bc Cc Dc Ec Fc Gc Hc Ic Jc Kc Lc Mc Nc Oc Pc Qc Rc Sc Tc Uc Vc Wc Xc Yc Zc Ad Bd Cd Dd Ed Fd Gd Hd Id Jd Kd Ld Md Nd Od Pd Qd Rd Sd Td Ud
do
        str02=${str02}"|"${i}
        echo $str02 >> abegeneratekeytime.txt
        { time ./oabe_keygen -s CP  -i "$str02"  -o studentCP$i 2>> sleep.stderr ; } 2>> abegeneratekeytime.txt
done

#decryption
str03="aa"
echo $str03 >> abedecryptiontime.txt
{ time ./oabe_dec -s CP -k studentCP$str03.key -i file$str03.cpabe -o file_dec$str03.zip  2>> sleep.stderr ; } 2>> abedecryptiontime.txt
for i in Aa Ba Ca Da Ea Fa Ga Ha Ia Ja Ka La Ma Na Oa Pa Qa Ra Sa Ta Ua Va Wa Xa Ya Za Ab Bb Cb Db Eb Fb Gb Hb Ib Jb Kb Lb Mb Nb Ob Pb Qb Rb Sb Tb Ub Vb Wb Xb Yb Zb Ac Bc Cc Dc Ec Fc Gc Hc Ic Jc Kc Lc Mc Nc Oc Pc Qc Rc Sc Tc Uc Vc Wc Xc Yc Zc Ad Bd Cd Dd Ed Fd Gd Hd Id Jd Kd Ld Md Nd Od Pd Qd Rd Sd Td Ud
do
	echo $i >> abedecryptiontime.txt
        { time ./oabe_dec -s CP -k studentCP$i.key -i file$i.cpabe -o file_dec$i.zip  2>> sleep.stderr ; } 2>> abedecryptiontime.txt
done
done

