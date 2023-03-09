resource "aws_s3_bucket" "terra_mpr" {
   bucket = "terraform-mpr-devops"
   versioning {
      enabled = true
   }
} 
resource "aws_s3_object" "alien" {
   bucket = aws_s3_bucket.terra_mpr.id
   key = "press/"
} 


   
