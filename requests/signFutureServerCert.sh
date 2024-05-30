#/bin/bash
if [ $# -ne 1 ]; then
  echo "Usage: ./signClientCert.sh <certName>"
  exit 1
fi

mkdir -p ${1}-req/certs
cd ${1}-req
tar zxf ../$1.tgz

../createCnf.sh server $1
openssl ca -config csr/$1.cnf -extensions server_cert -startdate 440101010101Z -enddate 440201010101Z -md sha256 -in csr/$1.csr -out certs/$1.crt
openssl x509 -noout -text -in certs/$1.crt
cat certs/$1.crt ../../intermediate/certs/ca.crt > certs/${1}-chain.pem
tar zcf ../${1}-signed.tgz certs/$1*
cd ..
