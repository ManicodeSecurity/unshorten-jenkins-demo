pipeline {
    agent none
      stages { 
        stage('Example') {
            agent { 
                docker {
                    label 'docker' 
                    image 'alpine'                    
                }
             }
            steps {
                sh 'env'
            }
        }
    }
}