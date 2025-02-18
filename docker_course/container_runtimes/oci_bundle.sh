# create the top most bundle directory
mkdir /mycontainer
cd /mycontainer

# create the rootfs directory
mkdir rootfs

# export busybox via Docker into the rootfs directory
docker export $(docker create busybox) | tar -C rootfs -xvf -

# root filesystem is populated you just generate config.json spec
runc spec
# install jq 
sudo apt-get install jq -y
# update terminal handling
mv config.json bkp.config.json
jq '.process.terminal = false | .process.args = ["sleep", "5"]' bkp.config.json  > config.json