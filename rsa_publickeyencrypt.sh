#!/bin/bash 

for l in {1..1000};
do
str01="aa"
str02="aa"
#产生私钥
echo $str01 >> rsagenprivatetime.txt 
{ time openssl genrsa -out rsa_private_key$str01.pem 1024 2>> sleep.stderr ; } 2>> rsagenprivatetime.txt

#产生公钥
echo $str01 >> rsagenpublictime.txt
{ time openssl rsa -in rsa_private_key$str01.pem -pubout -out rsa_public_key$str01.pem 2>> sleep.stderr ; } 2>> rsagenpublictime.txt

#用openabe对公钥加密（将加密后的公钥发送给用户，用户用abe属性解密，要将.cpabe加密秘钥和环境文件一起发送给用户）
echo $str01 >> rsaencrypublictime.txt
{ time ./oabe_setup -s CP  2>> sleep.stderr ; } 2>> rsasetuptime.txt
{ time ./oabe_enc -s CP -e "($str01)"  -i rsa_public_key$str01.pem -o                 rsa_public_key_abeencry$str01.cpabe  2>> sleep.stderr ; } 2>> rsaencrypublictime.txt

###用openabe对公钥解密
#产生openabe的密钥
echo $str01 >> rsagenabekeytime.txt
{ time ./oabe_keygen -s CP  -i "$str01"  -o studentACP$str01.key 2>> sleep.stderr ; } 2>> rsagenabekeytime.txt

#openabe对公钥解密
echo $str01 >> rsadecrypublictime.txt
{ time ./oabe_dec -s CP -k studentACP$str01.key -i rsa_public_key_abeencry$str01.cpabe -o rsa_public_key_abedecrypt$str01.pem 1024 2>> sleep.stderr ; } 2>> rsadecrypublictime.txt

#公钥加密
echo $str01 >> rsaencryptbypublictime.txt
{ time openssl rsautl -encrypt -in input.txt -inkey rsa_public_key_abedecrypt$str01.pem -pubin -out input_encrypt$str01.txt 2>> sleep.stderr ; } 2>> rsaencryptbypublictime.txt

#私钥解密
echo $str01 >> rsadecryptbyprivatetime.txt
{ time openssl rsautl -decrypt -in input_encrypt$str01.txt -inkey rsa_private_key$str01.pem -out input_decrypt$str01.txt 2>> sleep.stderr ; } 2>> rsadecryptbyprivatetime.txt

for i in Aa Ba Ca Da Ea Fa Ga Ha Ia Ja Ka La Ma Na Oa Pa Qa Ra Sa Ta Ua Va Wa Xa Ya Za Ab Bb Cb Db Eb Fb Gb Hb Ib Jb Kb Lb Mb Nb Ob Pb Qb Rb Sb Tb Ub Vb Wb Xb Yb Zb Ac Bc Cc Dc Ec Fc Gc Hc Ic Jc Kc Lc Mc Nc Oc Pc Qc Rc Sc Tc Uc Vc Wc Xc Yc Zc Ad Bd Cd Dd Ed Fd Gd Hd Id Jd Kd Ld Md Nd Od Pd Qd Rd Sd Td Ud
do
	str01=${str01}" or "${i}  
#产生私钥
echo $str01 >> rsagenprivatetime.txt 
{ time openssl genrsa -out rsa_private_key$i.pem 1024 2>> sleep.stderr ; } 2>> rsagenprivatetime.txt

#产生公钥
echo $str01 >> rsagenpublictime.txt
{ time openssl rsa -in rsa_private_key$i.pem -pubout -out rsa_public_key$i.pem 2>> sleep.stderr ; } 2>> rsagenpublictime.txt
#用openabe对公钥加密（将加密后的公钥发送给用户，用户用abe属性解密，要将.cpabe加密秘钥和环境文件一起发送给用户）
echo $str01 >> rsaencrypublictime.txt
{ time ./oabe_setup -s CP 2>> sleep.stderr ; } 2>> rsasetuptime.txt
{ time ./oabe_enc -s CP -e "($str01)"  -i rsa_public_key$i.pem -o rsa_public_key_abeencry$i.cpabe  2>> sleep.stderr ; } 2>> rsaencrypublictime.txt

###用openabe对公钥解密
#产生openabe的密钥
echo $str01 >> rsagenabekeytime.txt
str02=${str02}"|"${i}
{ time ./oabe_keygen -s CP  -i "$str02"  -o studentACP$i.key 2>> sleep.stderr ; } 2>> rsagenabekeytime.txt

#openabe对公钥解密
echo $str01 >> rsadecrypublictime.txt
{ time ./oabe_dec -s CP -k studentACP$i.key -i rsa_public_key_abeencry$i.cpabe -o rsa_public_key_abedecrypt$i.pem	 2>> sleep.stderr ; } 2>> rsadecrypublictime.txt

