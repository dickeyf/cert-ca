#/bin/bash

if [ $# -eq 2 ]; then
  if [ -f csr/$2.san ]; then
    cat ../../intermediate/openssl.cnf ../$1.cnf > csr/$2.cnf
    echo "subjectAltName = @alt_names" >> csr/$2.cnf
    echo "[ alt_names ]" >> csr/$2.cnf
    cat csr/$2.san >> csr/$2.cnf
  else
    cat ../../intermediate/openssl.cnf ../$1.cnf > csr/$2.cnf
  fi
fi

if [ $# -eq 1 ]; then
  cat ../../intermediate/openssl.cnf ../$1.cnf > csr/$2.cnf
fi
