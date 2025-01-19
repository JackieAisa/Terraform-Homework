provider aws {
    region = "us-east-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "Bastion-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_s3_bucket" "example" {
  bucket = "kaizen-jackie"
  force_destroy = true 

}

resource "aws_s3_bucket" "manual" {
bucket = "kaizen-jackie2"
}

#terraform import aws_s3_bucket.manual kaizen-jackie2

resource "aws_s3_bucket" "manual2" {
bucket = "kaizen-jackie3"
}

#terraform import aws_s3_bucket.manual2 kaizen-jackie3


resource "aws_iam_user" "lb" {
for_each =toset(["jihyo", "sana", "momo", "dahyun"])
name = each.value
}

resource "aws_iam_group" "group" {
  name = "twice"

}

resource "aws_iam_group_membership" "team" {
  name = "tf-testing-group-membership"

  users = [
    for i in aws_iam_user.lb : i.name
  ]

  group = aws_iam_group.group.name
}