echo "Configurando contenedor FTP"
if ! [ `id -u $PROFTPD_USER 2>/dev/null || echo -1` -ge 0 ]; then 
    echo "Creando usuario $PROFTPD_USER"
    adduser -h /ftp -s /bin/false -H -u 82 -D -G $PROFTPD_USER ftp
fi
echo "$PROFTPD_USER:$PROFTPD_PASSWORD" | chpasswd
chown -R $PROFTPD_USER:$PROFTPD_USER /ftp
/usr/local/sbin/proftpd -n -c /usr/local/etc/proftpd.conf
