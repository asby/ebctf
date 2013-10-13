# Kill all existing socat processes
killall -9 socat

# Wait some time so that all sockets are closed
sleep 30

# Restart socat with nohup in background
nohup socat TCP4-LISTEN:51037,fork,tcpwrap=script EXEC:/home/knock/bin/knock.sh,su-d=knock,pty,stderr &
nohup socat TCP4-LISTEN:22222,fork,tcpwrap=script EXEC:/home/knock/bin/knockadvanced.sh,su-d=knock,pty,stderr &
nohup socat TCP4-LISTEN:32154,fork,tcpwrap=script EXEC:/home/knock/bin/key.sh,su-d=knock,pty,stderr &
