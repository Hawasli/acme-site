echo "[] Generating CRL"
openssl ca -passin pass:acme -config ca-sign.cnf -gencrl -out crl.pem
