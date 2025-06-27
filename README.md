### Using the Local Container

*Important:*
The MadScienceLabDocker repository is used only as a source of assets. The Dockerfile included in the docker/ folder is a remixed version that uses bash instead of zsh, along with several other modifications to better suit this environment.

Always build your local container image using the Dockerfile in the docker/ folder. The MadScienceLabDocker folder is included for reference and asset sources only.
Build the container (run once or whenever you need to rebuild the image):

`./docker/scripts/build.sh`

Start the container (run whenever you want a dev shell):

`./docker/scripts/start.sh`

### Git Versioning and the MadScienceLabDocker Submodule

The docker/MadScienceLabDocker folder is itself a separate Git repository. To properly version your project while including this external repo, use a Git submodule:

1. To add the submodule (if not done already):

`git submodule add https://github.com/throwtheswitch/MadScienceLabDocker.git docker/MadScienceLabDocker`

2. Commit the change:

`git commit -m "Add MadScienceLabDocker as a git submodule"`

3. When cloning your repository later, initialize and update submodules with:

`git submodule update --init --recursive`

Using a Git submodule keeps the MadScienceLabDocker repo tracked separately and makes it easier to pull upstream changes when needed.


## Running `gcov`

- Make sure gcov plugin is enabled in project.yml 
- Running `ceedling gcov:all` will display simple coverage statistics
- build/artifacts/gcov/gcovr/ will contain coverage results in HTML format

- More info : https://github.com/ThrowTheSwitch/Ceedling/blob/master/plugins/gcov/README.md