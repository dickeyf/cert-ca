#/bin/bash
echo ""
echo "======================================"
echo "===== Creating intermediate CA... ===="
echo "======================================"
echo ""

sed "s/__PATH__/$(pwd | sed -e 's/\//\\\//g')/g" openssl.cnf.template > openssl.cnf

mkdir -p certs crl newcerts private csr
chmod 700 private
openssl genrsa -out private/ca.key 4096
chmod 400 private/ca.key

touch index.txt
if [ ! -f serial ]; then
  echo 1000 > serial
fi

if [ ! -f crlnumber ]; then
  echo 1000 > crlnumber
fi

if [ ! -f certs/ca.crt ]; then
  openssl req -config openssl.cnf -new -sha256 -key private/ca.key -out csr/ca.csr
  openssl ca -config ../openssl.cnf -extensions v3_intermediate_ca -days 3650 -notext -md sha256 -in csr/ca.csr -out certs/ca.crt
fi
