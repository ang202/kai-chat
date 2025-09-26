pipeline {
    agent any
    
    environment {
        PATH = "/opt/homebrew/bin:$PATH" // Add Fastlane path to the environment
    }
    
    stages {
        
        stage('Get Git Branch') { 
            steps {
                script {
                    // Print the Git branch for debugging
                    echo "Current Git Branch: ${env.GIT_BRANCH}"
                }
            }
        }
        
        stage('Setup Files') { 
            steps {
                script {
                    // Copy keystore and service account files
                    withCredentials([file(credentialsId: 'kai-chat-keystore', variable: 'KEYSTORE_FILE')]) {
                        sh """
                        mkdir -p android
                        cp \$KEYSTORE_FILE android/upload-keystore.jks
                        """
                    }
                    // Create environment files and key properties file
                    sh """
                    touch .env.dev
                    touch .env.uat
                    touch .env.prod
                    touch android/key.properties
                    
                    echo 'storePassword=password
                    keyPassword=password
                    keyAlias=upload
                    storeFile=../upload-keystore.jks' > android/key.properties
                    """
                    
                    // Append to .env files
                    withCredentials([string(credentialsId: 'kai-chat-env', variable: 'ENV_SECRET')]) {
                        sh """
                        for file in .env.dev .env.uat .env.prod; do
                            echo "\$ENV_SECRET" >> \$file
                        done
                        """
                    }
                }
            }
        }

        stage('Start build tag app') {
            when {
                buildingTag()
            }
            steps {
                script {
                    echo "Building from tag: ${env.GIT_TAG}"
                    def tag = env.GIT_TAG

                    echo "Raw tag: ${tag}"

                    // Regex: 1.0.0-dev.1 → groups: (1.0.0) (dev) (1)
                    def matcher = tag = ~/(\d+\.\d+\.\d+)-(\w+)\.(\d+)/

                    if (!matcher.matches()) {
                        error "Tag format invalid: ${tag}"
                    }

                    def baseVersion = matcher[0][1] // 1.0.0
                    def environment = matcher[0][2] // dev
                    def buildNum = matcher[0][3] // 1

                    echo "Base version   = ${baseVersion}"
                    echo "Environment    = ${environment}"
                    echo "Build number   = ${buildNum}"
                }
            }
        }
        
        stage('Start build app') {
            when {
                expression { env.GIT_BRANCH == "origin/test/jenkins" || env.GIT_BRANCH == "test/jenkins" }
            }
            steps {
                echo "Current Git Tag: ${env.GIT_BRANCH}"
                script {
                    // Run Flutter commands and Fastlane
                    sh """
                    flutter pub get
                    cd android
                    fastlane buildDevApk
                    """
                    echo "Yahoo! App build success!"
                }
            }
        }

        // Add on more build steps eg:test
    }
    
    post {
        always {
            echo 'Pipeline completed.'
            cleanWs()   // Clean workspace after build
        }
    }
}