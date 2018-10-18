terragrunt = {

  terraform {
    source = "git::https://github.com/atugade/t2m-modules/aws/s3"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }

}

bucket = "arwin-terraform-us-west-2"
role = "droppointtest"
