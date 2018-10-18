terragrunt = {
  remote_state {
    backend = "s3"
    config {
      encrypt        = true
      bucket         = "terraform-state-arwin-test"
      key            = "${path_relative_to_include()}/../terraform.tfstate"
      region         = "us-west-2"
      dynamodb_table = "terraform-locks"
      role_arn       = "arn:aws:iam::515528212812:role/NEOAdmin"
    }
  }

  terraform {
    extra_arguments "bucket" {
      commands = ["${get_terraform_commands_that_need_vars()}"]
      optional_var_files = [
        "${get_tfvars_dir()}/${find_in_parent_folders("account.tfvars", "ignore")}",
        "${get_tfvars_dir()}/${find_in_parent_folders("globals.tfvars", "ignore")}",
        "${get_tfvars_dir()}/${find_in_parent_folders("region.tfvars", "ignore")}",
      ]
    }
  }

  after_hook "run_ansible" {
    commands = ["apply-all"]
    execute = ["echo", "testing"]
    run_on_error = true
  }
}
