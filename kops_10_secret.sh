cat deployment/helloworld-secrets.yml

# 암호문 생성
echo -n 'root' | base64
echo -n 'password' | base64

# secret
kubectl create -f deployment/helloworld-secrets.yml

cat deployment/helloworld-secrets-volumes.yml

# deployment
kubectl create -f deployment/helloworld-secrets-volumes.yml

# 확인
kubectl get pods
kubectl describe pod {one of them}
kubectl exec -it {one of them} -- /bin/bash
    cat /etc/creds/username
    cat /etc/creds/password

# mount 확인
mount

# 토큰/인증서
ls /run/secrets/kubernetes.io/serviceaccount/