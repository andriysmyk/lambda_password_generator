import random
import string

def generate_password(length=12):
    if length < 4:
        raise ValueError("Password length should be at least 4 characters.")

    chars = string.ascii_letters + string.digits + string.punctuation
    password = ''.join(random.choice(chars) for _ in range(length))
    return password

def lambda_handler(event, context):
    length = int(event.get('length', 12))
    password = generate_password(length)
    return {
        'statusCode': 200,
        'body': password
    }
