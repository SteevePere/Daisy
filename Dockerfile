FROM 192.168.34.25:5002/daisy/daisy:latest

COPY ./app .
WORKDIR /app
ENTRYPOINT ["python"]
CMD ["app.py"]
