<p  align="center">
<a  href="https://flutter.dev"  target="_blank"><img  height="39"  src="https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png"  alt="Flutter Logo"></a> <a>&nbsp;&nbsp;&nbsp;</a>
<a  href="https://appwrite.io"  target="_blank"><img  width="260"  height="39"  src="https://appwrite.io/images/github-logo.png"  alt="Appwrite Logo"></a>

</p>
# NO Signal

A functional replica of Signal(Chatting App) made using Flutter and Appwrite.

## What is Appwrite?

[Appwrite](https://appwrite.io/) is a self-hosted solution that provides developers with a set of easy-to-use and integrate REST APIs to manage their core backend needs.

## Features

- Built on [RiverPod](https://pub.dev/packages/flutter_riverpod) Architecture Pattern
- Authentication using OAuth and OAuth 2.0
- Users can send text, images and Videos to other users
- Users can view other Profiles(See their bio and picture)

## Installation

### Appwrite

Appwrite backend server is designed to run in a container environment. Running your server is as easy as running one command from your terminal. You can either run Appwrite on your localhost using docker-compose or on any other container orchestration tool like Kubernetes, Docker Swarm or Rancher.

The easiest way to start running your Appwrite server is by running our docker-compose file. Before running the installation command make sure you have [Docker](https://www.docker.com/products/docker-desktop) installed on your machine:

### Unix

```bash
docker run -it --rm \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume "$(pwd)"/appwrite:/install/appwrite:rw \
    -e version=0.6.2 \
    appwrite/install
```

### Windows

#### CMD

```cmd
docker run -it --rm ^
    --volume //var/run/docker.sock:/var/run/docker.sock ^
    --volume "%cd%"/appwrite:/install/appwrite:rw ^
    -e version=0.6.2 ^
    appwrite/install
```

#### PowerShell

```powershell
docker run -it --rm ,
    --volume /var/run/docker.sock:/var/run/docker.sock ,
    --volume ${pwd}/appwrite:/install/appwrite:rw ,
    -e version=0.6.2 ,
    appwrite/install
```

Once the Docker installation completes, go to <http://localhost> to access the Appwrite console from your browser. Please note that on non-linux native hosts, the server might take a few minutes to start after installation completes.

For advanced production and custom installation, check out our Docker [environment variables](docs/tutorials/environment-variables.md) docs. You can also use our public [docker-compose.yml](https://appwrite.io/docker-compose.yml) file to manually set up and environment.

#### Setting up appwrite project

### Flutter

To build and run this project:

1. Get Flutter [here](https://flutter.dev) if you don't already have it
2. Clone this repository
3. `cd` into the repo folder
4. run `flutter run-android` or `flutter run-ios` to build the app

(Please note that a Mac with XCode is required to build for iOS)

