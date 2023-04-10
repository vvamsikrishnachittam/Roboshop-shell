curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y

curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"
cd /home/roboshop
rm -rf cart
unzip -o /tmp/cart.zip
mv cart-main cart
cd cart
npm install

sed -e -i 's/REDIS_ENDPOINT/redis.vamsi.online/'  -e 's/MONGO.ENDPOINT/ mongo.vamsy.online/' /home/roboshop/cart/systemd.service

mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
systemctl daemon-reload
systemctl restart cart
systemctl enable cart