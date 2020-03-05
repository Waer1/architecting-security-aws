# Use the following commands to delete the OAI and bucket. You must delete the distribution manually.

# Delete the OAI
aws cloudfront get-cloud-front-origin-access-identity --id 
# Note the ETag value and specify it for the "--if-match" parameter.
aws cloudfront delete-cloud-front-origin-access-identity --id --if-match

# Delete the bucket
aws s3 rm s3://yourbuckethere/index.html
aws s3api delete-bucket --bucket yourbuckethere