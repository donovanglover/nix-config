SYSTEMD="/etc/systemd/system.conf"

# Change the default timeout from 90s to 10s, preventing the system from hanging at shutdown
echo "DefaultTimeoutStartSec=10s" >> $SYSTEMD
echo "DefaultTimeoutStopSec=10s" >> $SYSTEMD
