# OSX Dev Machine Playbook

> Inspired by [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook) and [donnemartin/dev-setup](https://github.com/donnemartin/dev-setup).

This repo contains the Ansible playbooks to provision all aspects of my OSX development setup.

### Usage (automatic)

Bootstrap and provision via the command:
```bash
curl -s -L https://git.io/vF3nW | bash -s example
```

### Usage (manual)

Clone this repo into whatever directory you want on your machine then setup your environment:
```bash
./scripts/bootstrap.sh
```

Then provision everything with:
```bash
ansible-playbook -i ansible/inventory ansible/main.yml --ask-become-pass
```

Or you can provision each playbook individually, see **Playbooks** below.

### Playbooks
Playbooks are broken up to be ran independently of each other.  If you want to just provision a specific aspect of your OSX machine, to run any individual playbook use the combined command:
```bash
ansible-playbook -i ansible/inventory <PLAYBOOK>
```

Currently the following playbooks can be used independently:

 - `ansible/playbooks/dock.yml`
 - `ansible/playbooks/dotfiles.yml`
 - `ansible/playbooks/homebrew.yml`
 - `ansible/playbooks/mas.yml --vault-password-file ~/.ansible_vault_pass`
 - `ansible/playbooks/fish-shell.yml --ask-become-pass`
 - `ansible/playbooks/pip.yml --ask-become-pass`
 - `ansible/playbooks/osx-defaults.yml`
