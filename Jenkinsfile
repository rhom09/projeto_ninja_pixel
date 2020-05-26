pipeline {
   agent {
       docker {
           image 'papitoio/robotwd'
           args '--network=skynet'
       }
   }

   stages {
      stage('Build') {
         steps {
            echo 'Baixando as depedẽncias do projeto'
            sh 'pip install -r requirements.txt'
         }
      }
      stage('Test') {
          steps {
             echo 'Executando testes de regressão'
             sh 'robot -d ./logs -v browser:headless frontend/tests/login.robot'
          }
          post {
             always {
               robot otherFiles: '*.png', outputPath: 'logs'
             }
          }
      }
      stage('UAT') {
          steps {
             echo 'Aprovação dos testes de aceitação' 
          }
      }
      stage('Production') {
          steps {
             echo 'WebApp OK em produção!' 
          }
      }
   }
}
