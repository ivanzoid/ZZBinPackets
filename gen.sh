#!/bin/sh

program_exists ()
{
	type "$1" &> /dev/null ;
}

main()
{
	set -e

	if program_exists go; then
		go build genpackets.go
	fi

	rm -rf generated
	mkdir -p generated
	pushd generated >/dev/null

	../genpackets ../packets.txt

	popd >/dev/null
}	

main "$@"

