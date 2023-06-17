import subprocess

# Git commands
def commit():
    subprocess.run(["git", "add", "."])
    subprocess.run(["git", "commit", "-m", "ArgoCD installation"])
    subprocess.run(["git", "push", "origin", "master"])