#!/bin/bash

project=$1
user=$2
password=$3
email=$4

home=`dirname $0`

cd $home

nova-manage user admin $user
nova-manage project create $project $user
rm nova.zip
nova-manage project zipfile $project $user
unzip nova.zip
. novarc

tools/with_venv.sh dashboard/manage.py syncdb --noinput
tools/with_venv.sh dashboard/manage.py createsuperuser --username=$user --email=$email --noinput
tools/with_venv.sh dashboard/change_password.py $user $password 

