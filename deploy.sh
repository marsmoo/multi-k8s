docker build -t docmarsmoo/multi-client:latest -t docmarsmoo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t docmarsmoo/multi-server:latest -t docmarsmoo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t docmarsmoo/multi-worker:latest -t docmarsmoo/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push docsmarsmoo/multi-client:latest
docker push docsmarsmoo/multi-server:latest
docker push docsmarsmoo/multi-worker:latest

docker push docsmarsmoo/multi-client:$SHA
docker push docsmarsmoo/multi-server:$SHA
docker push docsmarsmoo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=docmarsmoo/multi-server:$SHA
kubectl set image deployments/client-deployment client=docmarsmoo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=docmarsmoo/multi-worker:$SHA