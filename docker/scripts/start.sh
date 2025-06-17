docker run -it --rm -v $(pwd)/workspace:/home/dev/workspace -v $(pwd)/docker:/docker:ro --user "$(id -u):$(id -g)"  ceedling-container
