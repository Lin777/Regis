#!/bin/bash

docker run -dit --name esug -p 8000:8000 esug bash
docker exec -d esug screen -Sdm esug ./startPharoImage.sh
