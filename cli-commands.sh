export AWS_PROFILE=ben
aws s3api create-bucket --bucket benpiper.com-cloudfront
echo "Hello, world!" > index.html
aws s3 cp index.html s3://benpiper.com-cloudfront/
aws s3 website s3://benpiper.com-cloudfront/ --index-document index.html
# http://benpiper.com-cloudfront.s3-website.us-east-1.amazonaws.com/

# Create the OAI

aws cloudfront create-cloud-front-origin-access-identity \
    --cloud-front-origin-access-identity-config \
        CallerReference="demo",Comment="OAI for benpiper.com-cloudfront"

aws s3api put-bucket-policy --bucket benpiper.com-cloudfront --policy file://bucketpolicy.json

# Create the distribution

aws cloudfront create-distribution --distribution-config file://dist-config.json

# Delete the OAI
aws cloudfront get-cloud-front-origin-access-identity --id E2L84P6WV53W4L 
# Note the ETag
aws cloudfront delete-cloud-front-origin-access-identity --id E2L84P6WV53W4L --if-match E32LUAWBC3GN6N

# Delete the bucket
 ws s3 rm s3://benpiper.com-cloudfront/index.html
aws s3api delete-bucket --bucket benpiper.com-cloudfront