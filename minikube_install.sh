# minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb

# minikube version
minikube version

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# kubectl version
kubectl version

# init
minikube start

# 생성된 구성 확인(인증서, 서버 등)
cat ~/.kube/config

# 쿠버네티스 API서버, 8443포트 사용, 마스터 노드
clusters:
- cluster:
    certificate-authority: /home/ubuntu/.minikube/ca.crt
    extensions:
    - extension:
        last-update: Mon, 30 Sep 2024 16:42:52 UTC
        provider: minikube.sigs.k8s.io
        version: v1.34.0
      name: cluster_info
    server: https://{IPv4}:8443
  name: minikube

# kubectl 이용해 서버에 연결
# 작동 여부 확인을 위한 에코서버를 사용해 배포
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

# 노드에서 실행 중인 파드로 32176포트 사용
|-----------|----------------|-------------|---------------------------|
| NAMESPACE |      NAME      | TARGET PORT |            URL            |
|-----------|----------------|-------------|---------------------------|
| default   | hello-minikube |        8080 | http://{IPv4}:32176 |
|-----------|----------------|-------------|---------------------------|

# 서비스 삭제
kubectl delete service <서비스 이름>

# 에코서버에 요청
curl http://{IPv4}:32176

# exit
minikube stop

# delete vm
minikube delete