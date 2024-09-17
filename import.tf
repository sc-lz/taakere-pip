resource "aws_controltower_control" "example" {
    control_identifier = "unknown"
    target_identifier  = "unknown"
}


# terraform import 'aws_controltower_control.imported_controls[<control_identifier>]' <control_identifier>:<target_identifier>

# arn:aws:controlcatalog:::control/b7a0rdepu2tfjgo0ddxo9waw0

# terraform import aws_controltower_control.guardrails arn:aws:organizations::268702346055:ou/o-9ao1kn1kyw/ou-nmu5-5l01e2ro,arn:aws:controlcatalog:::control/b7a0rdepu2tfjgo0ddxo9waw0