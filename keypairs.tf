resource "aws_key_pair" "ssh_key" {
  key_name   = "patra-key"
  public_key = file("templates/id_rsa.pub")
}
