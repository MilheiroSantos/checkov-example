# checkov-example
A starter template for running Terraform and Checkov in Azure

# How to run the example
Install Checkov with:
```shell
$ pip install checkov
```
On the `example_storage_account/src` folder, create the tfplan with the input variable `environment` set to `dev`:
```shell
$ terraform init && terraform plan --var environment=dev --out terraform.tfplan.binary
```
Convert the binary tfplan to JSON with:
```shell
$ terraform show --json terraform.tfplan.binary | jq '.' > terraform.tfplan.json
```
On the `example_storage_account` folder, run Checkov with the plan and custom policies with:
```shell
$ checkov -f src/terraform.tfplan.json --external-checks-dir policies
```
