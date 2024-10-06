# 확인
kubectl get node

# 파드 생성
kubectl create -f first-app/helloworld.yml

# 확인
kubectl get pods
kubectl describe pod nodehelloworld.example.com
    Labels: app=helloworld

# 서비스 생성
kubectl create -f first-app/helloworld-nodeport-service.yml

# 확인
kubectl get service
minikube service helloworld-service --url
kubectl describe svc helloworld-service

# 삭제
kubectl delete svc helloworld-service