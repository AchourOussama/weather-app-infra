def runStage() {
   // Fetch the list of changed files from the last two commits
   def CHANGE_SET = sh(
      script: 'git diff --name-only HEAD~1 HEAD',
      returnStdout: true
   ).trim()
   
   echo "Current changeset: ${CHANGE_SET}"
   
   // Check for changes in specified directories or files 
   return CHANGE_SET =~ /(.*modules.*|Jenkinsfile)|main.tf/
}
pipeline {
    agent any
    environment {
        AZURE_SUBSCRIPTION_ID = credentials('subscription-id')
    }
    
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
      
        stage('Install Azure CLI') {
            steps {
                script {
                    // Check if az CLI is already installed
                    def azInstalled = sh(script: 'which az', returnStatus: true)
                    if (azInstalled != 0) {
                        echo 'Azure CLI not found. Installing...'
                        // Install Azure CLI if not found
                        sh '''
                            curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
                        '''
                    } else {
                        echo 'Azure CLI is already installed.'
                    }
                }
            }
        }

        stage('Install Terraform') {
            steps {
                sh '''
                    # Set Terraform version
                    terraformVersion="1.10.1"
                    
                    # Check if Terraform exists, otherwise install it
                    if ! command -v terraform >/dev/null 2>&1; then
                        echo "Terraform not found. Installing..."
                        curl -LO "https://releases.hashicorp.com/terraform/${terraformVersion}/terraform_${terraformVersion}_linux_arm64.zip"
                        unzip -o terraform_${terraformVersion}_linux_arm64.zip
                        chmod u+x terraform
                        mv ./terraform /usr/local/bin/
                    else
                        echo "Terraform is already installed."
                    fi
                    
                    # Display the Terraform version
                    terraform version
                '''
            }
        }
        stage('Terraform Init') {
            when {
                expression { runStage() }
            }
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            when { 
                expression { runStage() }
            }
            steps {
                script {
                    sh """
                        terraform plan -out=tfplan -var="AZURE_SUBSCRIPTION_ID=${AZURE_SUBSCRIPTION_ID}"
                    """
                }
            }
        }

        stage('Waiting for Approval'){
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    input (message: "Deploy the infrastructure?")
                }
            }

        }

        stage('Terraform Apply') {
            when { 
                expression { runStage() }
            }
            steps {
                script {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}