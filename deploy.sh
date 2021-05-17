docker build -t christiemyburgh/multi-client:latest -t christiemyburgh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t christiemyburgh/multi-server:latest -t christiemyburgh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t christiemyburgh/multi-worker:latest -t christiemyburgh/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push christiemyburgh/multi-client:latest
docker push christiemyburgh/multi-server:latest
docker push christiemyburgh/multi-worker:latest

docker push christiemyburgh/multi-client:$SHA
docker push christiemyburgh/multi-server:$SHA
docker push christiemyburgh/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=christiemyburgh/multi-server:$SHA
kubectl set image deployments/client-deployment client=christiemyburgh/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=christiemyburgh/multi-worker:$SHA