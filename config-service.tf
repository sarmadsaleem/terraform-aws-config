#
# AWS Config Service
#

resource "aws_config_configuration_recorder_status" "main" {
  provider = "aws.selected"

  name       = "aws-config"
  is_enabled = true
  depends_on = ["aws_config_delivery_channel.main"]
}

resource "aws_config_delivery_channel" "main" {
  provider = "aws.selected"

  name           = "aws-config"
  s3_bucket_name = "${var.config_logs_bucket}"
  s3_key_prefix  = "${var.config_logs_prefix}"

  snapshot_delivery_properties {
    delivery_frequency = "${var.config_delivery_frequency}"
  }

  depends_on = ["aws_config_configuration_recorder.main"]
}

resource "aws_config_configuration_recorder" "main" {
  provider = "aws.selected"

  name     = "aws-config"
  role_arn = "${aws_iam_role.main.arn}"

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}
