#!/bin/sh

if [ -z "$1" ] ; then
   LOCALBASE=/usr/local
else
   LOCALBASE="$1"
fi

if [ -d "${LOCALBASE}/share/operator" ] ; then
   rm -rf ${LOCALBASE}/share/operator
fi

mkdir -p ${LOCALBASE}/share/operator

# Copy backend / conf / doc
cp -r editor ${LOCALBASE}/share/operator

# Install the executable
if [ ! -d "${LOCALBASE}/bin" ] ; then
  mkdir ${LOCALBASE}/bin
fi

cp operator.py ${LOCALBASE}/bin/operator
chown root:operator ${LOCALBASE}/bin/operator

chmod 755 ${LOCALBASE}/bin/operator

sudoers=`cat /usr/local/etc/sudoers`

if echo "$sudoers" | grep -q "%operator";
then                        
  echo 'Already setup'
else
  sed -i "" '/# %wheel ALL=(ALL) NOPASSWD: ALL/a\
  %operator ALL=(ALL) NOPASSWD: /usr/local/bin/operator' ${LOCALBASE}/etc/sudoers
fi
