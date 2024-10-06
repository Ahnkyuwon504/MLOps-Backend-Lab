# commands
kubectl get deployments
kubectl get rs # not rc
kubectl get pods --show-labels # 파드에 레이블 추가
kubectl rollout status deployment/{배포객체명} # get status
# 최신버전 업데이트
kubectl set image deployment/{배포객체명} k8s-demo=k8s-demo:2
kubectl edit deployment/{배포객체명}
# 새 버전으로 업데이트된 이미지의 배포 상태 확인
kubectl rollout status deployment/{배포객체명} # status of rollout
# get history
kubectl rollout history deployment/{배포객체명}
# rollback
kubectl rollout undo deployment/{배포객체명} --to-revision=n


# yml
cat deployment/helloworld.yml

# 배포생성
kubectl create -f deployment/helloworld.yml

# 확인
kubectl get deployments
kubectl get rs
kubectl get pods --show-labels
    NAME                                     READY   STATUS    RESTARTS   AGE   LABELS
    helloworld-deployment-586b86d787-5ckts   1/1     Running   0          67s   app=helloworld,pod-template-hash=586b86d787
    helloworld-deployment-586b86d787-k5j25   1/1     Running   0          67s   app=helloworld,pod-template-hash=586b86d787
    helloworld-deployment-586b86d787-xh2th   1/1     Running   0          67s   app=helloworld,pod-template-hash=586b86d787
kubectl rollout status deployment/helloworld-deployment

## latest를 v2로 변경 후 롤백
# 서비스 생성
kubectl expose deployment helloworld-deployment --type=NodePort

# 확인
kubectl get service
kubectl describe service helloworld-deployment
# 앱 연결
minikube service helloworld-deployment --url

# 새로운 이미지 설정
kubectl set image deployment/helloworld-deployment k8s-demo=wardviaene/k8s-demo:2

# 배포추적
kubectl rollout status deployment/helloworld-deployment
kubectl get pods
kubectl rollout history deployment/helloworld-deployment

kubectl create -f deployment/helloworld.yml --record

# 롤백
kubectl rollout undo deployment/helloworld-deployment
kubectl rollout status deployment/helloworld-deployment

# 다른버전
kubectl edit deployment/helloworld-deployment
    revisionHistoryLimit: 10>100

# 다시 롤아웃    
kubectl set image deployment/helloworld-deployment k8s-demo=wardviaene/k8s-demo:2
kubectl set image deployment/helloworld-deployment k8s-demo=wardviaene/k8s-demo:1
kubectl rollout history deployment/helloworld-deployment
kubectl rollout undo deployment/helloworld-deployment --to-revision=3