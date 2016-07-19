servers="
9.220.106.241
9.220.106.203
9.220.106.205
9.220.106.240
9.220.106.234
"
[ -f carootcert.pem ] || openssl x509 -inform der -in carootcert.der -out carootcert.pem
[ -f caintermediatecert.pem ] || openssl x509 -inform der -in caintermediatecert.der -out caintermediatecert.pem
for i in $servers
do
echo "-----------------------------------------------------------"
scp -i /home/nengyi/nengyi.key carootcert.pem nengyi@$i:/home/nengyi
scp -i /home/nengyi/nengyi.key caintermediatecert.pem nengyi@$i:/home/nengyi
ssh -tt -o StrictHostKeyChecking=no -i /home/nengyi/nengyi.key nengyi@$i "sudo su - root -c 'cat /home/nengyi/carootcert.pem >> /etc/pki/tls/certs/ca-bundle.crt && echo Added IBM CA Cert;cat /home/nengyi/caintermediatecert.pem >> /etc/pki/tls/certs/ca-bundle.crt && echo Added IBM CA Intermediate Cert'"
done
