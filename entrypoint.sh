#!/bin/bash
# Use Bash as default command
if [ $# -eq 0 ]; then

# You should use either Avahi or Apple mDNS - DO NOT use both
#
# mDNSResponder 878.30.4
#   /etc/init.d/mdns start

# Avahi
   /etc/init.d/dbus start
   /etc/init.d/avahi-daemon start

# Start Sony Registry Application inside correct directory
   sleep 1
   /home/nmos-cpp-registry "{\"pri\": 100, \"logging_level\": -40, \
   \"allow_invalid_resources\": true, \"settings_port\": 3209, \
   \"logging_port\": 5106, \"query_port\": 8870, \
   \"query_ws_port\": 8871, \"registration_port\": 8235, \
   \"node_port\": 8236, \"admin_port\": 3208, \"mdns_port\": 3214, \
   \"registration_expiry_interval\": 12}" >/dev/null

   exit $?  # Make sure we really exit
fi

# If we were given arguments, override the default configuration and run /bin/bash
if [ $# -gt 0 ]; then
   exec /bin/bash fi
   exit $?  # Make sure we really exit
fi
