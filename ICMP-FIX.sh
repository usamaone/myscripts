#!/bin/bash
echo "===================================================="
echo "ICMP Redirection Enabled ==========>> Muhammad Usama"
echo "===================================================="

# Backup /etc/sysctl.conf with a timestamp
backup_file="/etc/sysctl.conf.backup_$(date +%Y%m%d_%H%M%S)"
echo "Backing up /etc/sysctl.conf to $backup_file..."
cp /etc/sysctl.conf "$backup_file"

# Uncomment the lines if they are commented
echo "Uncommenting ICMP redirection settings in /etc/sysctl.conf..."
sed -i '/^#net.ipv4.conf.all.accept_redirects=0/s/^#//' /etc/sysctl.conf
sed -i '/^#net.ipv4.conf.default.accept_redirects=0/s/^#//' /etc/sysctl.conf
sed -i '/^#net.ipv4.conf.all.secure_redirects=0/s/^#//' /etc/sysctl.conf
sed -i '/^#net.ipv4.conf.default.secure_redirects=0/s/^#//' /etc/sysctl.conf

# Disable ICMP redirection
echo "Disabling ICMP redirection..."
sysctl -w net.ipv4.conf.all.accept_redirects=0
sysctl -w net.ipv4.conf.default.accept_redirects=0
sysctl -w net.ipv4.conf.all.secure_redirects=0
sysctl -w net.ipv4.conf.default.secure_redirects=0

# Make the change permanent by modifying /etc/sysctl.conf (if not already present)
echo "Making changes permanent..."

# Add configuration to sysctl.conf if not already present
if ! grep -q "net.ipv4.conf.all.accept_redirects=0" /etc/sysctl.conf; then
    echo "net.ipv4.conf.all.accept_redirects=0" >> /etc/sysctl.conf
fi
if ! grep -q "net.ipv4.conf.default.accept_redirects=0" /etc/sysctl.conf; then
    echo "net.ipv4.conf.default.accept_redirects=0" >> /etc/sysctl.conf
fi
if ! grep -q "net.ipv4.conf.all.secure_redirects=0" /etc/sysctl.conf; then
    echo "net.ipv4.conf.all.secure_redirects=0" >> /etc/sysctl.conf
fi
if ! grep -q "net.ipv4.conf.default.secure_redirects=0" /etc/sysctl.conf; then
    echo "net.ipv4.conf.default.secure_redirects=0" >> /etc/sysctl.conf
fi

# Reload sysctl settings to apply the permanent change (suppress output)
sysctl -p

echo "ICMP redirection has been disabled successfully."
