```bash 
# built a custom container image named hello_world  using a container file. 

# STEP  1 -  create directory and file with contents 

mkdir -p ~/Hello_World
cd ~/Hello_World

vim Containerfile

# add this content 

FROM registry.access.redhat.com/ubi8/ubi-init

RUN yum -y install httpd && yum clean all

RUN echo "Hello World!" > /var/www/html/index.html

RUN systemctl enable httpd

EXPOSE 80

CMD ["/sbin/init"]


# STEP 2 - build the image and verify it 

podman build -t hello_world . 

podman images | grep hello_world 

# STEP 3 -  run the container 

podman run -d \
  --name hello_world_run \
  -p 80:80 \
  hello_world

# if port 80 is taken, be sure to stop it beforehand  

# STEP 4 - verify container and web server 
podman ps 

curl http://localhost:80 

# you should see "Hello world!" 




```
