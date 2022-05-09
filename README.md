# perts-docker-python-node

- PERTS Python/Node CI/CD image
- Includes the required GCloud SDK version, GCloud python components, and MySQL libs.

## Commands

```
docker build -t taptapdan/perts-python . --no-cache
docker tag taptapdan/perts-python taptapdan/python:2.7.18-node-perts
docker push taptapdan/python:2.7.18-node-perts
```
