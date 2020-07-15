docker build -t leslykqi89/multi-client:latest -t leslykqi89/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t leslykqi89/multi-server:latest -t leslykqi89/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t leslykqi89/multi-worker:latest -t leslykqi89/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push leslykqi89/multi-client:latest
docker push leslykqi89/multi-server:latest
docker push leslykqi89/multi-worker:latest
docker push leslykqi89/multi-client:$SHA
docker push leslykqi89/multi-server:$SHA
docker push leslykqi89/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=leslykqi89/multi-server:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client:latest
kubectl set image deployments/worker-deployment worker=leslykqi89/multi-worker:$SHA
