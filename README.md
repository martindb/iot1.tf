# Terraform for IOT1

1. Create a new AWS account (ex: account+aws1@gmail.com, name AWS1, don't use same aws "number" twice)
2. From cloudshell install terraform:
```
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
mkdir ~/bin
ln -s ~/.tfenv/bin/* ~/bin/
tfenv install
```
3. Set the default terraform version to default
```
tfenv use x.x.x
```
4. Clone this repo
```
git clone git@github.com:martindb/iot1.tf.git
cd iot1.tf
```
5. Create a new S3 bucket (all default), change bucket in config.s3.tfbackend to it's name.
6. Make the "terraform magic"
```
terraform init -backend-config=./config.s3.tfbackend
terraform plan
terraform apply
```

Optional:
- Create ssh keys and add the public one to github user for easy push from this clone of iot1.tf.


Notes:

Based in this repo: https://github.com/pvarentsov/terraform-aws-free-tier


