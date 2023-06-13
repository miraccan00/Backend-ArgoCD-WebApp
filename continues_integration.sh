cd DjangoStart
servicename=$1
tag=$2
docker build -t ${servicename}:${tag} .
echo "Docker ${servicename}:${tag} image build is completed"
dockerusername="miraccan"
docker image tag ${servicename}:${tag} ${dockerusername}/${servicename}:${tag}
docker push ${dockerusername}/${servicename}:${tag}
echo "Docker ${servicename}:${tag} image push is completed"
echo "----------------------------------------------------"