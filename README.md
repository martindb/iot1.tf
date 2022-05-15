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
git clone https://github.com/martindb/iot1.tf.git
cd iot.tf
```
5. Make the "terraform magic"
```
terraform init
terraform plan
terraform apply
```


Notes:

Based in this repo: https://github.com/pvarentsov/terraform-aws-free-tier


