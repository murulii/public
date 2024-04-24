cd ui-web-app-reactjs
docker build -t frontend .
docker run -it -d -p 8080:8080 frontend
cd ..

cd zuul-api-gateway
docker build -t api .
docker run -it -d -p 9999:9999 api
cd ..

cd shoes-microservice-spring-boot
docker build -t shoe .
docker run -it -d -p 1002:1002 shoe
cd ..

cd wishlist-microservice-python
docker build -t wish .
docker run -it -d -p 1003:1003 wish
cd ..

cd offers-microservice-spring-boot
docker build -t offers .
docker run -it -d -p 1001:1001 offers
cd ..

cd cart-microservice-nodejs
docker build -t cart .
docker run -it -d -p 1004:1004 cart
cd ..
