#!/bin/bash
# ENABLE CCACHE
	if test -x `which ccache`; then
		echo "Using ccache"
		if [ -f /usr/lib/ccache/bin ]; then
			export PATH=/usr/lib/ccache/bin/:$PATH
			echo "CCACHE BINARIES LOCATED IN /USR/LIB/CCACHE/BIN"
		else
			export PATH=/usr/lib/ccache/:$PATH
			echo "CCACHE BINARIES LOCATED IN /USR/LIB/CCACHE"
		fi
	else
		echo "NOT USING CCACHE, INCREASE BUILD TIME"
	fi
	
	# GET NUMBER CORES
	CORES=`grep processor /proc/cpuinfo | wc -l`
	
	MAKEOPT=2
	if [ "$1" == "fast" ]; then
		# SET MAKE PROCESSES - 1 + NUMBER OF CORES
		MAKEOPT=$(($CORES + 1))
	fi
	
	echo ""
	echo "Start building on $CORES cores, using $MAKEOPT processes"
	echo ""
	make V=0 -j $MAKEOPT