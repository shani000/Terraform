pipeline {

    parameters {
        string(name: 'environment', defaultValue: 'terraform', description: 'Workspace/environment file to use for deployment')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')

    }


     environment {
        AWS_ACCESS_KEY_ID     = credentials('Access_Key_AWS')
        AWS_SECRET_ACCESS_KEY = credentials('Secret_Key_AWS')
    }

   agent  any
        options {
                timestamps ()
            
            }
    stages {
        stage('checkout') {
            steps {
                 script{
                        dir("terraform")
                        {
                            git "https://github.com/shani000/Terraform.git"
                        }
                    }
                }
            }

        stage('Plan') {
            steps {
                sh 'pwd;terraform init -input=false'
                sh 'pwd;terraform workspace new ${environment}'
                sh 'pwd;terraform workspace select ${environment}'
                sh "pwd;terraform plan -input=false -out tfplan "
                sh 'pwd;terraform show -no-color tfplan > tfplan.txt'
            }
        }
        stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
           }

           steps {
               script {
                    
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }

        stage('Apply') {
            steps {
                sh "pwd; terraform apply -input=false tfplan"
            }
        }
    }

  }
