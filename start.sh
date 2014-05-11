#! /bin/bash

echo 'starting the room management website'
unicorn -c unicorn.rb -D
