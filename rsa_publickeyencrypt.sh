#!/bin/bash 

#Generate the private key
openssl genrsa -out rsa_private_key.pem 1024

#Generate the public key	
openssl rsa -in rsa_private_key.pem -pubout -out rsa_public_key.pem

#Encrypt the public key by Abe encryption
./oabe_setup -s CP
./oabe_enc -s CP -e "(Teacher or AuthorizedStudent or Specialist)"  -i rsa_public_key.pem -o rsa_public_key_abeencrypt.cpabe  

#Generate the Abe's key 
./oabe_keygen -s CP  -i "AuthorizedStudent"  -o studentACP.key

#Decrypt by Abe's key to obtain public key
./oabe_dec -s CP -k studentACP.key -i rsa_public_key_abeencrypt.cpabe -o rsa_public_key_abedecrypt.pem 

#Encrypt plaintext by public key
openssl rsautl -encrypt -in input.txt -inkey rsa_public_key_abedecrypt.pem -pubin -out input_encrypt.txt

#Decrypt ciphertext by private key
openssl rsautl -decrypt -in input_encrypt.txt -inkey rsa_private_key.pem -out input_decrypt.txt




