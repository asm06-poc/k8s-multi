docker build -t stephengrider/multi-client:latest -t asm06/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t asm06/multi-server:latest -t asm06/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t asm06/multi-worker:latest -t asm06/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push asm06/multi-client:latest
docker push asm06/multi-server:latest
docker push asm06/multi-worker:latest
docker push asm06/multi-client:$SHA
docker push asm06/multi-server:$SHA
docker push asm06/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=asm06/multi-server:$SHA
kubectl set image deployments/client-deployment client=asm06/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=asm06/multi-worker:$SHA