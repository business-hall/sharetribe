source /etc/profile.d/rvm.sh
cfgSrcDir=/extvol/sharetribe/config
if test -d $cfgSrcDir; then
  cfgDstDir=/opt/app/config
  for f in `ls ${cfgSrcDir}`;
  do
    dst=${cfgDstDir}/${f}
    if test -f ${dst}; then
      echo "Removing ${dst}"
      rm ${dst}
    fi
    src=${cfgSrcDir}/${f}  
    echo "Copying ${src} to ${dst}"
    cp ${src} ${dst}
  done
else
  echo "WARNING: Configuration directory ${cfgSrcDir} is missing"
fi
nginx -t
if test $? -ne 0; then
  echo "ERROR: NGINX config check failed. Double check !"
  exit 1
fi
extPubDir=/extvol/sharetribe/public
intPubDir=/opt/app/public
builtPubDir=/opt/app/private
if test ! -d ${extPubDir}/system/paypal; then
  echo "Public dir ${extPubDir} uninitialized. Fixing .."
  if test -L ${intPubDir}; then
    rm ${intPubDir}
  fi
  if test -d ${intPubDir}; then
    rm -rf ${intPubDir}
  fi
  mkdir -p ${extPubDir}/system/paypal
  cp -R ${builtPubDir}/* ${extPubDir}/
  chmod -R 777 ${extPubDir}
  ln -s ${extPubDir} ${intPubDir}
fi  
sphinxConf=/extvol/sphinx/production/sphinx.conf
if test ! -f /extvol/dbCreated; then
  echo "Creating database"
  if test -f ${sphinxConf}; then
    rm ${sphinxConf}
  fi
  DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rake db:create db:structure:load
  if test $? -ne 0; then
    exit 1
  fi
  echo `date` > /extvol/dbCreated;
fi
if test ! -f ${sphinxConf}; then
  mkdir -p /extvol/sphinx/production/log
  bundle exec rake ts:configure
fi  
/usr/bin/supervisord --configuration /sharetribe/etc/supervisord.conf
