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

function doctor {
    echo "Checking Dependencies for Usage"
    echo "--------"
    hash ansible-playbook 2>/dev/null || { echo >&2 "ansible-playbook doesn't appear to be installed" }
    hash python 2>/dev/null || { echo >&2 "python doesn't appear to be installed" }
    echo ""
    echo "Checking Development Dependencies"
    echo "--------"
    hash vagrant 2>/dev/null || { echo >&2 "vagrant doesn't appear to be installed" }
    hash ruby 2>/dev/null || { echo >&2 "ruby doesn't appear to be installed" }
    hash pip 2>/dev/null || { echo >&2 "pip doesn't appear to be installed" }
}

function dependencies {
    bundle install
    pip install ansible-lint
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