#公钥加密
echo $str01 >> rsaencryptbypublictime.txt
{ time openssl rsautl -encrypt -in input.txt -inkey rsa_public_key_abedecrypt$i.pem -pubin -out input_encrypt$i.txt 2>> sleep.stderr ; } 2>> rsaencryptbypublictime.txt

#私钥解密
echo $str01 >> rsadecryptbyprivatetime.txt
{ time openssl rsautl -decrypt -in input_encrypt$i.txt -inkey rsa_private_key$i.pem -out input_decrypt$i.txt 2>> sleep.stderr ; } 2>> rsadecryptbyprivatetime.txt
done
done


#!/bin/bash 

#./oabe_setup -s CP
#./oabe_keygen -s CP  -i "male|studentA|authorised"  -o studentACP
#{time ./oabe_enc -s CP -e "(teacher or authorised)"  -i file.zip -o file1.cpabe ; }  2>>time.txt
#./oabe_dec -s CP -k studentACP.key -i file.cpabe -o file_dec.zip
#time -ao time.txt  ./oabe_enc -s CP -e "(teacher or authorised or ca)"  -i file.zip -o file2.cpabe   2>>time.txt
#{ time ./oabe_enc -s CP -e "(a or b or c)"  -i file.zip -o file1.cpabe 2> sleep.stderr ; } 2>> time.txt

#encryption

#str01="aa"
#{ time ./oabe_enc -s CP -e "($str01)"  -i file.zip -o file$str01.cpabe 2> sleep.stderr ; } 2>> encrypttime.txt
#for i in Aa Ba Ca Da Ea Fa Ga Ha Ia Ja Ka La Ma Na Oa Pa Qa Ra Sa Ta Ua Va Wa Xa Ya Za Ab Bb Cb Db Eb Fb Gb Hb Ib Jb Kb Lb Mb Nb Ob Pb Qb Rb Sb Tb Ub Vb Wb Xb Yb Zb Ac Bc Cc Dc Ec Fc Gc Hc Ic Jc Kc Lc Mc Nc Oc Pc Qc Rc Sc Tc Uc Vc Wc Xc Yc Zc Ad Bd Cd Dd Ed Fd Gd Hd Id Jd Kd Ld Md Nd Od Pd Qd Rd Sd Td Ud
#do
#       echo $i >> time.txt
#        str01=${str01}" or "${i}
#       echo $str01 >> time.txt
#{ time ./oabe_enc -s CP -e "($str01)"  -i file.zip -o file$i.cpabe 2> sleep.stderr ; } 2>> encrypttime.txt
#       echo "the arg is $i"
#done

#generate key
#str02="aa"
#{ time ./oabe_keygen -s CP  -i "$str02"  -o studentCP$i 2> sleep.stderr ; } 2>> generatekeytime.txt
#for i in Aa Ba Ca Da Ea Fa Ga Ha Ia Ja Ka La Ma Na Oa Pa Qa Ra Sa Ta Ua Va Wa Xa Ya Za Ab Bb Cb Db Eb Fb Gb Hb Ib Jb Kb Lb Mb Nb Ob Pb Qb Rb Sb Tb Ub Vb Wb Xb Yb Zb Ac Bc Cc Dc Ec Fc Gc Hc Ic Jc Kc Lc Mc Nc Oc Pc Qc Rc Sc Tc Uc Vc Wc Xc Yc Zc Ad Bd Cd Dd Ed Fd Gd Hd Id Jd Kd Ld Md Nd Od Pd Qd Rd Sd Td Ud
#do
#        str02=${str02}"|"${i}
#        { time ./oabe_keygen -s CP  -i "$str02"  -o studentCP$i 2> sleep.stderr ; } 2>> generatekeytime.txt
#done

#decryption
#str03="aa"
#{ time ./oabe_dec -s CP -k studentCP$str03.key -i file$str03.cpabe -o file_dec$str03.zip  2> sleep.stderr ; } 2>> decryptiontime.txt
#for i in Aa Ba Ca Da Ea Fa Ga Ha Ia Ja Ka La Ma Na Oa Pa Qa Ra Sa Ta Ua Va Wa Xa Ya Za Ab Bb Cb Db Eb Fb Gb Hb Ib Jb Kb Lb Mb Nb Ob Pb Qb Rb Sb Tb Ub Vb Wb Xb Yb Zb Ac Bc Cc Dc Ec Fc Gc Hc Ic Jc Kc Lc Mc Nc Oc Pc Qc Rc Sc Tc Uc Vc Wc Xc Yc Zc Ad Bd Cd Dd Ed Fd Gd Hd Id Jd Kd Ld Md Nd Od Pd Qd Rd Sd Td Ud
#do
#        str02=${str02}"|"${i}
#        { time ./oabe_dec -s CP -k studentCP$i.key -i file$i.cpabe -o file_dec$i.zip  2> sleep.stderr ; } 2>> decryptiontime.txt
#done

