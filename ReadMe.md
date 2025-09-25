## Commands to run

##### * Start services:

```bash
  	docker compose up --build -d
```

## List volumes:

    1.`	docker volume ls	`

## Connect to PostgreSQL inside the container:

```
docker exec -it <container_name> psql -U <username> -d <database>

```

## Command to reset the entire setup

```
docker compose down

```

## Command to delete a volume:

```
docker volume rm <volume_name>

```

## Command to delete a container:

* [ ] `docker rm <container_name>`
