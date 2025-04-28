# 📄 Postgres Docker Service

## Overview

This project provides a **Postgres database** service running inside Docker, designed for:

- Custom roles and permissions.
- Preprocessed initialization scripts for flexible setup.
- `.env`-based configuration for easy customization.
- Streamlined workflows for development, initialization, and resets.

This setup is ideal for developers and DevOps teams looking for a robust, reusable, and configurable Postgres service.

---

## Features

- **Customizable Initialization**: SQL templates (`.tpl`) are preprocessed with environment variables to create dynamic initialization scripts.
- **SQL Init Scripts**: Predefined SQL scripts for setting up default roles, tables, and permissions, including:
  - **Default SQL Table**: A structured SQL table for relational data.
  - **Default NoSQL Table**: A flexible NoSQL table for unstructured or semi-structured data.
- **Role-Based Access Control**: Predefined roles and permissions for secure database access.
- **Makefile Automation**: Simplified commands for building, starting, and resetting the service.
- **Environment-Driven Configuration**: `.env` file support for seamless integration into different environments.

---

## Makefile Integration

This project includes a `Makefile` to simplify common Docker and Postgres operations. The `Makefile` provides convenient commands to manage the lifecycle of the Docker containers and the Postgres service. See the [Makefile Commands](#makefile-commands) section for details on available commands and their purposes.

---

## Environment Variables (`.env`)

| Variable               | Purpose                                   |
|:-----------------------|:------------------------------------------|
| `DEV_ADMIN_USER`       | Developer admin account name             |
| `DEV_ADMIN_PASSWORD`   | Developer admin account password         |
| `API_ACCESS_USER`      | API access account name                  |
| `API_ACCESS_PASSWORD`  | API access account password              |
| `POSTGRES_DB`          | Default database name                    |

### Project-specific environment variables:

- KeyVault

  | Variable               | Purpose                                   |
  |:-----------------------|:------------------------------------------|
  | `SECRETS_READ_USER`    | Secrets read-only user                   |
  | `SECRETS_READ_PASSWORD`| Secrets read-only user password          |
  | `SECRETS_WRITE_USER`   | Secrets write user                       |
  | `SECRETS_WRITE_PASSWORD`| Secrets write user password             |

---

## Makefile Commands

| Command       | Purpose                                                                 |
|:--------------|:------------------------------------------------------------------------|
| `make up`     | Build and start containers (detached).                                  |
| `make down`   | Stop and remove containers and volumes.                                 |
| `make image`  | Build the custom Postgres Dockerfile manually.                          |
| `make build`  | Build Dockerfile and compose services.                                  |
| `make reset`  | Full clean reset: stop, remove volumes, rebuild, and restart services.  |

---

## Setup Instructions

1. Prepare your `.env` file with the required environment variables.
2. Build and start the service:

```bash
make reset
```

✅ This will:

- Build the Docker image.
- Start the container.
- Initialize the database with custom users and schemas.

---

## Connecting to the Database

After running `make up`, connect using `psql`:

```bash
psql -h localhost -U <DEV_ADMIN_USER> -d <POSTGRES_DB>
```

Example:

```bash
psql -h localhost -U developer_admin -d postgres_database
```

It will prompt for the password (`DEV_ADMIN_PASSWORD`).

---

## Initialization Scripts

The `init-scripts/` folder contains templates and SQL scripts for initializing the database. These scripts are processed and executed during the container startup to set up roles, permissions, and default schemas.

---

## Key Notes

- **First-time initialization scripts** only run if the database volume is empty.
- **If an error occurs during initialization**, you must `make reset` to fully wipe and rebuild.
- The `entrypoint.sh` ensures preprocessing happens **before** Postgres starts.
- Port `5432` is mapped from container to host for local access.

---

## Common Troubleshooting

| Symptom                        | Cause                              | Solution                                                                 |
|:-------------------------------|:-----------------------------------|:------------------------------------------------------------------------|
| `psql: connection refused`     | Port 5432 not exposed              | Add `ports: 5432:5432` to `docker-compose.yaml`.                        |
| `role "postgres" does not exist` | Healthcheck using wrong role       | Change `pg_isready` to use `${DEV_ADMIN_USER}`.                         |
| Init scripts not rerunning     | Volume already initialized         | Run `make reset` to wipe and rebuild.                                   |

---

## Why Use This Setup?

- **Reusable**: Clone and adapt for any Postgres-based project.
- **Secure**: Predefined roles and permissions ensure safe access.
- **Automated**: Makefile commands simplify common workflows.
- **Customizable**: `.env` and SQL templates allow for flexible configurations.

This project is a great starting point for teams looking to integrate Postgres into their development or production environments with minimal effort.