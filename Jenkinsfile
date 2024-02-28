pipeline {
    agent any 
    stages {
        stage('Build') { 
            steps {
                echo "This is the build steps"
            }
        }
        stage('Test') { 
            steps {
                echo "This is the test steps"
            }
        }
        stage('Deploy') { 
            steps {
                echo "This is the deploy steps"
                echo env.GIT_BRANCH
            }
        }
        stage('Run when on branch test'){
            when {
                expression { env.GIT_BRANCH ==  "origin/test/jenkins" }
            }
            steps {
                sh"""
                flutter pub get
                cd android
                fastlane buildApk
                """
                echo "Yahoo! Run on branch test"
            }
        }
    }
}