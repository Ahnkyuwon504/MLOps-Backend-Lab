# 설치
sudo apt-get install docker.io

# clone
git clone https://github.com/wardviaene/docker-demo.git

# 권한
sudo usermod -G docker ubuntu

# 빌드
docker build .

# 컨테이너 구동
docker run -p 3000:3000 -it {image ID}

# 확인
curl localhost:3000

# dockerhub
docker login -u {dockerHUB id}

# tag
docker tag {image ID} {dockerHUB ID}:{dockerHUB repo}

####################################################################

# clone
git clone https://github.com/wardviaene/kubernetes-course.git

# 쿠버네티스API서버 실행 && 확인
minikube start
kubectl get node

# 파드를 만드는 데 사용할 yml
cat first-app/helloworld.yml

# 파드 생성 && 확인
kubectl create -f first-app/helloworld.yml
kubectl get pod
# pod 컨테이너 정보 확인
kubectl describe pod {pod name}

# pod에 접근하기 위해 포트포워딩(로컬)
kubectl port-forward {pod name} 8081:3000

# 쉘
curl localhost:8081

# 서비스 생성해서 클러스터 외부로 포트 노출
# k8s에서 3000에 직접 액세스
kubectl expose pod {pod name} \
--type=NodePort \
--name nodehelloworld-service

# 클러스터 내의 URL
minikube service nodehelloworld-service --url

# 확인
kubectl get service

### useful command

# logging
kubectl attach nodehelloworld.example.com
# exec
kubectl exec nodehelloworld.example.com -- ls /app
# 파드 종료시 삭제될 파일 생성. 싫으면 볼륨을 사용해야함
kubectl exec nodehelloworld.example.com -- touch /app/test.txt
# 서비스 확인
kubectl get service
kubectl describe service nodehelloworld-service
    Endpoints: 10.244.0.3:3000 # 엔드포인트 확인

# 같은 파드가 아닌 클러스터 내에서 파드에 연결
# busybox 이미지로 다른 파드 시작
kubectl run -i --tty busybox --image=busybox --restart=Never -- sh
# 위 서비스의 엔드포인트로 연결
# curl이 없으니 telnet
telnet 10.244.0.3 3000
GET /
    200 OK