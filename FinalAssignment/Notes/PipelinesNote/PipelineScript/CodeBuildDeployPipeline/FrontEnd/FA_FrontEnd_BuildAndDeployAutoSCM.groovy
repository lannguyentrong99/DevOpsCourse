version: 0.2
env:
  secrets-manager: 
    DOCKERHUB_USERNAME: dockerhub-username-secret_v2
    DOCKERHUB_PASSWORD: dockerhub-password-secret-v2
  parameter-store:
    BUILD_VERSION: FA_Frontend_build_version
    DEPLOY_VERSION: FA_Frontend_deploy_version
phases:
  pre_build:
    commands:
      - echo Logging in to Docker Hub...
      - docker login -u "$DOCKERHUB_USERNAME" -p "$DOCKERHUB_PASSWORD"
      - echo Logging in to Amazon ECR...
      - aws --version
      - aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 556705842113.dkr.ecr.us-west-2.amazonaws.com
      - REPOSITORY_URI=556705842113.dkr.ecr.us-west-2.amazonaws.com/fa_front_end
      - COMMIT_HASH=$(echo $CODEBUILD_RESOLVED_SOURCE_VERSION | cut -c 1-7)
      - EXECUTION_ROLE_ARN=$(aws iam get-role --role-name FA_ECSTaskExecutionRole --query 'Role.Arn' --output text)
      - REGION="us-west-2"
      - LOG_GROUP="ecs/FA_FrontEnd_log_group"
      - LOG_STREAM_PREFIX="frontend-container"
  build:
    commands:
      - echo Build started on `date`
      - echo Building the Docker image...
      - docker build -t fa_front_end:$BUILD_VERSION ./react-student-management/
      - docker tag fa_front_end:$BUILD_VERSION $REPOSITORY_URI:$BUILD_VERSION
      - docker tag fa_front_end:$BUILD_VERSION $REPOSITORY_URI:$COMMIT_HASH

  post_build:
    commands:
      - echo Pushing the Docker image...
      - docker push $REPOSITORY_URI:$BUILD_VERSION
      - docker push $REPOSITORY_URI:$COMMIT_HASH
      - echo Build completed on `date`
      - echo Writing imageDetail.json file...
      - printf '{"ImageURI":"%s"}' $REPOSITORY_URI:$DEPLOY_VERSION > imageDetail.json
      - cat imageDetail.json

      - echo Writing taskdef.json file...
      - |
        cat <<EOF > taskdef.json
        {
          "executionRoleArn": "$EXECUTION_ROLE_ARN",
          "containerDefinitions": [
            {
              "name": "FrontEndContainer",
              "image": "<IMAGE_NAME>",
              "essential": true,
              "portMappings": [
                {
                  "hostPort": 3000,
                  "protocol": "tcp",
                  "containerPort": 3000
                }
              ],
              "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                  "awslogs-group": "$LOG_GROUP",
                  "awslogs-region": "$REGION",
                  "awslogs-stream-prefix": "$LOG_STREAM_PREFIX"
                }
              }
            }
          ],
          "requiresCompatibilities": [
            "FARGATE"
          ],
          "networkMode": "awsvpc",
          "cpu": "256",
          "memory": "512",
          "family": "FA_FrontEnd_TaskDefinition"
        }
        EOF
      - cat taskdef.json
artifacts:
  files: 
    - imageDetail.json
    - appspec.yaml
    - taskdef.json