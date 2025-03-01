pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/lannguyentrong99/nodejs-random-color2.git'
            }
        }

        stage('Build') {
            steps {
                sh 'docker build -t nodejs-random-color:ver-${BUILD_ID} .'
            }
        }
        stage('Upload image to ECR') {
            steps {
                sh 'aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 556705842113.dkr.ecr.us-west-2.amazonaws.com'
                sh 'docker tag nodejs-random-color:ver-${BUILD_ID} 556705842113.dkr.ecr.us-west-2.amazonaws.com/nodejs-random-color:ver-${BUILD_ID}'
                sh 'docker push 556705842113.dkr.ecr.us-west-2.amazonaws.com/nodejs-random-color:ver-${BUILD_ID}'
            }
        }
    }
}
