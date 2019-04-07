# Docker and docker-compose

## What's this

Nested Docker Container(Docker中からDockerコンテナを操作する)用の、Docker と docker-compose をインストールしたイメージ。

## Usage

### docker command

```bash
docker run -v /var/run/docker.sock:/var/run/docker.sock kazuhito/docker-and-compose docker run hello-world
```

## Author

- [kazuhito_m](https://twitter.com/kazuhito_m)
