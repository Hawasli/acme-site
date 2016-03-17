echo "[] Creating temporal certificate"
        mkdir $1
        echo $1
        cp ca/ca.crt $1/
        cp ca/ca.pem $1/
        sed "s/{{client_id}}/$1/g" client.cnf > $1/$1.cnf
        cd $1
        openssl req -new -config $1.cnf -keyout $1.key -out $1.req
        chmod 400 $1.key
        cd ..
        sign-temporal-certificate $1
echo "[] Signing temporal certificate"
        cp $1/$1.req ca/
        cd ca/
        openssl ca -batch -passin pass:acme -config ca-sign-temporal.cnf -out $1      .crt -in $1.req
        cd ..
        rm ca/$1.req
        rm $1/$1.req
        cp ca/$1.crt $1/
        openssl pkcs12 -export -out $1/$1.pfx -passout pass:acme -inkey $1/$1.ke      y -in $1/$1.crt
echo "1"
        zip $1.zip $1/*
        rm -r $1
