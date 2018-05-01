#!/bin/bash
# Use Bash as default command
if [ $# -eq 0 ]; then
   /etc/init.d/mdns start
   /home/nmos-cpp/Development/build/nmos-cpp-registry \
   "{\"pri\": 100, \"logging_level\": -40, \"allow_invalid_resources\": true, \
   \"settings_port\": 3209, \"logging_port\": 5106, \"query_port\": 8870, \"query_ws_port\": 8871, \
   \"host_name\": \"nmos-onswitch-registry\", \"host_address\": \"0.0.0.0\", \
   \"registration_port\": 8235, \"node_port\": 8236, \"admin_port\": 3208, \"mdns_port\": 3214, \
   \"registration_expiry_interval\": 12, \"access_log\": \"logreg.txt\"}"

   exit $?  # Make sure we really exit
fi

# If we were given arguments, override the default configuration and run /bin/bash
if [ $# -gt 0 ]; then
   exec /bin/bash fi
   exit $?  # Make sure we really exit
fi
