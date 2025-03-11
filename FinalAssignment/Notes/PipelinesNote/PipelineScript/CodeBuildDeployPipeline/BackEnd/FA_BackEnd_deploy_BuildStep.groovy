version: 0.2
env:
  parameter-store:
    DEPLOY_VERSION: FA_Backend_deploy_version
    
phases:
  pre_build:
    commands:
      - REPOSITORY_URI=556705842113.dkr.ecr.us-west-2.amazonaws.com/fa_back_end
  post_build:
    commands:
      - echo Writing imageDetail.json file...
      - printf '{"ImageURI":"%s"}' $REPOSITORY_URI:$DEPLOY_VERSION > imageDetail.json
      - cat imageDetail.json
artifacts:
  files: 
    - imageDetail.json
    - appspec.yaml
    - taskdef.json