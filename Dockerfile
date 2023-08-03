# Use the official Python 3.9.17 image as the base image
FROM python:3.9.17-bullseye

# Create a directory for the application code
WORKDIR /app

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y git

# Copy the Python script and the requirements.txt file to the container
COPY main.py /app/main.py

# Copy the requirements.txt file if you have any Python dependencies
# COPY requirements.txt /app/requirements.txt
# RUN pip install -r /app/requirements.txt

# Expose the GitHub secrets to text files in the container
# You can use the same variable names as GitHub secrets here
ARG IAM_USER_ACCESS_KEY
ARG IAM_USER_SECRET_KEY
ARG ACCESS_POINT_NAME
ARG BUCKET_NAME

RUN echo $IAM_USER_ACCESS_KEY > /app/iam_user_access_key.txt
RUN echo $IAM_USER_SECRET_KEY > /app/iam_user_secret_key.txt
RUN echo $ACCESS_POINT_NAME > /app/access_point_name.txt
RUN echo $BUCKET_NAME > /app/bucket_name.txt

# Set environment variables for the Python script to use the secrets
ENV IAM_USER_ACCESS_KEY_FILE=/app/iam_user_access_key.txt
ENV IAM_USER_SECRET_KEY_FILE=/app/iam_user_secret_key.txt
ENV ACCESS_POINT_NAME_FILE=/app/access_point_name.txt
ENV BUCKET_NAME_FILE=/app/bucket_name.txt

# Run your Python script using the secrets
CMD ["python", "main.py"]
