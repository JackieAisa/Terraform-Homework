resource "aws_iam_user" "lb" {
for_each =toset(["jenny", "jisoo", "lisa", "rose"])
name = each.value
}

resource "aws_iam_user" "lb2" {
for_each =toset(["jihyo", "sana", "momo", "dahyun"])
name = each.value
}

resource "aws_iam_group" "group" {
  name = "blackpink"

}

resource "aws_iam_group" "group2" {
  name = "twice"

}

resource "aws_iam_group_membership" "team" {
  name = "tf-testing-group-membership"

  users = [
    for i in aws_iam_user.lb : i.name
  ]

  group = aws_iam_group.group.name
}

resource "aws_iam_group_membership" "team2" {
  name = "tf-testing-group-membership2"

  users = [
    for i in aws_iam_user.lb2 : i.name
  ]

  group = aws_iam_group.group2.name
}