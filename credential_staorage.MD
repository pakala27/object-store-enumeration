Managing credentials is one of the important task. In this project, I mentioned credentials as plaintext for this project. but,
I shall propose to manage these credentials by using below tools. We shouldn't store credentials(unencrypted) in Git.

1. SOPS for kubenetes objects

SOPS is an editor of encrypted files that supports YAML, JSON, ENV, INI and encrypts with AWS KMS, PGP etc.

So it is meant to encrypt/decrypt sensitive values in config files.
Concepts:
- Having private private and public keypair
- Publickey is for encrypt secrets
- Private key is for decrypt secrets and it has to be kept in secret place

2. Terraform vault

I am not completely sure about it to describe more on this but we can use terraform vault feature for managing secrets in terraform code.
I use ansible vault feature for my ansible code for around 3 years and it worked well.

Desclaimer: 
As per the CICD_with_GitOps.pptx file, We maintain code in two git repos: one for code repo(terraform)
But, I mentioned everything in same Git repo for this challenge.