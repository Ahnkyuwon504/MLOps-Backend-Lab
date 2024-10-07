cat deployment/helloworld-healthcheck.yml

# 배포 생성
kubectl create -f deployment/helloworld-healthcheck.yml

# 확인
kubectl get pods
kubectl describe pods {pod name}
    Liveness: http-get http://:nodejs-port/ delay=15s timeout=30s period=10s #success=1 #failure=3

# 오류시 파드 종료/재시작
# 비정상 파드로 트래픽을 라우팅하지 않음. 프로덕션 필수

# 편집
kubectl edit
kubectl edit deployment/helloworld-deployment

## liveness && 모니터링
kubectl create -f deployment/helloworld-healthcheck.yml && watch -n1 kubectl get pods
## readiness && 모니터링
# 시간차 존재
kubectl create -f deployment/helloworld-liveness-readiness.yml && watch -n1 kubectl get pods