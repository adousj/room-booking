#! /bin/bash

echo "stoping the room management website"

ps -ax | grep "unicorn master" | grep -v "grep" | awk '{print $1}' | xargs kill
