# Todos los PC

# para quee no pida ms el passwor
echo "%sudo   ALL=(ALL:ALL) NOPASSWD:  ALL" | sudo tee /etc/sudoers.d/99-nopass

#actualizar todo
sudo apt update
yes | sudo apt dist-upgrade  

#instalar R
echo "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/" | sudo tee /etc/apt/sources.list.d/R.list
yes | sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
yes | sudo add-apt-repository ppa:marutter/c2d4u3.5
sudo apt update
yes | sudo apt install r-base r-base-dev r-cran-tidyverse r-cran-ranger r-cran-randomforest r-cran-rjava r-cran-data.table 
yes | sudo apt install r-cran-rcurl r-cran-feather r-cran-tictoc r-cran-rattle r-cran-ssh r-cran-future
sudo R -e "install.packages('h2o')"


# conectar blob storage
wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
yes | sudo apt-get install blobfuse

# configurar login a blob
# debe configurarse el script
sudo touch  /etc/fuse_connection.cfg
sudo chmod 600 /etc/fuse_connection.cfg
echo "accountName danielfm123" | sudo tee /etc/fuse_connection.cfg
echo "accountKey C61dA+6V8w/DAjJcIW+lVB+mH5DSzUY7RVWJ6GPXYkTyrNy7eke4nRvw7TzHxuSobjQL7wQRh7DX2hqp3nCMBg==" | sudo tee -a /etc/fuse_connection.cfg
echo "containerName technights" | sudo tee -a /etc/fuse_connection.cfg

# montar blob
sudo mkdir /media/blob

#one shot:
# sudo blobfuse /media/blob --tmp-path=/mnt/  --config-file=/etc/fuse_connection.cfg -o attr_timeout=240 -o entry_timeout=240 -o negative_timeout=120 -o allow_other

#en fstab poner:
echo "blobfuse /media/blob fuse --tmp-path=/mnt/,--config-file=/etc/fuse_connection.cfg,attr_timeout=240,entry_timeout=240,negative_timeout=120,allow_other,_netdev 0 0" | sudo tee -a /etc/fstab
sudo mount /media/blob

# PC MAESTRO

#instalar rstudio
wget https://download2.rstudio.org/server/trusty/amd64/rstudio-server-1.2.1335-amd64.deb
yes | sudo apt install ./rstudio-server-1.2.1335-amd64.deb
sudo systemctl start rstudio-server
sudo systemctl enable rstudio-server

#azure cli
curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt update
yes | sudo apt install azure-cli

# configurar login
az login
