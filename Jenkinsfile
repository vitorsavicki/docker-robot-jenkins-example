pipeline {    
 agent {
    label 'master'
  }
    stages {
        stage('Checkout Code') {
             steps {
                checkout scm
            }
        }
        stage('Functional regression tests') {
            agent { docker {
                image 'ppodgorsek/robot-framework:latest'
                args '--shm-size=1g -u root' }
            }
            environment {
                BROWSER = 'chrome'
                ROBOT_TESTS_DIR = "$WORKSPACE/robot-tests"
                ROBOT_REPORTS_DIR = "$WORKSPACE/robot-reports"
            }
            steps {
                //sh '''
                    //opt/robotframework/bin/run-tests-in-virtual-screen.sh
                //'''
                sh "docker run --shm-size=1g -e BROWSER=firefox -v $WORKSPACE/robot-tests:/opt/robotframework/tests:Z -v $WORKSPACE/robot-reports:/opt/robotframework/reports:Z ppodgorsek/robot-framework:latest"
            }
            post {
                always {
                robot outputPath: 'robot-reports', otherFiles: '**/*.png'
                }
            }
        }
    }

}