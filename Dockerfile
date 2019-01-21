FROM python:3.6-alpine
ADD . /anukitchen
WORKDIR /anukitchen
RUN apk --no-cache update && apk --no-cache upgrade \
	&& apk --no-cache add curl tree \
	&& apk add -U --no-cache gcc build-base linux-headers ca-certificates nginx\
	python3-dev libffi-dev libressl-dev libxslt-dev \
	# Pillow Dependencies
	jpeg-dev zlib-dev lcms2-dev \
    	openjpeg-dev tiff-dev tk-dev \
    && mkdir -p /run/nginx \
	&& pip install -r requirements.txt
EXPOSE 8000 
EXPOSE 80
COPY ./nginx.conf /etc/nginx/nginx.conf
CMD ["nginx", "-g", "daemon on;"] 
CMD ["python", "anukitchen.py"]
ENTRYPOINT ["gunicorn", "anukitchen:app"]
