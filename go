#!/bin/bash
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0)

set -e
cd $(dirname $0)

function helptext {
    echo "Usage: ./go <command>"
    echo ""
    echo "available commands are:"
    echo "  ${YELLOW}test${NC}        Run all tests"
    echo "  ${YELLOW}test-fast${NC}   Run only the quick tests"
    echo "  ${YELLOW}doctor${NC}      Check for potential issues"
    echo "  ${YELLOW}deps${NC}        Install development dependencies"
    echo "  ${YELLOW}ec2${NC}         Run EC2 Dynamic Inventory script"
    echo "  ${YELLOW}help${NC}        Display this help message"
}

function doctor {
    echo "Checking Dependencies for Usage"
    echo "--------"
    hash ansible-playbook 2>/dev/null || echo "${RED}ansible-playbook doesn't appear to be installed${NC}"
    hash python 2>/dev/null || echo "${RED}python doesn't appear to be installed${NC}"
    echo ""
    echo "Checking Development Dependencies"
    echo "--------"
    hash vagrant 2>/dev/null || echo "${RED}vagrant doesn't appear to be installed${NC}"
    hash ruby 2>/dev/null || echo "${RED}ruby doesn't appear to be installed${NC}"
    hash virtualenv 2>/dev/null || echo "${RED}virtualenv doesn't appear to be installed${NC}"
}

function dependencies {
    bundle install
    [ -d .venv ] || virtualenv .venv
    source .venv/bin/activate && pip install ansible-lint boto
}

function test-fast {
    # TODO: see if this is actually worthwhile
    ansible-playbook cd-provisioner/site.yml --syntax-check #only syntax, very quick
    source .venv/bin/activate && ansible-lint cd-provisioner/site.yml
    # TODO: make this actually do what I expect it to
    ansible-playbook cd-provisioner/site.yml --check #doesn't execute, but has more logic
}

function _test {
    test-fast
    rake spec
}

function ec2 {
    source .venv/bin/activate && python ec2.py
}

case "$1" in
    help) helptext
    ;;
    test-fast) test-fast
    ;;
    test) _test
    ;;
    doctor) doctor
    ;;
    deps) dependencies
    ;;
    ec2) ec2
    ;;
    *) helptext
    ;;
esac
