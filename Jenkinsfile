pipeline {



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
       

        stage('Apply') {
            steps {
                sh "pwd; terraform apply -input=false tfplan"
            }
        }
    

  }
  }
