pipeline {
  agent any
  stages {
    stage('Building package') {
      steps{
        script {
          sh "mvn package"
        }
      }
    }
    stage('Deploy package') {
      steps{
        script {        
        withCredentials([usernamePassword(credentialsId: '836c9950-2e83-42d9-a478-dbb0cc340524', usernameVariable: 'TOMCAT_USER', passwordVariable: 'TOMCAT_PASSWORD')]) {
        sh """
          CURL_RESPONSE=\$(curl -v -u $TOMCAT_USER:$TOMCAT_PASSWORD -T target/*.war "http://35.228.246.245:80/manager/text/deploy?path=/helloo&update=true")    
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
}
