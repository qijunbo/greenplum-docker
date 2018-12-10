#!/bin/bash
sudo /usr/sbin/sshd

m="master"
if [ "$GP_NODE" == "$m" ]

then
     echo 'Node type='$GP_NODE
    if [ ! -d $MASTER_DATA_DIRECTORY ]; then
        echo 'Master directory does not exist. Initializing master from gpinitsystem_reflect.'
        #yes | cp $HOSTFILE hostlist  # 这一步就不要了, 采用-v参数从外面映射更合适, 这样镜像就不必要重新打包了.
        gpssh-exkeys -f hostlist
        echo "Key exchange complete"
        gpinitsystem -a  -c gpinitsys -s db_standby --su_password=sunway123###
        echo "Master node initialized"
        # receive connection from anywhere.. This should be changed!!
        echo "host all all 0.0.0.0/0 md5" >>/var/lib/gpdb/data/gpmaster/gpsne-1/pg_hba.conf
        gpstop -u
    else
        echo 'Master exists. Restarting gpdb.'
        gpstart -a
    fi
else
    echo 'Node type='$GP_NODE
fi
exec "$@"
