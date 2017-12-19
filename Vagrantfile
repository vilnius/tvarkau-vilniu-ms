$script = <<SCRIPT
export DEBIAN_FRONTEND=noninteractive

# Fix locale
echo "
export LANGUAGE=en_US.utf8
export LANG=en_US.utf8
export LC_ALL=en_US.utf8
">>~/.bashrc

# Use local mirror
sudo sed -i 's%archive.ubuntu.com%ubuntu.mirror.vu.lt%' /etc/apt/sources.list
sudo apt-get update -qq
sudo apt-get upgrade -y

# Pre-requisites
sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  software-properties-common \
  git-core \
  curl \
  zlib1g-dev \
  build-essential \
  libssl-dev \
  libreadline-dev \
  libyaml-dev \
  libxml2-dev \
  libxslt1-dev \
  libcurl4-openssl-dev \
  python-software-properties \
  libffi-dev \
  libpq-dev \
  cmake \
  pkg-config

# Node.js
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y \
  nodejs

# docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
sudo apt-get update -qq
sudo apt-get install -y \
  docker-ce
sudo groupadd docker
sudo usermod -aG docker ubuntu
sudo systemctl enable docker

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Ruby (rbenv)
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"'               >> ~/.bashrc
source ~/.bashrc
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
sudo -H -u ubuntu bash -i -c 'rbenv install 2.4.3'
sudo -H -u ubuntu bash -i -c 'rbenv rehash'
sudo -H -u ubuntu bash -i -c 'rbenv global 2.4.3'
sudo -H -u ubuntu bash -i -c 'gem install bundler --no-ri --no-rdoc'
sudo -H -u ubuntu bash -i -c 'rbenv rehash'

# Change to /vagrant (mounted project dir) upon login
sudo -H -u ubuntu bash -i -c "echo 'cd /vagrant' >> ~/.bashrc"

echo 'DONE.'

SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 5432, host: 5432

  config.vm.provider "virtualbox" do |vb|
    vb.name = "tvarkau-dev-box"
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.provision :shell, privileged: false, inline: $script
end
