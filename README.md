# utils
A collection of various utilities packaged as an RPM

### [`dns-register`](./src/dns-register)
Utility package to allow you to easily create a Route 53 Record Set pointing at
an IP address.

Usage: `dns-register <IP_ADDRESS> <DNS_NAME> <HOSTED_ZONE_ID> <TTL = 120>` 
