#!/bin/bash
set -e

AWS_PROFILE=personal \
  aws cloudformation deploy \
  --template-file ci/codebuild.yml \
  --stack-name codebuild-utils \
  --capabilities CAPABILITY_IAM \
  --region eu-west-1
