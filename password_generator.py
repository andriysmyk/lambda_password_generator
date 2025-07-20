import random
import string

def generate_password(length=12):
    characters = string.ascii_letters + string.digits + string.punctuation
    password = ''.join(random.choice(characters) for _ in range(length))
    return password

if __name__ == "__main__":
    try:
        length = int(input("Enter password length: "))
        if length < 4:
            print("Password must be at least 4 characters long.")
        else:
            password = generate_password(length)
            print("Generated password:", password)
    except ValueError:
        print("Please enter a valid integer.")
