#!/bin/bash

for l in {1..1000};
do
str01="aa"
for i in Aa Ba Ca Da Ea Fa Ga Ha Ia Ja Ka La Ma Na Oa Pa Qa Ra Sa Ta Ua Va Wa Xa Ya Za Ab Bb Cb Db Eb Fb Gb Hb Ib Jb Kb Lb Mb Nb Ob Pb Qb Rb Sb Tb Ub Vb Wb Xb Yb Zb Ac Bc Cc Dc Ec Fc Gc Hc Ic Jc Kc Lc Mc Nc Oc Pc Qc Rc Sc Tc Uc Vc Wc Xc Yc Zc Ad Bd Cd Dd Ed Fd Gd Hd Id Jd Kd Ld Md Nd Od Pd Qd Rd Sd Td Ud Vd
do

        echo $str01 >> rsa_signtime.txt
#Generate the private key
	echo generate private key >> rsa_signtime.txt
{ time	openssl genrsa -out private$i.pem 1024  2>> sleep.stderr ; } 2>> rsa_signtime.txt

#Generate the public key
	echo generate public key >> rsa_signtime.txt
{ time	openssl rsa -in private$i.pem -pubout -out public$i.pem  2>> sleep.stderr ; } 2>> rsa_signtime.txt

#Encrypted by private key(you need to change the name of input file "input.txt" and output file)
echo encrypt by private >> rsa_signtime.txt
{ time openssl rsautl -sign -in input.txt -inkey private$i.pem -out input_enc$i.txt  2>> sleep.stderr ; } 2>> rsa_signtime.txt

#decrypted by public key(change the name of inputfile and output file)
echo decrypt by private >> rsa_signtime.txt
{ time openssl rsautl -verify -in input_enc$i.txt -inkey public$i.pem -pubin -out input_dec$i.txt  2>> sleep.stderr ; } 2>> rsa_signtime.txt
        str01=${str01}" or "${i}
done
done
