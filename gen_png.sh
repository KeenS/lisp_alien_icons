#!/bin/sh
# templated by http://qiita.com/blackenedgold/items/c9e60e089974392878c8
usage() {
    cat <<HELP
NAME:
   $0 -- generate PNG images

SYNOPSIS:
  $0 [-h|--help]
  $0 [--verbose]

DESCRIPTION:
   generate PNG images with inkscape.

  -h  --help      Print this help.
      --verbose   Enables verbose mode.


HELP
}

main() {
    SCRIPT_DIR="$(cd $(dirname "$0"); pwd)"

    while [ $# -gt 0 ]; do
        case "$1" in
            --help) usage; exit 0;;
            --verbose) set -x; shift;;
            --) shift; break;;
            -*)
                OPTIND=1
                while getopts h OPT "$1"; do
                    case "$OPT" in
                        h) usage; exit 0;;
                    esac
                done
                shift
                ;;
            *) break;;
        esac
    done

    if ! command -v inkscape > /dev/null 2>&1; then
        echo "install inkscape"
        exit 1
    fi

    for f in *.svg; do
        echo -e "$(basename $f .svg).png" "$f"
    done | inkscape --shell
}

main "$@"

