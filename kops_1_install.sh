# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# kubectl version
kubectl version

#############################################################
# kops install
curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops
sudo mv kops /usr/local/bin/kops

# aws cli util
sudo apt install awscli

# 확인
aws

# AWS/IAM/ADD USER/ADMINISTRATOR ACCESS 부여 -> 액세스 키 생성
# Key ID / Access Key / 리전:ap-northeast-2
aws configure

# 확인
ls -alh ~/.aws/

# AWS/S3/new bucket
이름: kops-state-kyu1
리전:ap-northeast-2

# AWS/Route53
# 도메인 등록->호스팅 영역 자동 생성 -> 네임서버 확인(DNS의 일부로, 도메인과 실제 서버 IP 주소 간의 매핑)

# 로그인 위해 ssh key 생성
ssh-keygen -t rsa -b 2048 -f ~/.ssh/test_key

# kubernetes 클러스터 생성
export NAME=kkyuu.com
export REGION="ap-northeast-2a"
export KOPS_STATE_STORE="s3://kops-state-kyu1"
export NODE_SIZE="t2.medium"

kops create cluster \
  --name=$NAME \
  --state=$KOPS_STATE_STORE \
  --zones=$REGION \
  --node-count=2 \
  --node-size=$NODE_SIZE \
  --control-plane-size=$NODE_SIZE \
  --dns-zone=$NAME

# 확인
kops --help
kops get cluster --name=$NAME --state=$KOPS_STATE_STORE
kops get cluster --name=$NAME -o yaml

# 설정 편집
kops edit cluster --name=$NAME --state=$KOPS_STATE_STORE

# 실행
kops update cluster --name=$NAME --state=$KOPS_STATE_STORE --yes

    Cluster is starting.  It should be ready in a few minutes.

    Suggestions:
    * validate cluster: kops validate cluster --wait 10m
    * list nodes: kubectl get nodes --show-labels
    * ssh to a control-plane node: ssh -i ~/.ssh/id_rsa ubuntu@api.kkyuu.com
    * the ubuntu user is specific to Ubuntu. If not using Ubuntu please use the appropriate user based on your OS.

# 확인
cat ~/.kube/config

# 실행 확인(실패)
kops validate cluster --name=$NAME

# 노드 확인(실패)
kubectl get node

# kubectl 현재 설정된 컨텍스트 확인
kubectl config view

# kubectl에 동기화
kops export kubecfg --name=$NAME --state=$KOPS_STATE_STORE --admin

# 실행 확인(성공)
kops validate cluster --name=$NAME

# 노드 확인(성공)
kubectl get node

#############################################################
# 배포
kubectl create deployment hello-minikube --image=kicbase/echo-server:1.0

# 배포확인
kubectl get deployments

# 배포 상세확인
kubectl describe deployment hello-minikube

# 배포삭제
kubectl delete deployment <배포 이름>

# 노드포트로 노출
kubectl expose deployment hello-minikube --type=NodePort --port=8080

# 서비스 리스트 확인
kubectl get services

# 서비스 확인
minikube service <서비스 이름>

    NAME                 TYPE            CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
    hello-minikube   NodePort    {cluster IPv4}   <none>            8080:31938/TCP   5s

# ec2 인스턴스 오토 스케일링 그룹 확인
# ec2 인스턴스의 인바운드 규칙 편집:31938포트
이후 공인IP:31938 포트로 접속. 어차피 같은 보안그룹을 사용하기 때문에 둘다 적용됨.

# 클러스터 삭제
kops delete cluster --name=$NAME # 삭제대상 확인
kops delete cluster --name=$NAME --state=$KOPS_STATE_STORE --yes