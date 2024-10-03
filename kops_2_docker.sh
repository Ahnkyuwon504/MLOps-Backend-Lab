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

# pod에 접근하기 위해 포트포워딩
kubectl port-forward {pod name} 8081:3000


