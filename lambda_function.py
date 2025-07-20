import random
import string

def generate_password(length=10):
    characters = string.ascii_letters + string.digits + string.punctuation
    password = ''.join(random.choice(characters) for _ in range(length))
    return password

def lambda_handler(event, context):
    password = generate_password(10)
    return {
        "statusCode": 200,
        "your_password": password
    }
