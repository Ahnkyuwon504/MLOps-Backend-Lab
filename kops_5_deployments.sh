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


