System Requiremts:
==================
Ubuntu : 20.x
Master : 2Cpus => t2.medium
Workernode: 1Cpu => t2.micro (free)

Step 1:  update the system 
sudo apt update

Step 2: Installation and enable docker 

sudo apt install docker.io
sudo systemctl enable docker
sudo systemctl start docker

Step 3: adding packages and installation of kubernetes 

sudo apt install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

Step 4: once you installed kubernetes then update your system
sudo apt update

Step 5 : Install kubelet ,kubeadm and kubectl tools 
sudo apt install -y kubelet kubeadm kubectl

Step 6 : Disable Swap memory

swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

Step 7 : Initiate cluster in master ( we will get two 1) join and 2) config)
sudo kubeadm init

Note: make sure join command saved into secure location and execute them in workernode 

Step 8 : Execute the congfig in master 
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

Step 9: Execute below command for components status 
kubectl get pods --all-namespaces


Step 10 : Install Weaveworks package for networking 
#You will notice from the previous command, that all the pods are running except one: ‘kube-dns’. For resolving this we will install a # pod network. To install the weave pod network, run the following command:
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

Step 11: Execute below command for component status 
kubectl get pods --all-namespaces

Step 12 : execute join command in workernoder

Step 13: Check the nodes status 
kubectl get nodes 
