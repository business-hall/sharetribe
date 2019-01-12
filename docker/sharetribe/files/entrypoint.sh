source /etc/profile.d/rvm.sh
srcBaseDir=/extvol/sharetribe/config
dstBaseDir=/opt/app/config
for f in config.defaults config gmaps_api_key secrets;
do
  src=${srcBaseDir}/${f}.yml
  if test -f ${src}; then
    dst=${dstBaseDir}/${f}.yml
    if test -f ${dst}; then
      echo "Removing ${dst}"
      rm ${dst}
    fi
    echo "Copying ${src} to ${dst}"
    cp ${src} ${dst}
  fi
done
/usr/bin/supervisord --configuration /sharetribe/etc/supervisord.conf
