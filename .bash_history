sudo apt update && sudo apt upgrade -y
sudo apt install -y unzip curl
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version
curl -sS https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz -o eksctl.tar.gz
tar -xzf eksctl.tar.gz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
curl -sS https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz -o eksctl.tar.gz
tar -xzf eksctl.tar.gz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
curl --silent --location "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$(uname -s | tr '[:upper:]' '[:lower:]')_amd64.tar.gz" -o eksctl.tar.gz
tar -xzf eksctl.tar.gz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version
curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
kubectl version --client
curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
VERSION=$(curl -s https://dl.k8s.io/release/stable.txt)
curl -LO "https://dl.k8s.io/release/${VERSION}/bin/linux/amd64/kubectl"
VERSION=$(curl -s https://dl.k8s.io/release/stable.txt)
curl -LO "https://dl.k8s.io/release/${VERSION}/bin/linux/amd64/kubectl"
VERSION=$(curl -s https://dl.k8s.io/release/stable.txt)
curl -L "https://dl.k8s.io/release/${VERSION}/bin/linux/amd64/kubectl" -o kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
kubectl version --client
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
kubectl version --client
sudo apt-get install -y kubectl
sudo mkdir -p /usr/share/keyrings
curl -fsSLo kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
sudo mv kubernetes-archive-keyring.gpg /usr/share/keyrings/
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
set -euo pipefail
# --- 0. עדכון והתקנות דרושות ---
sudo apt-get update
eksctl get cluster
aws configure
eksctl get cluster
aws configure
eksctl get cluster
eksctl delete cluster --name my-amazingcluster --region us-east-1
eksctl delete cluster --name my-amazing-cluster --region us-east-1
ls
vim cluster-advanced.yaml 
eksctl delete cluster --name my-cluster --region us-east-1
eksctl version
which eksctl
file /usr/local/bin/eksctl
eksctl version
kubectl version --client --short
kubectlx version --client --short
sudo snap install kubectl --classic
kubectl version --client --short
kubectl version --client
snap version
aws --version
kubectl version --client --short
kubectl version --client 
which eksctl
which kubectl
which aws
aws sts get-caller-identity
aws configure
aws sts get-caller-identity
eksctl create cluster   --name my-cluster   --region us-east-1   --nodes 2   --node-type t3.medium   --managed
2025-09-09 15:08:40 [ℹ]  using Kubernetes version 1.32 use "" [AmazonLinux2023/1.32]
2025-09-09 15:08:40 [ℹ]  using Kubernetes version 1.32
ls
cd aws
ls
cd ..
ls
cd snap/
ls
cd kubectl/
ls
cd ..
ls
vim aws
ls
cd aws
ls
cd
kubectl get nodes
pwd
ls
vim cluster
vim cluster-advanced.yaml
eksctl create cluster -f cluster-advanced.yaml
vim cluster-advanced.yaml
eksctl create cluster -f cluster-advanced.yaml
sudo apt install git
git add .
git init
git add .
git status
git commit "first
ךד
ls
mkdir eksctlDir
mv * eksctlDir/
mv * eksctlDir
pwd
ls
cd eksctlDir/
ls
pwd
ls
git status
git add .
git status
git reset
git status
git reset --soft HEAD~1
ls
vim gitignore
git status
git add .
git status
rm -rf .git  
git init  
git status
ls
rm gitignore 
ls
cd ~/eksctlDir
rm -rf .git        # מוחק את הגדרות ה־git שהתחלת כאן
git init           # יוצר repo חדש בתיקייה הנוכחית בלבד
git status
git add .
git commit -m "Initial commit with eksctl and cluster config"
git remote add origin https://github.com/Eliz007/DevOpsFinalWorkshop.git
git push origin HEAD:itai
git branch
git remote -v
git checkout -b itai
git branch
git push itai HEAD:itai
git status
git add .
git commit -m "Add my changes to itai branch"
git init
git add .
ls
git branch
cd ..
git init
git add .
git commit -m "Add my changes to itai branch"
git remote add origin https://github.com/Eliz007/DevOpsFinalWorkshop/itai.git
git remote set origin https://github.com/Eliz007/DevOpsFinalWorkshop/itai.git
git remote set-url origin https://github.com/Eliz007/DevOpsFinalWorkshop/itai.git
git push -u origin itai
git remote set origin https://github.com/Eliz007/itai.git
git remote set-url origin https://github.com/Eliz007/itai.git
git push -u origin itai
git remote set-url origin https://github.com/Eliz007/DevOpsFinalWorkshop.git
git push -u origin itai
git pull origin itai --rebase
git push origin itai
git push --force origin itai
git remote -v
git branch
ls
pwd
cd eksctlDir/
ls
git branch
git pull origin itai --rebase
git push origin itai:itai
