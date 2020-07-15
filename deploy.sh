docker build -t leslykqi/multi-client:latest -t leslykqi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t leslykqi/multi-server:latest -t leslykqi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t leslykqi/multi-worker:latest -t leslykqi/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push leslykqi/multi-client:latest
docker push leslykqi/multi-server:latest
docker push leslykqi/multi-worker:latest
docker push leslykqi/multi-client:$SHA
docker push leslykqi/multi-server:$SHA
docker push leslykqi/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=leslykqi/multi-server:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client:latest
kubectl set image deployments/worker-deployment worker=leslykqi/multi-worker:$SHA
