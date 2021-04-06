docker build -t docmarsmoo/multi-client:latest -t docmarsmoo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t docmarsmoo/multi-server:latest -t docmarsmoo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t docmarsmoo/multi-worker:latest -t docmarsmoo/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push docmarsmoo/multi-client:latest
docker push docmarsmoo/multi-server:latest
docker push docmarsmoo/multi-worker:latest

docker push docmarsmoo/multi-client:$SHA
docker push docmarsmoo/multi-server:$SHA
docker push docmarsmoo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=docmarsmoo/multi-server:$SHA
kubectl set image deployments/client-deployment client=docmarsmoo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=docmarsmoo/multi-worker:$SHA