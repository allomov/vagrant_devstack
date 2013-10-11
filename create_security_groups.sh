. "./etc/localrc" # load password and etc.

export OS_USERNAME=admin
export OS_PASSWORD=$ADMIN_PASSWORD
export OS_TENANT_NAME=demo
export OS_AUTH_URL=http://192.168.27.100:5000/v2.0

nova secgroup-add-rule default udp 68 68 0.0.0.0/0

nova secgroup-create ssh "SSH"
nova secgroup-add-rule ssh tcp 22 22 0.0.0.0/0
nova secgroup-add-rule ssh icmp -1 -1 0.0.0.0/0
nova secgroup-add-rule ssh udp 68 68 0.0.0.0/0

# All ports (from 1 to 65535) where the source group is the current security group
# Port 22 from source 0.0.0.0/0 (CIDR): Used for inbound SSH access
# Port 53 from source 0.0.0.0/0 (CIDR): Used for inbound DNS requests
# Port 4222 from source 0.0.0.0/0 (CIDR): Used by NATS
# Port 6868 from source 0.0.0.0/0 (CIDR): Used by BOSH Agent
# Port 25250 from source 0.0.0.0/0 (CIDR): Used by BOSH Blobstore
# Port 25555 from source 0.0.0.0/0 (CIDR): Used by BOSH Director
# Port 25777 from source 0.0.0.0/0 (CIDR): Used by BOSH Registry

nova secgroup-create bosh "BOSH"
nova secgroup-add-group-rule bosh bosh tcp 1 65535 
nova secgroup-add-rule bosh tcp 4222 4222 0.0.0.0/0
nova secgroup-add-rule bosh tcp 6868 6868 0.0.0.0/0
nova secgroup-add-rule bosh tcp 25250 25250 0.0.0.0/0
nova secgroup-add-rule bosh tcp 25555 25555 0.0.0.0/0
nova secgroup-add-rule bosh tcp 25777 25777 0.0.0.0/0
nova secgroup-add-rule bosh tcp 53 53 0.0.0.0/0
nova secgroup-add-rule bosh udp 53 53 0.0.0.0/0
nova secgroup-add-rule bosh udp 68 68 0.0.0.0/0


nova secgroup-create cf-public "cf-public"
nova secgroup-add-rule cf-public tcp 80 80 0.0.0.0/0
nova secgroup-add-rule cf-public tcp 443 443 0.0.0.0/0
nova secgroup-add-rule cf-public udp 68 68 0.0.0.0/0


nova secgroup-create cf-private "cf-private"
nova secgroup-add-group-rule cf-private cf-private tcp 1 65535 
nova secgroup-add-rule cf-private tcp 1 65535 0.0.0.0/0 # https://groups.google.com/a/cloudfoundry.org/d/msg/bosh-users/dt4lNWDHGBA/vLevuUqtpiIJ
nova secgroup-add-rule cf-private udp 68 68 0.0.0.0/0

