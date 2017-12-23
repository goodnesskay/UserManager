import os,sys,platform,subprocess

is_docker_installed = False

try:
    res = subprocess.check_output(["docker", "info"])

    #set docker installation status to true
    is_docker_installed = True
except subprocess.CalledProcessError:
    sys.exit("is docker running?")
except OSError :
    sys.exit("Docker seems not to be installed")

if not is_docker_installed :
    print("Docker Compose not Installed")

app_platform = platform.system()

print('setting up your application...\n')

if is_docker_installed:
    if (app_platform == "Linux"):
        os.system("sudo docker-compose build")
        print('Just finished building...')
        os.system("sudo docker-compose up")
    else:
        os.system("docker-compose build")
        print('Just finished building...')
        os.system("docker-compose up")