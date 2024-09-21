### VS code

- .ssh

```
Host cpu
  HostName {public IPv4}
  User ubuntu
  IdentityFile ~/.ssh/key.pem
```

### 필수패키지 설치

- 패키지 리스트 업데이트

```
sudo apt-get update
```

- 필수 패키지 설치

```
sudo apt-get install \
  apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common
```

### git

- key

```
ssh-keygen -t rsa -b 2048 -f ~/.ssh/test_key
```

- ~/.ssh/config

```
Host github.com
     HostName github.com
     User git
     IdentityFile ~/.ssh/test_key
     IdentitiesOnly yes
     Port 22
```     

- git clone

```
git clone {repo}
```

### docker

- GPG key 추가

```
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
```

- docker 저장소 설정

```
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

- 패키지 리스트 다시 업데이트

```
sudo apt-get update
```

- docker 설치

```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose
```

- 현재 사용자를 docker그룹에 추가

```
sudo usermod -aG docker $USER
```

- 도커세션 새로고침

```
newgrp docker
```

- 확인

```
docker run hello-world
```

### python package

- pip 설치

```
sudo apt install python3-pip
```

- 가상환경 설치

```
sudo apt install python3-venv
```

- 가상환경 생성

```
python3 -m venv kyuenv
```

- 추출

```
pip freeze > requirements.txt
```

- 설치

```
pip install -r requirements.txt
```

### docker-compose

- 실행

```
docker-compose up -d
```

- error log확인

```
docker logs milvus-standalone
docker ps -a
```