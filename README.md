# grr-govcloud
This is an install script for deploying [Google GRR](https://github.com/google/grr) along with [shellinabox](https://github.com/shellinabox/shellinabox) on [AWS GovCloud](https://aws.amazon.com/govcloud-us/). This is intended for conducting live, secure, and remote host-based forensics on sensitive networks during an incident response. Shellinabox (configured to communicate over ssl) is provided as a mechanism to interact with the GRR server securley in an environment where ssh is not available.

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

## Agent Deployment
Note that before deploying agents you will need to contact the HBSS administrator of the customer network to have the Google GRR client proccess whitelisted. This process can be named to suit your needs.

To download clients navigate to the admin interface and under **Manage Binaries** -> **executables** -> **Windows** -> **installers** and grab the client you require.

There are many security-related [agent protection](https://github.com/google/grr-doc/blob/master/admin.adoc#agent-protection) recommendations that would be wise to implement.

The Windows installer is a self-extracting executable which can be deployed easily using SCCM. If deployment requires an MSI format, see [here](http://grr-response.blogspot.com/2014/12/wrapping-grr-installers-as-msi-file.html).

## Post-install
Configuration of GRR post-install is left up to the administrator. The [Administrator Documentation](https://github.com/google/grr-doc/blob/master/admin.adoc) is very thorough.
