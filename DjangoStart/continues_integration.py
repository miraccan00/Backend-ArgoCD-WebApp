import subprocess
def continues_integration(servicename,tag):

    # Build Docker image
    subprocess.run(["docker", "build", "-t", f"{servicename}:{tag}", "."])

    print(f"Docker {servicename}:{tag} image build is completed")

    dockerusername = "miraccan"

    # Tag Docker image
    subprocess.run(["docker", "image", "tag", f"{servicename}:{tag}", f"{dockerusername}/{servicename}:{tag}"])

    # Push Docker image
    subprocess.run(["docker", "push", f"{dockerusername}/{servicename}:{tag}"])

    print(f"Docker {servicename}:{tag} image push is completed")
    return True