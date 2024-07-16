// This is a template file for a basic deployment.
// Modify the parameters below with actual values

module "aws-iam-identity-center" {
  source = "git::https://github.com/aws-ia/terraform-aws-iam-identity-center.git"

  // Create desired GROUPS in IAM Identity Center
  sso_groups = {
    DevOps : {
      group_name        = "DevOps"
      group_description = "DevOps IAM Identity Center Group"
    },
    Dev : {
      group_name        = "Dev"
      group_description = "Dev IAM Identity Center Group"
    },
    QA : {
      group_name        = "QA"
      group_description = "QA IAM Identity Center Group"
    },
    Lead : {
      group_name        = "Lead"
      group_description = "Lead IAM Identity Center Group"
    },
  }

  // Create desired USERS in IAM Identity Center
  sso_users = {
    sanjay : {
      group_membership = ["Lead"]
      user_name        = "sanjay"
      given_name       = "sanjay"
      family_name      = "khadka"
      email            = "sanjay@cloudtechservice.com"
    },
    dharmaraj : {
      group_membership = ["QA", "Lead"]
      user_name        = "dharmaraj"
      given_name       = "dharmaraj"
      family_name      = "gurung"
      email            = "dharma@cloudtechservice.com"
    },
    sanjog : {
      group_membership = ["Lead"]
      user_name        = "sanjog"
      given_name       = "sanjog"
      family_name      = "shrestha"
      email            = "sanjog@cloudtechservice.com"
    },
    bimal : {
      group_membership = ["Lead"]
      user_name        = "bimal"
      given_name       = "bimal"
      family_name      = "sharma"
      email            = "bimal@cloudtechservice.com"
    },
    sakshi : {
      group_membership = ["QA", "Lead"]
      user_name        = "sakshi"
      given_name       = "sakshi"
      family_name      = "chaudhary"
      email            = "sakshi@cloudtechservice.com"
    },
    ravi : {
      group_membership = ["DevOps"]
      user_name        = "ravi"
      given_name       = "ravi"
      family_name      = "gupta"
      email            = "ravi@cloudtechservice.com"
    },

    anup : {
      group_membership = ["DevOps"]
      user_name        = "anup"
      given_name       = "anup"
      family_name      = "neupane"
      email            = "anup@cloudtechservice.com"
    },

    sailesh : {
      group_membership = ["DevOps"]
      user_name        = "sailesh"
      given_name       = "sailesh"
      family_name      = "pant"
      email            = "sailesh@cloudtechservice.com"
    },
    dinesh : {
      group_membership = ["DevOps"]
      user_name        = "dinesh"
      given_name       = "dinesh"
      family_name      = "chand"
      email            = "dinesh@cloudtechservice.com"
    },
  }

  // Create permissions sets backed by AWS managed policies
  permission_sets = {
    AdministratorAccess = {
      description          = "Provides AWS full access permissions.",
      session_duration     = "PT4H", // how long until session expires - this means 4 hours. max is 12 hours
      aws_managed_policies = ["arn:aws:iam::aws:policy/AdministratorAccess"]
      tags                 = { ManagedBy = "Terraform" }
    },
    ViewOnlyAccess = {
      description          = "Provides AWS view only permissions.",
      session_duration     = "PT3H", // how long until session expires - this means 3 hours. max is 12 hours
      aws_managed_policies = ["arn:aws:iam::aws:policy/AmazonEC2FullAccess", "arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::aws:policy/AmazonRDSFullAccess", "arn:aws:iam::aws:policy/CloudWatchFullAccess"]
      tags                 = { ManagedBy = "Terraform" }
    },
    CustomPermissionAccess = {
      description      = "Provides CustomPoweruser permissions.",
      session_duration = "PT3H", // how long until session expires - this means 3 hours. max is 12 hours
      aws_managed_policies = [
        "arn:aws:iam::aws:policy/ReadOnlyAccess",
        "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      ]
      #   inline_policy        = data.aws_iam_policy_document.CustomPermissionInlinePolicy.json


      permissions_boundary = {
        // managed_policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"

        customer_managed_policy_reference = {
          name = "ExamplePermissionsBoundaryPolicy"
          // path = "/"
        }
      }
      tags = { ManagedBy = "Terraform" }
    },
  }

  // Assign users/groups access to accounts with the specified permissions
  account_assignments = {
    DevOps : {
      principal_name  = "DevOps"                                  # name of the user or group you wish to have access to the account(s)
      principal_type  = "GROUP"                                   # principal type (user or group) you wish to have access to the account(s)
      principal_idp   = "INTERNAL"                                # type of Identity Provider you are using. Valid values are "INTERNAL" (using Identity Store) or "EXTERNAL" (using external IdP such as EntraID, Okta, Google, etc.)
      permission_sets = ["AdministratorAccess", "ViewOnlyAccess"] # permissions the user/group will have in the account(s)
      account_ids = [                                             # account(s) the group will have access to. Permissions they will have in account are above line
        "992382399471",                                           // replace with your desired account id
        "654654317992",                                           // replace with your desired account id
      ]
    },
    Lead : {
      principal_name  = "Lead"
      principal_type  = "GROUP"
      principal_idp   = "INTERNAL"
      permission_sets = ["ViewOnlyAccess"]
      account_ids = [
        "992382399471",
      ]
    },
  }

}