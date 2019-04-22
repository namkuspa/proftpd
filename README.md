# Proftpd

Servidor FTP o SFTP (con posibilidad de compresion usando `zlib`) basado en `proftpd` y `libressl` bajo `alpine 3.8` para un bajo tamaño de imagen.

## Ejecutar

```console
$ docker run -it --rm -p 2222:22 -v /host/ftp:/ftp namkuspa/proftpd
Configurando contenedor FTP
chpasswd: password for 'ftp' changed
Generando llaves ssh
Generating public/private rsa key pair.
Your identification has been saved in /etc/ssh/ssh_host_rsa_key.
Your public key has been saved in /etc/ssh/ssh_host_rsa_key.pub.
The key fingerprint is:
SHA256:XXXX
The key's randomart image is:
+---[RSA 2048]----+
...
+----[SHA256]-----+
Generating public/private dsa key pair.
Your identification has been saved in /etc/ssh/ssh_host_dsa_key.
Your public key has been saved in /etc/ssh/ssh_host_dsa_key.pub.
The key fingerprint is:
SHA256:XXXX
The key's randomart image is:
+---[DSA 1024]----+
...
+----[SHA256]-----+
2019-04-22 22:38:01,994 6b27707b540c proftpd[17]: processing configuration directory '/etc/proftpd/conf'
2019-04-22 22:38:02,001 6b27707b540c proftpd[17] 6b27707b540c: ProFTPD 1.3.6 (stable) (built Mon Apr 22 2019 22:37:23 UTC) standalone mode STARTUP
```
## Puertos
*  SFTP: 22
*  FTP: 21, 60000-60100

## Deshabilitar SFTP

Si se desea usar solo FTP se debe montar un volumen que sobreescriba el archivo `sftp.conf` ubicado en `/etc/proftpd/conf/sftp.conf`.

## Variables de entorno

| Variable         | Valor por defecto | Descripcion                             |
| ---------------- | ----------------- | --------------------------------------- |
| PROFTPD_USER     | ftp               | Nombre de usuario del servidor ftp      |
| PROFTPD_PASSWORD | ftp               | Contraseña para acceder al servidor ftp |

## TODO
* Posibilidad de deshabilitar SFTP por variable de entorno
* Soportar configuracion usando `docker secrets` (`PROFTPD_USER_FILE` y `PROFTPD_PASSWORD_FILE`)
* Soportar multiples usuarios