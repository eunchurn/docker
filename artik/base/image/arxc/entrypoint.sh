#!/bin/bash

# This is the entrypoint script for the dockerfile. Executed in the
# container at runtime.

if [[ $# == 0 ]]; then
    # Presumably the image has been run directly, so help the user get started.
    cat /arxc/arxc
    exit 0
fi

# If we are running docker natively, we want to create a user in the container
# with the same UID and GID as the user on the host machine, so that any files
# created are owned by that user. Without this they are all owned by root.
# If we are running from boot2docker, this is not necessary, and you end up not
# being able to write to the volume.
# The rpxc script sets the RPXC_UID and RPXC_GID vars.
if [[ -n $ARXC_UID ]] && [[ -n $ARXC_GID ]]; then

    ARXC_USER=arxc-user
    ARXC_GROUP=arxc-group
    ARXC_HOME=/home/$ARXC_USER

    groupadd -o -g $ARXC_GID $ARXC_GROUP 2> /dev/null
    useradd -o -m -d $ARXC_HOME -g $ARXC_GID -u $ARXC_UID $ARXC_USER 2> /dev/null

    # Run the command as the specified user/group.
    HOME=$ARXC_HOME exec chpst -u :$ARXC_UID:$ARXC_GID "$@"
else
    # Just run the command as root.
    exec "$@"
fi