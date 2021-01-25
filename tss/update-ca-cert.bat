docker-compose exec api update-ca-certificates
echo Restarting...
docker-compose down
docker-compose up -d
echo Restarted