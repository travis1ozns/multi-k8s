docker build -t dockerozns/multi-client-k8s:latest -t dockerozns/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t dockerozns/multi-server-k8s-pgfix:latest -t dockerozns/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t dockerozns/multi-worker-k8s:latest -t dockerozns/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push dockerozns/multi-client-k8s:latest
docker push dockerozns/multi-server-k8s-pgfix:latest
docker push dockerozns/multi-worker-k8s:latest

docker push dockerozns/multi-client-k8s:$SHA
docker push dockerozns/multi-server-k8s-pgfix:$SHA
docker push dockerozns/multi-worker-k8s:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dockerozns/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=dockerozns/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=dockerozns/multi-worker-k8s:$SHA