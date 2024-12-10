def runStage() {
   // Fetch the list of changed files from the last two commits
   def CHANGE_SET = sh(
      script: 'git diff --name-only HEAD~1 HEAD',
      returnStdout: true
   ).trim()
   
   echo "Current changeset: ${CHANGE_SET}"
   
   // Check for changes in specified directories or files 
   return CHANGE_SET =~ /(.*modules.*|Jenkinsfile)/
}
pipeline {
    agent any
    environment {
        AZURE_CLIENT_ID     = credentials('azure-client-id')
        AZURE_CLIENT_SECRET = credentials('azure-client-secret')
        AZURE_TENANT_ID     = credentials('azure-tenant-id')
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


        // stage('Login to Azure') {
        //     steps {
        //         script {
        //             // Use service principal or interactive login
        //             sh '''
        //                 az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID
        //             '''
        //         }
        //     }
        // }

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
                        terraform plan -out=tfplan -var="AZURE_SUBSCRIPTION_ID=${AZURE_SUBSCRIPTION_ID}" \
                            -var="AZURE_CLIENT_ID=${AZURE_CLIENT_ID}" \
                            -var="AZURE_CLIENT_SECRET=${AZURE_CLIENT_SECRET}" \
                            -var="AZURE_TENANT_ID=${AZURE_TENANT_ID}"
                    """
                }
            }
        }

        // stage('Terraform Apply') {
        //     when { 
        //         expression { runStage() }
        //     }
        //     steps {
        //         script {
        //             sh 'terraform apply -auto-approve tfplan'
        //         }
        //     }
        // }

        // stage('Terraform Destroy') {
        //     when { 
        //         expression { runStage() }
        //     }
        //     when {
        //         // Destroy resources only if you want to trigger it explicitly
        //         expression {
        //             return params.DESTROY == 'true'
        //         }
        //     }
        //     steps {
        //         script {
        //             // Destroy resources if DESTROY parameter is true
        //             sh 'terraform destroy -auto-approve'
        //         }
        //     }
        // }
        // stage('Upload State to S3') {
        //     steps {
        //         script {
        //             sh 'aws s3 cp terraform.tfstate s3://your-bucket-name'
        //         }
        //     }
        // }
    }
    post {
        always {
            cleanWs()
        }
    }
}