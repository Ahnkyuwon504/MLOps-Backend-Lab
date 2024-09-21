### run redis container

- 이미지 다운로드
docker pull redis

- Redis 컨테이너 실행
docker run -d --name redis-server -p 6379:6379 redis

### python

- python
redis-connect.py

### 종료

- Redis 컨테이너 종료
docker rm redis-server