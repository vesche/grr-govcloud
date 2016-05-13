# grr-govcloud
This is an install script for deploying [Google GRR](https://github.com/google/grr) along with [shellinabox](https://github.com/shellinabox/shellinabox) on [AWS GovCloud](https://aws.amazon.com/govcloud-us/). This is intended for conducting live, secure, and remote host-based forensics on sensitive networks during an incident response. Shellinabox (configured to communicate over ssl) is provided as a mechanism to interact with the GRR server securly in an environment where ssh is not available.

## Install
Requires Ubuntu 14.04 with Python 2.7.9+

```
git clone https://github.com/vesche/grr-govcloud
cd grr-govcloud
sudo bash install.sh
```

## Seurity Groups
Within GovCloud you will need to add a few security groups. Add the external IP that your team will be interacting with the server from to allow incoming traffic from port 443 and 8000. In addition, allow incoming traffic on port 80 from the external ip range of your client network.  

This will allow only your team to connect to shellinabox via `https://<external_ip>/shell`, the Google GRR admin interface via `http://<external_ip>:8000`, and allow your clients to communicate with your server using [encrypted HTTP POST requests](https://github.com/google/grr-doc/blob/master/implementation.adoc#client-communication-and-encryption).
