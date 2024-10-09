cat wordpress/wordpress-secrets.yml

# no volume
cat wordpress/wordpress-single-deployment-no-volumes.yml

# docker hub/wordpress 
https://hub.docker.com/_/wordpress

# 시크릿 생성
kubectl create -f wordpress/wordpress-secrets.yml
kubectl get secret

# 배포 생성
kubectl create -f wordpress/wordpress-single-deployment-no-volumes.yml
kubectl get deployment

# pod 1개
kubectl get pods
# container 2개
kubectl describe {pod name}

# 워드프레스 접근하기 위해 서비스 생성
kubectl create -f wordpress/wordpress-service.yml
minikube service wordpress-service --url

# (실패)
# 외부 접속을 위해 NodePort->로드밸런서 로 포트타입 변경
type: NodePort -> LoadBalancer
kubectl apply -f wordpress/wordpress-service.yml
    pending

# 외부IP 할당
minikube tunnel