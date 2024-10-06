# 파드 수평 확장 by replication controller

# 파드 확장이므로 minikube
minikube start

# 확인
kubectl get node
kubectl get pod
kubectl get service

# yaml
cat replication-controller/helloworld-repl-controller.yml

# 파드 생성
kubectl create -f replication-controller/helloworld-repl-controller.yml

# 컨트롤러 확인
kubectl get pod

# 하나의 파드만 확인됨. 디버깅
kubectl get node
kubectl describe node minikube
kubectl get pods
kubectl describe pod helloworld-controller-4ccs7
kubectl describe replicationcontroller helloworld-controller
kubectl get events

# 노드/컨트롤러/파드 모드 문제가 없음
kubectl delete pod busybox
kubectl delete replicationcontroller helloworld-controller

# 동일한 이미지의 파드가 있었기 때문이었음. 재생성
kubectl create -f replication-controller/helloworld-repl-controller.yml

# 확인
kubectl get pods
    NAME                          READY   STATUS              RESTARTS   AGE
    helloworld-controller-bs8hw   0/1     ContainerCreating   0          4s
    helloworld-controller-stdm8   1/1     Running             0          4s
kubectl describe pod helloworld-controller-bs8hw

# 제거. 항상 올바른 양의 파드 실행을 관리
kubectl delete pod helloworld-controller-bs8hw
kubectl get pods
    helloworld-controller-878fn   1/1     Running       0          16s
    helloworld-controller-bs8hw   1/1     Terminating   0          3m9s
    helloworld-controller-stdm8   1/1     Running       0          3m9s

# 확장(파일명)
kubectl scale --replicas=4 -f helloworld-repl-controller.yml
kubectl get pods

# 확장(컨트롤러)
kubectl get rc
kubectl scale --replicas=1 rc/helloworld-controller
kubectl get pods
    NAME                          READY   STATUS        RESTARTS   AGE
    helloworld-controller-878fn   1/1     Terminating   0          4m16s
    helloworld-controller-9s8rc   1/1     Terminating   0          101s
    helloworld-controller-mfqqf   1/1     Terminating   0          102s
    helloworld-controller-stdm8   1/1     Running       0          7m9s

kubectl delete rc/helloworld-controller