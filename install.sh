#! /bin/sh

moddir="$HOME/.minetest/games/testing/mods";

rm -fr "$moddir/irc_admin";
cp -fr "../minetest-irc_admin" "$moddir/";
mv "$moddir/minetest-irc_admin" "$moddir/irc_admin";
