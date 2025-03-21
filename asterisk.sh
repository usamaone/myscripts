#!/bin/bash

# Run the asterisk -r command and check if it says "not connected"
if asterisk -r | grep -q "not connected"; then
    echo "Asterisk is not connected. Fixing ownership and restarting..."
    
    # Change ownership of /var/run/asterisk/
    chown -R asterisk:asterisk /var/run/asterisk/
    
    # Restart the Asterisk service
    systemctl restart asterisk
    
    # Check the status of Asterisk
    systemctl status asterisk
    
    # Verify connectivity after restart
    if asterisk -r | grep -q "not connected"; then
        echo "Failed to connect to Asterisk after restart."
    else
        echo "Asterisk is now connected."
    fi
else
    echo "Asterisk is already connected."
fi
