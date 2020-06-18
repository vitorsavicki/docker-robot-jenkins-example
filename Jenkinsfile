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
                BROWSER = 'firefox'
                ROBOT_TESTS_DIR = "$WORKSPACE/robot-tests"
                ROBOT_REPORTS_DIR = "$WORKSPACE/robot-reports"
            }
            steps {
                sh '''
                    /opt/robotframework/bin/run-tests-in-virtual-screen.sh
                '''
            }
        }
        stage('Publish Robot results') {
            steps {
                script {
                step(
                    [
                    $class              : 'RobotPublisher',
                    outputPath          : 'robot-reports',
                    outputFileName      : "**/output.xml",
                    reportFileName      : '**/report.html',
                    logFileName         : '**/log.html',
                    disableArchiveOutput: false,
                    passThreshold       : 95.0,
                    unstableThreshold   : 90.0,
                    otherFiles          : "**/*.png,**/*.jpg",
                    ]
                )
                }
            }
        }
    }

}