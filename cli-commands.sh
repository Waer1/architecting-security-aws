export AWS_PROFILE=ben

# Create S3 bucket
aws s3api create-bucket --bucket benpiper.com-cloudfront

# Create and uplaod index.html document
echo "Hello, world!" > index.html
aws s3 cp index.html s3://benpiper.com-cloudfront/

# Create the origin access identity (OAI)
aws cloudfront create-cloud-front-origin-access-identity \
    --cloud-front-origin-access-identity-config \
        CallerReference="demo",Comment="OAI for benpiper.com-cloudfront"

# Apply a bucket policy granting read access to the OAI
aws s3api put-bucket-policy --bucket benpiper.com-cloudfront --policy file://bucketpolicy.json

# Create a CloudFront distribution
aws cloudfront create-distribution --distribution-config file://dist-config.json