#/bin/bash
echo "Creating ROOT CA..."

sed "s/__PATH__/$(pwd | sed -e 's/\//\\\//g')/g" openssl.cnf.template > openssl.cnf

mkdir certs crl newcerts private
chmod 700 private
touch index.txt
if [ ! -f serial ]; then
   echo 1000 > serial
fi
openssl genrsa -out private/ca.key 4096
chmod 400 private/ca.key
if [ ! -f certs/ca.crt ]; then
   openssl req -config openssl.cnf -key private/ca.key -new -x509 -days 7300 -sha256 -extensions v3_ca -out certs/ca.crt
fi

cd intermediate
./createCa.sh