#产生私钥
#echo genprivatekey >> rsaencrypttime.txt
#{ time openssl genrsa -out rsa_private_key.pem 1024 2> sleep.stderr ; } 2>> rsaencrypttime.txt
#产生公钥
#echo genpublickey >> rsaencrypttime.txt
#{ time openssl rsa -in rsa_private_key.pem -pubout -out rsa_public_key.pem 2> sleep.stderr ; } 2>> rsaencrypttime.txt
#用openabe对公钥加密（将加密后的公钥发送给用户，用户用abe属性解密，要将.cpabe加密秘钥和环境文件一起发送给用户）
#echo encrypublic >> rsaencrypttime.txt
#{ time ./oabe_setup -s CP && ./oabe_enc -s CP -e "(teacher or authorised)"  -i rsa_public_key.pem -o rsa_public_key_abeencry.cpabe  2> sleep.stderr ; } 2>> rsaencrypttime.txt
#用openabe对公钥解密
#echo decrypublic >> rsaencrypttime.txt
#{ time ./oabe_keygen -s CP  -i "male|studentA|authorised"  -o studentACP && ./oabe_dec -s CP -k studentACP.key -i rsa_public_key_abeencry.cpabe -o rsa_public_key_abedecrypt.pem 1024 2> sleep.stderr ; } 2>> rsaencrypttime.txt
#用公钥对明文加密(用户加密后将密文发送给）
#echo encryplaintxtwithpublic >> rsaencrypttime.txt
#{ time openssl rsautl -encrypt -in input.txt -inkey rsa_public_key.pem -pubin -out input_encrypt.txt 2> sleep.stderr ; } 2>> rsaencrypttime.txt
#私钥解密
#echo decrywithprivate >> rsaencrypttime.txt
#{ time openssl rsautl -decrypt -in input_encrypt.txt -inkey rsa_private_key.pem -out input_decrypt.txt 2> sleep.stderr ; } 2>> rsaencrypttime.txt

#!/bin/bash 

#for l in {1..1};
#do

#str01="aa"
##产生私钥
#echo genprivatekey >> rsaencrypttime.txt
#{ time openssl genrsa -out rsa_private_key$str01.pem 1024 2>> sleep.stderr ; } 2>> rsaencrypttime.txt
##产生公钥
#echo genpublickey >> rsaencrypttime.txt
#{ time openssl rsa -in rsa_private_key$str01.pem -pubout -out rsa_public_key$str01.pem 2>> sleep.stderr ; } 2>> rsaencrypttime.txt
##用openabe对公钥加密（将加密后的公钥发送给用户，用户用abe属性解密，要将.cpabe加密秘钥和环境文件一起发送给用户）
#echo encrypublic >> rsaencrypttime.txt
#{ time ./oabe_setup -s CP  2>> sleep.stderr ; } 2>> rsaencrypttime.txt
#{ time ./oabe_enc -s CP -e "($str01)"  -i rsa_public_key$str01.pem -o                 rsa_public_key_abeencry$str01.cpabe  2>> sleep.stderr ; } 2>> rsaencrypttime.txt
#for i in Aa Ba Ca Da Ea Fa Ga Ha Ia Ja Ka La Ma Na Oa Pa Qa Ra Sa Ta Ua Va Wa Xa Ya Za Ab Bb Cb Db Eb Fb Gb Hb Ib Jb Kb Lb Mb Nb Ob Pb Qb Rb Sb Tb Ub Vb Wb Xb Yb Zb Ac Bc Cc Dc Ec Fc Gc Hc Ic Jc Kc Lc Mc Nc Oc Pc Qc Rc Sc Tc Uc Vc Wc Xc Yc Zc Ad Bd Cd Dd Ed Fd Gd Hd Id Jd Kd Ld Md Nd Od Pd Qd Rd Sd Td Ud
#do
#	str01=${str01}" or "${i}
 #       echo $str01 >> rsaencrypttime.txt    
