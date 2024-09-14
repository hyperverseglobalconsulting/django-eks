# Generate a random password for PostgreSQL
resource "random_password" "postgresql" {
  length             = 16
  special            = true
  override_special  = "@^*()-_[]{}:;"
  numeric            = true
}

# Store the generated password in AWS SSM Parameter Store
resource "aws_ssm_parameter" "postgresql_password" {
  name  = "/${var.cluster_name}/postgresql/password"
  type  = "SecureString"
  value = random_password.postgresql.result
}
