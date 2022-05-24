#!/bin/bash 

for l in {1..1000};
do
str01="aa"
str02="aa"
#Generate the private key
echo $str01 >> rsagenprivatetime.txt 
{ time openssl genrsa -out rsa_private_key$str01.pem 1024 2>> sleep.stderr ; } 2>> rsagenprivatetime.txt

#Generate the public key
echo $str01 >> rsagenpublictime.txt
{ time openssl rsa -in rsa_private_key$str01.pem -pubout -out rsa_public_key$str01.pem 2>> sleep.stderr ; } 2>> rsagenpublictime.txt

#Encrypt the public key by Abe encryption
echo $str01 >> rsaencrypublictime.txt
{ time ./oabe_setup -s CP  2>> sleep.stderr ; } 2>> rsasetuptime.txt
{ time ./oabe_enc -s CP -e "($str01)"  -i rsa_public_key$str01.pem -o                 rsa_public_key_abeencry$str01.cpabe  2>> sleep.stderr ; } 2>> rsaencrypublictime.txt

#Generate the Abe's key 
echo $str01 >> rsagenabekeytime.txt
{ time ./oabe_keygen -s CP  -i "$str01"  -o studentACP$str01.key 2>> sleep.stderr ; } 2>> rsagenabekeytime.txt

#Decrypt by Abe's key to obtain public key
echo $str01 >> rsadecrypublictime.txt
{ time ./oabe_dec -s CP -k studentACP$str01.key -i rsa_public_key_abeencry$str01.cpabe -o rsa_public_key_abedecrypt$str01.pem 1024 2>> sleep.stderr ; } 2>> rsadecrypublictime.txt

#Encrypt plaintext by public key
echo $str01 >> rsaencryptbypublictime.txt
{ time openssl rsautl -encrypt -in input.txt -inkey rsa_public_key_abedecrypt$str01.pem -pubin -out input_encrypt$str01.txt 2>> sleep.stderr ; } 2>> rsaencryptbypublictime.txt

#Decrypt ciphertext by private key
echo $str01 >> rsadecryptbyprivatetime.txt
{ time openssl rsautl -decrypt -in input_encrypt$str01.txt -inkey rsa_private_key$str01.pem -out input_decrypt$str01.txt 2>> sleep.stderr ; } 2>> rsadecryptbyprivatetime.txt

for i in Aa Ba Ca Da Ea Fa Ga Ha Ia Ja Ka La Ma Na Oa Pa Qa Ra Sa Ta Ua Va Wa Xa Ya Za Ab Bb Cb Db Eb Fb Gb Hb Ib Jb Kb Lb Mb Nb Ob Pb Qb Rb Sb Tb Ub Vb Wb Xb Yb Zb Ac Bc Cc Dc Ec Fc Gc Hc Ic Jc Kc Lc Mc Nc Oc Pc Qc Rc Sc Tc Uc Vc Wc Xc Yc Zc Ad Bd Cd Dd Ed Fd Gd Hd Id Jd Kd Ld Md Nd Od Pd Qd Rd Sd Td Ud
do
	str01=${str01}" or "${i}  
#Generate the private key
echo $str01 >> rsagenprivatetime.txt 
{ time openssl genrsa -out rsa_private_key$i.pem 1024 2>> sleep.stderr ; } 2>> rsagenprivatetime.txt

#Generate the public key
echo $str01 >> rsagenpublictime.txt
{ time openssl rsa -in rsa_private_key$i.pem -pubout -out rsa_public_key$i.pem 2>> sleep.stderr ; } 2>> rsagenpublictime.txt
#Encrypt the public key by Abe encryption
echo $str01 >> rsaencrypublictime.txt
{ time ./oabe_setup -s CP 2>> sleep.stderr ; } 2>> rsasetuptime.txt
{ time ./oabe_enc -s CP -e "($str01)"  -i rsa_public_key$i.pem -o rsa_public_key_abeencry$i.cpabe  2>> sleep.stderr ; } 2>> rsaencrypublictime.txt

#Generate the Abe's key 
echo $str01 >> rsagenabekeytime.txt
str02=${str02}"|"${i}
{ time ./oabe_keygen -s CP  -i "$str02"  -o studentACP$i.key 2>> sleep.stderr ; } 2>> rsagenabekeytime.txt

#Decrypt by Abe's key to obtain public key
echo $str01 >> rsadecrypublictime.txt
{ time ./oabe_dec -s CP -k studentACP$i.key -i rsa_public_key_abeencry$i.cpabe -o rsa_public_key_abedecrypt$i.pem	 2>> sleep.stderr ; } 2>> rsadecrypublictime.txt

#Encrypt plaintext by public key
echo $str01 >> rsaencryptbypublictime.txt
{ time openssl rsautl -encrypt -in input.txt -inkey rsa_public_key_abedecrypt$i.pem -pubin -out input_encrypt$i.txt 2>> sleep.stderr ; } 2>> rsaencryptbypublictime.txt

#Decrypt ciphertext by private key
echo $str01 >> rsadecryptbyprivatetime.txt
{ time openssl rsautl -decrypt -in input_encrypt$i.txt -inkey rsa_private_key$i.pem -out input_decrypt$i.txt 2>> sleep.stderr ; } 2>> rsadecryptbyprivatetime.txt
done
done



