build-image:
	docker build -t overdrive3000/nameko-example-gateway:v0.3 .;

docker-tag:
	docker tag overdrive3000/nameko-example-gateway:$(FROM_TAG) \
	overdrive3000/nameko-example-gateway:$(TAG)

push-image:
	docker push overdrive3000/nameko-example-gateway:v0.3
