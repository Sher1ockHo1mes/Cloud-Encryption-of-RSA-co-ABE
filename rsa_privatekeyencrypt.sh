#!/bin/bash
#Generate the private key
openssl genrsa -out private.pem 1024

#Generate the public key
openssl rsa -in private.pem -pubout -out public.pem

#Encrypted by private key(you need to change the name of input file "input.txt" and output file)
openssl rsautl -sign -in input.txt -inkey private.pem -out input_enc.txt

#decrypted by public key(change the name of inputfile and output file)
openssl rsautl -verify -in input_enc.txt -inkey public.pem -pubin -out input_dec.txt


