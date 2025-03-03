version: 0.2
env:
  secrets-manager: 
    DOCKERHUB_USERNAME: dockerhub-username-secret_v2
    DOCKERHUB_PASSWORD: dockerhub-password-secret-v2
  parameter-store:
    BUILD_VERSION: FA_Backend_build_version
phases:
  pre_build:
    commands:
      - echo Logging in to Docker Hub...
      - docker login -u "$DOCKERHUB_USERNAME" -p "$DOCKERHUB_PASSWORD"
      - echo Logging in to Amazon ECR...
      - aws --version
      - aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 556705842113.dkr.ecr.us-west-2.amazonaws.com
      - REPOSITORY_URI=556705842113.dkr.ecr.us-west-2.amazonaws.com/fa_back_end
      - COMMIT_HASH=$(echo $CODEBUILD_RESOLVED_SOURCE_VERSION | cut -c 1-7)

  build:
    commands:
      - echo Build started on `date`
      - echo Building the Docker image...
      - docker build -t fa_back_end:$BUILD_VERSION ./spring-boot-student-app-api/
      - docker tag fa_back_end:$BUILD_VERSION $REPOSITORY_URI:$BUILD_VERSION
      - docker tag fa_back_end:$BUILD_VERSION $REPOSITORY_URI:$COMMIT_HASH

  post_build:
    commands:
      - echo Pushing the Docker image...
      - docker push $REPOSITORY_URI:$BUILD_VERSION
      - docker push $REPOSITORY_URI:$COMMIT_HASH
      - echo Build completed on `date`
