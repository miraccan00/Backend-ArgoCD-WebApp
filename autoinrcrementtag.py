import subprocess
import re

def main():
    version_parts = [1, 0, 0]  # Start from v1.0.0

    while True:
        option = get_version_input()

        if option == 1:
            version_parts[0] += 1  # Increment major version
            version_parts[1] = 0  # Reset minor version
            version_parts[2] = 0  # Reset patch version
        elif option == 2:
            version_parts[1] += 1  # Increment minor version
            version_parts[2] = 0  # Reset patch version
        elif option == 3:
            version_parts[2] += 1  # Increment patch version
        else:
            print("Invalid option. Please choose 1, 2, or 3.")
            continue

        new_version = ".".join(map(str, version_parts))
        print(f"New version: {new_version}")

        # Build and tag the Docker image
        subprocess.run(["docker", "build", "-t", f"your_image_name:{new_version}", "./DjangoStart"])

def get_version_input():
    while True:
        print("Please choose the version increment type:")
        print("1. Major")
        print("2. Minor")
        print("3. Patch")
        option = input("Enter the option number: ")
        try:
            option = int(option)
            if option >= 1 and option <= 3:
                break
            else:
                print("Invalid option. Please choose 1, 2, or 3.")
        except ValueError:
            print("Invalid input. Please try again.")
    
    return option

if __name__ == "__main__":
    main()