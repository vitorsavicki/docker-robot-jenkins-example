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
        stage('Proccess Results') {		
            steps {
                script{
                    //bat 'del "Results\\*.zip'
                    zip zipFile: "$WORKSPACE/results/results.zip", archive: false, dir: "$WORKSPACE/results" , glob: '*.html'
                    step(
                        [
                            $class              : 'hudson.plugins.robot.RobotPublisher',
                            outputPath          : "$WORKSPACE/robot_reports",
                            outputFileName      : "output.xml",
                            reportFileName      : 'report.html',
                            logFileName         : 'log.html',
                            disableArchiveOutput: false,
                            passThreshold       : 95.0,
                            unstableThreshold   : 90.0,
                            otherFiles          : "**/*.png,**/*.jpg",
                        ]
                    )
                //emailext body: '${SCRIPT, template="robot.template"}', subject: "[Jenkins] Robot Framework testresults for Docker Demo Project", to: 'stefan.mandovski@interworks.com.mk', recipientProviders: [[$class: 'CulpritsRecipientProvider']], attachmentsPattern: 'results/results.zip'
                }
            }
        }
    }
    //post {
        //always {
            //archive (includes: 'robot_reports/*.html')
        //}
    //}
}