pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/hoanglinhdigital/simple-vue-webpack.git'
            }
        }
        // Step clear workspace này được thêm vào sau để xử lý một issue khi build và deploy mà không thấy thay đổi ở UI
        stage('Clear workspace') {
            steps {
                sh 'rm -rf ${WORKSPACE}/dist'
            }
        }
        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }
        stage('Upload Artifacts') {
            steps {
                // Upload the artifact to S3
                sh 'aws s3 cp ${WORKSPACE}/dist/ s3://udemy-lan-test-web-hosting-1/ --recursive'
            }
        }
    }
}
