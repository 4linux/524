docker run -dti --name nexus --restart always -p 8081:8081 -p 8082:8082 -p 8083:8083 sonatype/nexus3 > /dev/null 2>&1  && echo "[OK] Sonatype Nexus3 container started"
