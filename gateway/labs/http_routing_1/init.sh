#!/bin/bash
#
# We are going to use SSL Termination or SSL offloading, which means that you are performing all encryption and decryption at the edge of your network, such as at the load balancer.
#
# Benefits:
#
# - You can maintain certificates in fewer places, making your job easier.
# - You don't need to expose your servers to the Internet for certificate renewal purposes.
# - Servers are unburdened from the task of processing encrypted messages, freeing up CPU time.

test -d ./certs && rm -rf ./certs

mkdir certs

echo "subjectAltName = DNS:secure.haproxy.myhouse,IP:192.168.56.30,IP:127.0.0.1" >> ./certs/extfile.conf

# Generate private key
openssl genpkey -out ./certs/key.pem -outform PEM -algorithm RSA -pkeyopt rsa_keygen_bits:4096 -pass file:./passphrase.txt

# Generate the CSR from the private key to generate the certificate
openssl req -new -key ./certs/key.pem -out ./certs/csr.pem -passin file:./passphrase.txt -subj "/C=ES/ST=Galicia/L=Ourense/O=MyHouse/OU=org/CN=localhost"

# Generate the certificate from the private key and the CSR
openssl x509 -req -key ./certs/key.pem -in ./certs/csr.pem -out ./certs/cert.pem -sha256 -days 365 -extfile ./certs/extfile.conf -passin file:./passphrase.txt

# Displaying the information about the certificate
openssl x509 -in ./certs/cert.pem -noout -text

# Append cert and private key in one pem file
# Reference: https://stackoverflow.com/questions/27947982/haproxy-unable-to-load-ssl-private-key-from-pem-file
cat ./certs/cert.pem ./certs/key.pem > ./certs/cert_key.pem

# Running docker containers
# docker-compose up --detach
