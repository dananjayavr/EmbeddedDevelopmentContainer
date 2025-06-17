### Using the Local Container

*Important:*
The MadScienceLabDocker repository is used only as a source of assets. The Dockerfile included in the docker/ folder is a remixed version that uses bash instead of zsh, along with several other modifications to better suit this environment.

Always build your local container image using the Dockerfile in the docker/ folder. The MadScienceLabDocker folder is included for reference and asset sources only.
Build the container (run once or whenever you need to rebuild the image):

`./docker/scripts/build.sh`

Start the container (run whenever you want a dev shell):

`./docker/scripts/start.sh`

