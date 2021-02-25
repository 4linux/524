docker run -dti --name sonarqube --restart always -p 9000:9000 sonarqube:lts > /dev/null 2>&1  && echo "[OK] SonarQube container started"
