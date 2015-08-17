#!/usr/bin/env bash

# Time-stamp: <2015-08-17 11:19:20 Monday by ahei>

# @file (>>>FILE<<<)
# @version 1.0
# @author ahei

readonly PROGRAM_NAME="(>>>FILE<<<)"
readonly PROGRAM_VERSION="1.0.0"

home=`cd $(dirname "$0") && pwd`

. "$home"/util.sh

usage()
{
    local code=1
    local redirect
    
    if [ $# -gt 0 ]; then
        code="$1"
    fi

    if [ "$code" != 0 ]; then
        redirect="1>&2"
    fi

    eval cat "$redirect" << EOF
usage: ${PROGRAM_NAME} [OPTIONS]

Options:
    -v  Output version info.
    -h  Output this help.
EOF

    exit "$code"
}

options=":hv"
eval set -- $(getopt -o "$options" -- "$@")
while getopts "$options" OPT; do
    case "$OPT" in
        v)
            version
            ;;

        h)
            usage 0
            ;;

        :)
            case "${OPTARG}" in
                ?)
                    echoe "Option \`-${OPTARG}' need argument.\n"
                    usage
            esac
            ;;

        ?)
            echoe "Invalid option \`-${OPTARG}'.\n"
            usage
            ;;
    esac
done

shift $((OPTIND - 1))

(>>>POINT<<<)
