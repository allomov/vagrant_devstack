sudo pvcreate /dev/sdb
sudo vgextend stack-volumes /dev/sdb
sudo vgreduce stack-volumes /dev/loop0