#A Neato CD Provisioner

The old [GoCD ansible playbook](https://github.com/gocd-contrib/ansible-gocd) is a little
the worse for wear (largely my fault), so this is the cool new does a bunch more things
version. Also it's not meant to be a plug-and-play Ansible Galaxy thing, the goal is to
be an accelerator that bootstraps you to a production ready GoCD instance with artifact
repository, so we can afford to be a bit more opinionated.

Immediate goal is to use Ansible + Terraform with AWS as the IaaS provider, but at the
very least I want to support Azure in the future as well. Secondary concerns are alt.
artifact repository options, maybe even a Jenkins 2 provisioner. Still entirely
undecided on if we'll get into the container business.

##To Use
Everything more or less happens through `./go` but it's all pretty nascent at the moment.
`./go doctor` will tell you about things you need to install that it's not going to install
for you.
