#chmod +x *sh
#sudo docker-compose up -d
sudo docker stack deploy -c docker-compose.yml greenplum
