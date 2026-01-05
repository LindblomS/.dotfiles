#!/bin/sh

# start kanata as user kanata
su --login -c "~/kanata/target/release/kanata --cfg /home/sappe/.dotfiles/kanata/kanata_laptop.cfg" - kanata
