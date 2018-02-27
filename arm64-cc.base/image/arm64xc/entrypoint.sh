#!/bin/bash

# This is the entrypoint script for the dockerfile. Executed in the
# container at runtime.

if [[ $# == 0 ]]; then
    # Presumably the image has been run directly, so help the user get started.
    cat /arm64xc/arm64xc
    exit 0
fi

# If we are running docker natively, we want to create a user in the container
# with the same UID and GID as the user on the host machine, so that any files
# created are owned by that user. Without this they are all owned by root.
# If we are running from boot2docker, this is not necessary, and you end up not
# being able to write to the volume.
# The rpxc script sets the RPXC_UID and RPXC_GID vars.
if [[ -n $ARM64XC_UID ]] && [[ -n $ARM64XC_GID ]]; then

    ARM64XC_USER=arm64xc-user
    ARM64XC_GROUP=arm64xc-group
    ARM64XC_HOME=/home/$ARM64XC_USER

    groupadd -o -g $ARM64XC_GID $ARM64XC_GROUP 2> /dev/null
    useradd -o -m -d $ARM64XC_HOME -g $ARM64XC_GID -u $ARM64XC_UID $ARM64XC_USER 2> /dev/null

    # Run the command as the specified user/group.
    HOME=$ARM64XC_HOME exec chpst -u :$ARM64XC_UID:$ARM64XC_GID "$@"
else
    # Just run the command as root.
    exec "$@"
fi