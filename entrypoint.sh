echo "Configurando contenedor FTP"
mkdir /var/log/proftpd/
touch /var/log/proftpd/sftp.log

if ! [ `id -u $PROFTPD_USER 2>/dev/null || echo -1` -ge 0 ]; then 
    echo "Creando usuario $PROFTPD_USER"
    adduser -h /ftp -s /bin/false -H -u 82 -D -G ftp $PROFTPD_USER
fi
echo "$PROFTPD_USER:$PROFTPD_PASSWORD" | chpasswd
chown -R $PROFTPD_USER:ftp /ftp
chmod -R 777 /ftp

echo "Generando llaves ssh"
mkdir -p /etc/ssh
ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
/usr/local/sbin/proftpd -n -c /etc/proftpd/proftpd.conf
