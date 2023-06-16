import subprocess

def install_project():
    subprocess.run(['sh', 'start.sh'])

def continues_integration():
    servicename = "microservicename"
    tag = "1.0.2"
    subprocess.run(['sh', 'continues_integration.sh', servicename, tag])


def main():
    while True:
        print("1. Install project")
        print("2. Continues integration")
        option = input("Select option: ")
        if option == "1":
            install_project()
        elif option == "2":
            continues_integration()
        else:
            print("Invalid option")
            exit(1)
if __name__ == "__main__":
    main()