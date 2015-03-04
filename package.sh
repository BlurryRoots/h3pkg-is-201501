#!/bin/bash

# callback for fetching the raw package data
function h3pkg_script_get_raw () {
	#
	local PUB_PATH="/home/pub/prof/schumann_sabine/B-AI6_IS/"

	rsync -aP "${H3PKG_USER}@${H3PKG_REMOTE_HOME}:${PUB_PATH}" "${H3PKG_PACKAGE_HOME}/.cache"

	return $?
}

# callback for building the package
function h3pkg_script_build_package () {
	local raw_base=${H3PKG_PACKAGE_HOME}/.cache/B-AI6_IS
	#
	cd ${H3PKG_PACKAGE_HOME} && {
		rm -rf is
		mkdir -p is
		cd is && {
			mkdir -p doc lab etc

			cp -aR ${raw_base}/Folien doc
			cp -aR ${raw_base}/Praktikum lab
			cp -aR ${raw_base}/Prolog etc

			tar -jcf vs.tar doc lab etc
		}
	}

	return $?
}
