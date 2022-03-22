# test-go-api

Testing purpose.

## Work process

### Use docker

Makefile command,

- `make docker.build`: Build image.
- `make docker.run`: Create a container.
- `make docker.remove`: Destroy the container.
- `make docker.logs`: Monitor the container.

You need to build the image before starting the api service,,

```bash
make docker.build
```

Then execute as follows,

```bash
make docker.remove; make docker.run; make docker.logs
```

### Use docker-compose

Makefile command,

- `make run`: Create a container.
- `make remove`: Destroy the container.
- `make go_run`: Start api service.
- `make mod_vendor`: Download dependencies. Execute once. This command must be executed before starting the api server.

The first time, execute as follows,

```bash
make remove; make run; make mod_vendor; make go_run;
```

After that just execute,

```bash
make remove; make run; make go_run;
```

When the api service is running, you will see

```pre
2022/03/22 06:06:36 Listening on localhost:8089
```

Press `ctrl + c` to interrupt the api service.

### Test API

```bash
curl -v http://localhost:8089/
```

The log as follows,

```pre
{"level":"info","ts":1647930052.5548303,"caller":"internal/main.go:26","msg":"Hello Go"}
```

```bash
curl -X POST -v http://localhost:8089/post_json -H "Content-type: application/json" -d "{\"first_name\" : \"John\", \"last_name\" : \"Smith\"}"
```

The log as follows,

```pre
{"level":"info","ts":1647930120.8995447,"caller":"internal/main.go:50","msg":"{\"first_name\":\"John\",\"last_name\":\"Smith\"}"}
```

## Ref

- [How to Parse a JSON Request Body in Go](https://www.alexedwards.net/blog/how-to-properly-parse-a-json-request-body)