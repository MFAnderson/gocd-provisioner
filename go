#!/bin/bash

set -e
cd $(dirname $0)

function helptext {
    echo "Usage: ./go <command>"
    echo ""
    echo "available commands are:"
    echo "  test        Run all tests"
    echo "  test-fast   Run only the quick tests"
    echo "  help        Display this help message"
}

function test-fast {
    ansible-playbook cd-provisioner/site.yml --syntax-check #only syntax, very quick
    ansible-playbook cd-provisioner/site.yml --check #doesn't execute, but has more logic
}

function _test {
    test-fast
    rake spec
}

case "$1" in
    help) helptext
    ;;
    test-fast) test-fast
    ;;
    test) _test
    ;;
    *) helptext
    ;;
esac
