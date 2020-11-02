def COLOR_MAP = ['SUCCESS': 'good', 'FAILURE': 'danger']
def getBuildUser() {
  return currentBuild.rawBuild.getCause(Cause.UserIdCause).getUserId()
}

pipeline {
  // Set up local variables for your pipeline
  environment {
    // test variable: 0=success, 1=fail; must be string
    doError = '0'
    BUILD_USER = ''
  }
  agent any
  stages {
    stage('SonarStaticCodeAnalysis') {
      environment {
        SCANNER_HOME = tool 'sonarqube'
        ORGANIZATION = "devops-demo"
        PROJECT_NAME = "jenkins-declarative-pipeline-demo"
      }
      steps {
        withSonarQubeEnv('sonarserver') {
          sh "$SCANNER_HOME/bin/sonar-scanner -Dsonar.organization=$ORGANIZATION \
        -Dsonar.projectKey=$PROJECT_NAME \
        -Dsonar.sources=. \
		-Dsonar.tests=. \
		-Dsonar.inclusions=**/test/java/servlet/createpage_junit.java \
		-Dsonar.test.exclusions=**/test/java/servlet/createpage_junit.java \
		-Dsonar.login=admin \
		-Dsonar.password=admin"
        }
      }
    }
    stage('Stage 2') {
      steps {
        script {
          echo 'Stage 2'
        }
      }
    }
    stage('Error') {
      // when doError is equal to 1, return an error
      when {
        expression {
          doError == '1'
        }
      }
      steps {
        echo "Failure :("
        error "Test failed on purpose, doError == str(1)"
      }
    }
    stage('Success') {
      // when doError is equal to 0, just print a simple message
      when {
        expression {
          doError == '0'
        }
      }
      steps {
        echo "Success :)"
      }
    }
  }
  // Post-build actions
  post {
    always {
      slackSend teamDomain: 'my-personalglobal',
      tokenCredentialId: 'slack',
      channel: '#alerts',
      color: COLOR_MAP[currentBuild.currentResult],
      message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
    }
  }
}
