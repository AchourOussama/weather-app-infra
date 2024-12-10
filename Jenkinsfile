def runStage() {
   // Fetch the list of changed files from the last two commits
   def CHANGE_SET = sh(
      script: 'git diff --name-only HEAD~1 HEAD',
      returnStdout: true
   ).trim()
   
   echo "Current changeset: ${CHANGE_SET}"
   
   // Check for changes in specified directories or files 
   return CHANGE_SET =~ /(.*terraform.*)/
}
pipeline {
    agent any
    // environment {
    //     AWS_DEFAULT_REGION = 'your-aws-region'
    // }
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        
        stage('Terraform Plan') {
            when { 
                expression { runStage() }
            }
            steps {
                script {
                    sh 'terraform plan -out=tfplan'
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