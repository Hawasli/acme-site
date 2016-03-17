#!/bin/sh
cd wireless-pki
mkdir $1
sed "s/{{client_id}}/$1/g" temporal.cnf > $1/$1.cnf
openssl req -new  -out $1/$1.csr -keyout $1/$1.key -config $1/$1.cnf
openssl ca -batch -keyfile ca.key -cert ca.pem -in $1/$1.csr  -key acme -out $1/$1.crt -extensions xpclient_ext -extfile xpextensions -config $1/$1.cnf
openssl pkcs12 -export -in $1/$1.crt -inkey $1/$1.key -out $1/$1.p12  -passin pass:acme -passout pass:acme
openssl pkcs12 -in $1/$1.p12 -out $1/$1.pem -passin pass:acme -passout pass:acme
openssl pkcs12 -export -in $1/$1.crt -inkey $1/$1.key -certfile ca.pem -name $1 -out $1/$1.p12  -passin pass:acme -passout pass:acme
cp ca.pem $1
:q
:q






zip $1.zip $1/*
rm -r $1
cd ..
mv wireless-pki/$1.zip .
