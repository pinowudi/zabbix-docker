#!/bin/sh
dd if=/dev/urandom bs=1024 count=100 | md5sum | awk '{print $1}' > .MYSQL_PASSWORD
dd if=/dev/urandom bs=1024 count=101 | md5sum | awk '{print $1}' > .MYSQL_ROOT_PASSWORD
dd if=/dev/urandom bs=1024 count=102 | md5sum | awk '{print $1}' > .POSTGRES_PASSWORD
