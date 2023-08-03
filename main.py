import os
import boto3

def test_s3_connection():
    IAM_USER_ACCESS_KEY = os.environ.get("IAM_USER_ACCESS_KEY")
    IAM_USER_SECRET_KEY = os.environ.get("IAM_USER_SECRET_KEY")
    ACCESS_POINT_NAME = os.environ.get("ACCESS_POINT_NAME")
    BUCKET_NAME = os.environ.get("BUCKET_NAME")

    s3 = boto3.client(
        "s3",
        aws_access_key_id=IAM_USER_ACCESS_KEY,
        aws_secret_access_key=IAM_USER_SECRET_KEY
    )

    try:
        # Test reading from the bucket
        response = s3.list_objects_v2(Bucket=BUCKET_NAME, MaxKeys=1)
        print("Successfully read from the bucket!")
        print("Example object in the bucket:")
        if "Contents" in response:
            print(response["Contents"][0]["Key"])

        # Test writing to the bucket
        test_key = "test.txt"
        test_data = "This is a test file."
        s3.put_object(Bucket=BUCKET_NAME, Key=test_key, Body=test_data)
        print("Successfully wrote to the bucket!")
        print(f"Test object '{test_key}' created in the bucket.")

        # Clean up by deleting the test object
        s3.delete_object(Bucket=BUCKET_NAME, Key=test_key)
        print(f"Test object '{test_key}' deleted.")

    except Exception as e:
        print("Error:", str(e))

if __name__ == "__main__":
    test_s3_connection()
