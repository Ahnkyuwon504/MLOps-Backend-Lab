# 하나의 노드지만 가능
kubectl get nodes

cat deployment/helloworld-nodeselector.yml
    hardware: high-spec

# 노드 레이블 확인
kubectl get nodes --show-labels

# 일단 생성
kubectl create -f deployment/helloworld-nodeselector.yml

# 확인
kubectl get deployments
kubectl get pods
kubectl describe

# 레이블 추가
kubectl label nodes minikube hardware=high-spec

# 확인
kubectl get node --show-labels

# 잠시 대기 후 확인
kubectl get pods