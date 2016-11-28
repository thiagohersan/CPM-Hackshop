#!/bin/sh

pythonpid=`ps | grep -v awk | awk '/SimpleHTTPServer/{print $1}'`
kill -9 $pythonpid

python -m SimpleHTTPServer &
pythonpid=$!

cnt=0
while [ $cnt -lt 10 ]
do
  sudo tcpdump -i eth0 'port 80' -w out.cap &
  killpid=$!
  sleep 10
  sudo kill -9 $killpid
  mkdir tmpFlowDir && cd tmpFlowDir
  tcpflow -r ../out.cap
  mkdir data
  foremost -i * -o data
  cd data
  for t in {gif,png,jpg} 
  do
    if [ -d $t ]
    then
      cp $t/* ../../imgs/
    fi
  done

  cd ../../imgs
  rm ../index.html
  cp ../dump.html ../index.html

  for file in `ls -t *`
  do
    sed -i.bak 's/<!--- XXX --->/<img src='\''\/imgs\/'$file\''>\'$'\n    &/g' ../index.html
  done

  cd ..
  sudo rm -rf *.bak tmpFlowDir out.cap

  let cnt=cnt+1
  echo $cnt
done
