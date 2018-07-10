# utils
A collection of various EC2 utilities packaged as an RPM

## Requirements
This package is only designed to work with
[Amazon Linux 2](https://aws.amazon.com/amazon-linux-2/) and thus may not work
on other operating systems.

## Usage
1. Grab the [latest RPM](https://github.com/AlexChesters/utils/releases/latest)
from GitHub
1. Install it - `yum install -y ./alexchesters-utils.rpm`

Then you can use any of the provided utilities that are listed below.

### [`dns-register`](./src/dns-register)
Utility package to allow you to easily create a Route 53 Record Set pointing at
an IP address.

Usage: `dns-register <IP_ADDRESS> <DNS_NAME> <HOSTED_ZONE_ID> <TTL = 120>` 
