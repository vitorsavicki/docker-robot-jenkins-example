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
        stage('Execute Tests') {
            steps{
                sh 'docker run -v ${PWD}/:/opt/robotframework/ interworks/rfrunner'
            }
        }
        stage('Proccess Results') {		
            steps {
                script{
                    bat 'del "Results\\*.zip'
                    zip zipFile: 'results/results.zip', archive: false, dir: 'results', glob: '*.html'
                    step(
                        [
                            $class              : 'RobotPublisher',
                            outputPath          : 'results',
                            outputFileName      : "output.xml",
                            reportFileName      : 'report.html',
                            logFileName         : 'log.html',
                            disableArchiveOutput: false,
                            passThreshold       : 95.0,
                            unstableThreshold   : 90.0,
                            otherFiles          : "**/*.png,**/*.jpg",
                        ]
                    )
                emailext body: '${SCRIPT, template="robot.template"}', subject: "[Jenkins] Robot Framework testresults for Docker Demo Project", to: 'stefan.mandovski@interworks.com.mk', recipientProviders: [[$class: 'CulpritsRecipientProvider']], attachmentsPattern: 'results/results.zip'
                }
            }
        }
    }
    post {
        always {
            archive (includes: 'results/*.html')
        }
    }
}
