# AWS 로드밸런서: k8s의 파드로 트래픽 라우팅, 앱 액세스
# 혹은 haproxy/nginx
cat helloworld.yml
    app: helloworld # 파드의 서비스
    name: nodejs-port # 컨테이너의 포트
cat helloworld-service.yml # AWS 로드밸런서
    targetPort: nodejs-port # 타겟
    type: LoadBalancer

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

# 실행(5분 이상 소요)
kops update cluster --name=$NAME --state=$KOPS_STATE_STORE --yes

# kubectl에 동기화
kops export kubecfg --name=$NAME --state=$KOPS_STATE_STORE --admin

# 실행 확인(성공)
kops validate cluster --name=$NAME

# 노드 확인(성공)
kubectl get node 

# 파드
kubectl create -f helloworld.yml

# 서비스
kubectl create -f helloworld-service.yml
# aws console/ec2/Load Balancer 생성되었음

# DNS이름 copy
# aws route32/레코드 생성/alias/app LB+리전+LB선택
# 레코드 이름으로 앱 이동

# 로드밸런서에서 트래픽을 노드 중 하나로 리디렉션(80->노드의 인스턴스 포트)
# 트래픽을 파드로 리디렉션
# 따라서 인스턴스의 보안 그룹과는 관계 없음
# 로드밸런서에 매핑된 보안 그룹(elb 자동 생성)

kubectl delete service helloworld-service
kops delete cluster --name=$NAME # 삭제대상 확인
kops delete cluster --name=$NAME --state=$KOPS_STATE_STORE --yes