# Used Example Docker File available at (https://docs.docker.com/guides/python/develop/) Docker Docs and modified according the requirements 

# In My local machine Python Version is 3.10.12.So as that version
ARG PYTHON_VERSION=3.10.12  
FROM python:${PYTHON_VERSION}-slim as base

# Prevents Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Keeps Python from buffering stdout and stderr to avoid situations where
# the application crashes without emitting any logs due to buffering.
ENV PYTHONUNBUFFERED=1

WORKDIR /app

ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser

RUN pip3 install -r requirements.txt 


# Switch to the non-privileged user to run the application.
USER appuser

# Copy the source code into the container.
COPY . . 

# Expose the port that the application listens on.
EXPOSE 80

# RUN The Application 
CMD flask run