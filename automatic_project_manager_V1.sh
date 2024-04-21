#!/bin/bash

# This script is used to build and run the ProjectPreProcessor, Project, and ProjectPostProcessor.
# The directories for these projects should be at the same level as this script.

# Function to build and run a project
build_and_run() {
    # Navigate to the project directory
    cd "./Project/$1/"
    
    # Create a build directory if it doesn't exist
    mkdir -p ./build/
    
    # Navigate to the build directory
    cd ./build/
    
    # Run cmake in the build directory
    cmake ../ # My case (current directory)
    
    # Clean the build directory
    make clean
    
    # Build the project
    make -s
    
    # Run the project
    ./myFem
    
    # Check if the next project's data directory exists
    if [ -d "../../$2/data/" ]; then
        # Move the data files to the next project's data directory
        mv ../data/*.txt "../../$2/data/"
    fi
    
    # Go back to the parent node (Original "Project")
    cd ../../../
}

# Build and run the ProjectPreProcessor
# The data files are moved to the Project's data directory
build_and_run "ProjectPreProcessor" "Project"

# Build and run the Project
# The data files are moved to the ProjectPostProcessor's data directory
build_and_run "Project" "ProjectPostProcessor"

# Build and run the ProjectPostProcessor
build_and_run "ProjectPostProcessor" ""
