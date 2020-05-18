pipeline {
   agent {
       docker {
           image 'python'
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
             sh 'robot -d ./logs backend/tests/'
          }
      }
      stage('UAT') {
          steps {
             echo 'Aprovação dos testes de aceitação' 
          }
      }
      stage('Production') {
          steps {
             echo 'API OK em produção!' 
          }
      }
   }
}
