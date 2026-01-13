data "aws_caller_identity" "current" {
  lifecycle {
    postcondition {
      condition     = self.account_id == var.account_id
      error_message = "Account ID mismatch! Please make sure you are using the correct AWS account."
    }
  }
}

data "aws_region" "current" {
  lifecycle {
    postcondition {
      condition     = self.region == var.region
      error_message = "Region mismatch! Please make sure you are using the correct region."
    }
  }
}
