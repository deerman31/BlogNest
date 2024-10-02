# BlogNest

BlogNest is a small infrastructure project built using Docker. The project aims to run multiple services in different containers and establish connections between them.

## Project Overview

BlogNest consists of the following components:

- NGINX (with TLSv1.2 or TLSv1.3 only)
- WordPress + php-fpm
- MariaDB
- Docker volume for WordPress database
- Docker volume for WordPress website files
- Docker network for container connections

## Prerequisites

- Virtual Machine
- Docker
- Docker Compose

## Setup

1. Clone the repository:
   ```
   git clone <repository-url>
   cd BlogNest
   ```

2. Create a `.env` file in the `srcs` directory and set the necessary environment variables.

3. Build and start the project using the Makefile:
   ```
   make
   ```

## Project Structure

```
.
├── Makefile
└── srcs
    ├── docker-compose.yml
    ├── .env
    └── requirements
        ├── mariadb
        │   ├── Dockerfile
        │   └── conf
        ├── nginx
        │   ├── Dockerfile
        │   └── conf
        └── wordpress
            ├── Dockerfile
            └── conf
```

## Technologies Used

- Docker
- NGINX
- WordPress
- MariaDB
- PHP-FPM

## Key Points

- Each service runs in a dedicated container.
- Docker images are based on the penultimate stable version of Alpine or Debian.
- Each service has its own Dockerfile.
- Containers restart automatically in case of a crash.
- The NGINX container is the only entry point, accessible via port 443 using TLSv1.2 or TLSv1.3 protocol.
- The database contains two users, one of which is an administrator.
