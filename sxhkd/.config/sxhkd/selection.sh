#!/bin/sh -e

DATETIME=`date +%F_%H%M%S`
shotgun $(hacksaw -f "-i %i -g %g") ~/$DATETIME.png
