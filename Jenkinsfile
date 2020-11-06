pipeline {
  environment { 
    artifactName = '' 
  }
  agent { dockerfile true }
  stages {
    stage('Building image') {
      steps{
        script {
          sh "mvn package"
        }
      }
    }
    stage('Building our image') { 
      steps { 
        script { 
          artifactName = "hello-docker-" + ":$BUILD_NUMBER" 
        }
      } 
    }
    stage('Deploy Image') {
      steps{
        script {        
        withCredentials([usernamePassword(credentialsId: '836c9950-2e83-42d9-a478-dbb0cc340524', usernameVariable: 'TOMCAT_USER', passwordVariable: 'TOMCAT_PASSWORD')]) {
        sh """/bin/bash
          CURL_RESPONSE=\$(curl -v -u $TOMCAT_USER:$TOMCAT_PASSWORD -T target/*.war "http://35.228.246.245:80/manager/text/deploy?path=/${artifactName}&update=true")    
          if [[ \$CURL_RESPONSE == *"FAIL"* ]]; then
            echo "war deployment failed"
            exit 1
          else    
            echo "war deployed successfully "
            exit 0
          fi
        """
          }
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