##产生私钥
#echo genprivatekey >> rsaencrypttime.txt
#{ time openssl genrsa -out rsa_private_key$i.pem 1024 2>> sleep.stderr ; } 2>> rsaencrypttime.txt
##产生公钥
#echo genpublickey >> rsaencrypttime.txt
#{ time openssl rsa -in rsa_private_key$i.pem -pubout -out rsa_public_key$i.pem 2>> sleep.stderr ; } 2>> rsaencrypttime.txt
##用openabe对公钥加密（将加密后的公钥发送给用户，用户用abe属性解密，要将.cpabe加密秘钥和环境文件一起发送给用户）
#echo encrypublic >> rsaencrypttime.txt
#{ time ./oabe_setup -s CP 2>> sleep.stderr ; } 2>> rsaencrypttime.txt
#{ time ./oabe_enc -s CP -e "($str01)"  -i rsa_public_key$i.pem -o rsa_public_key_abeencry$i.cpabe  2>> sleep.stderr ; } 2>> rsaencrypttime.txt
#done




##用openabe对公钥解密
##产生openabe的密钥
#echo genabekey >> rsaencrypttime.txt
#str02="aa"
#{ time ./oabe_keygen -s CP  -i "$str02"  -o studentACP$str02.key 2>> sleep.stderr ; } 2>> rsaencrypttime.txt
#for i in Aa Ba Ca Da Ea Fa Ga Ha Ia Ja Ka La Ma Na Oa Pa Qa Ra Sa Ta Ua Va Wa Xa Ya Za Ab Bb Cb Db Eb Fb Gb Hb Ib Jb Kb Lb Mb Nb Ob Pb Qb Rb Sb Tb Ub Vb Wb Xb Yb Zb Ac Bc Cc Dc Ec Fc Gc Hc Ic Jc Kc Lc Mc Nc Oc Pc Qc Rc Sc Tc Uc Vc Wc Xc Yc Zc Ad Bd Cd Dd Ed Fd Gd Hd Id Jd Kd Ld Md Nd Od Pd Qd Rd Sd Td Ud
#do
#	str02=${str02}"|"${i}
#	{ time ./oabe_keygen -s CP  -i "$str02"  -o studentACP$i.key 2>> sleep.stderr ; } 2>> rsaencrypttime.txt
#done

##解密
#str03="aa"
#{ time ./oabe_dec -s CP -k studentACP$str03.key -i rsa_public_key_abeencry$str03.cpabe -o rsa_public_key_abedecrypt$str03.pem 1024 2>> sleep.stderr ; } 2>> rsaencrypttime.txt
#echo decrypublic >> rsaencrypttime.txt
#for i in Aa Ba Ca Da Ea Fa Ga Ha Ia Ja Ka La Ma Na Oa Pa Qa Ra Sa Ta Ua Va Wa Xa Ya Za Ab Bb Cb Db Eb Fb Gb Hb Ib Jb Kb Lb Mb Nb Ob Pb Qb Rb Sb Tb Ub Vb Wb Xb Yb Zb Ac Bc Cc Dc Ec Fc Gc Hc Ic Jc Kc Lc Mc Nc Oc Pc Qc Rc Sc Tc Uc Vc Wc Xc Yc Zc Ad Bd Cd Dd Ed Fd Gd Hd Id Jd Kd Ld Md Nd Od Pd Qd Rd Sd Td Ud
#do

#{ time ./oabe_dec -s CP -k studentACP$i.key -i rsa_public_key_abeencry$i.cpabe -o rsa_public_key_abedecrypt$i.pem	 2>> sleep.stderr ; } 2>> rsaencrypttime.txt
#done




#用公钥对明文加密(用户加密后将密文发送给）  
#for i in Aa Ba Ca Da Ea Fa Ga Ha Ia Ja Ka La Ma Na Oa Pa Qa Ra Sa Ta Ua Va Wa Xa Ya Za Ab Bb Cb Db Eb Fb Gb Hb Ib Jb Kb Lb Mb Nb Ob Pb Qb Rb Sb Tb Ub Vb Wb Xb Yb Zb Ac Bc Cc Dc Ec Fc Gc Hc Ic Jc Kc Lc Mc Nc Oc Pc Qc Rc Sc Tc Uc Vc Wc Xc Yc Zc Ad Bd Cd Dd Ed Fd Gd Hd Id Jd Kd Ld Md Nd Od Pd Qd Rd Sd Td Ud
#do
#echo encryplaintxtwithpublic >> rsaencrypttime.txt
#{ time openssl rsautl -encrypt -in input.txt -inkey rsa_public_key_abedecrypt$i.pem -pubin -out input_encrypt$i.txt 2>> sleep.stderr ; } 2>> rsaencrypttime.txt
#私钥解密
#echo decrywithprivate >> rsaencrypttime.txt
#{ time openssl rsautl -decrypt -in input_encrypt$i.txt -inkey rsa_private_key$i.pem -out input_decrypt$i.txt 2>> sleep.stderr ; } 2>> rsaencrypttime.txt

#done
#done

#done





