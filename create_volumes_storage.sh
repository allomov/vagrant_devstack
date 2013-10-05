sudo pvcreate /dev/sdb
sudo vgreduce stack-volumes /dev/loop0
sudo vgextend stack-volumes /dev/sdb

