resource "aws_iam_role" "ec2_s3_access_role" {
  name               = "s3-role"
  assume_role_policy = file("templates/assumerolepolicy.json")
}

resource "aws_iam_policy" "allow_s3_all" {
  name        = "allow-s3-all-policy"
  description = "Allow all access to s3"
  policy      = file("templates/policys3bucket.json")
}

resource "aws_iam_policy" "allow_cloudwatch_logging" {
  name        = "allow-cloudwatch-policy"
  description = "Allow sending logs to cloudwatch"
  policy      = file("templates/cloudwatch_policy.json")
}

resource "aws_iam_policy_attachment" "ec2-s3-attachment" {
  name       = "ec2-s3-attachment"
  roles      = [aws_iam_role.ec2_s3_access_role.name]
  policy_arn = aws_iam_policy.allow_s3_all.arn
}

resource "aws_iam_policy_attachment" "ec2-cloudwatch-attachment" {
  name       = "ec2-cloudwatch-attachment"
  roles      = [aws_iam_role.ec2_s3_access_role.name]
  policy_arn = aws_iam_policy.allow_cloudwatch_logging.arn
}

resource "aws_iam_instance_profile" "ec2_s3_access_profile" {
  name = "ec2_s3_access_profile"
  role = aws_iam_role.ec2_s3_access_role.name
}
