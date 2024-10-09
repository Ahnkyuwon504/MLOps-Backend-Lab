cat pod-lifecycle/lifecycle.yaml

# 파드 모니터링
watch -n1 kubectl get pods

# lifecycle
kubectl create -f lifecycle.yaml

# 대화형 쉘
kubectl exec -it lifecycle {lifecycle pod name} -- cat /timing

# tail
kubectl exec -it lifecycle {lifecycle pod name} -- tail /timing -f