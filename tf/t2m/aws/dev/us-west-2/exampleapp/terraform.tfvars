terragrunt = {

  terraform {
    source = "git@github.com:atugade/t2m-modules.git//aws/s3"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }

}

bucket = "arwin-terraform-us-west-2"
role = "droppointtest"
