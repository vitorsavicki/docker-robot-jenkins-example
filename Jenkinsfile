pipeline {
 agent {
    label 'master'
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Test') {
      steps {

        sh  'robot -d out/ my_test/'

      }
    }

  }

  post {
    always {
      step([$class: 'RobotPublisher',
            disableArchiveOutput: false,
            logFileName: 'results/log.html',
            onlyCritical: true,
            otherFiles: 'results/*.png',
            outputFileName: 'results/output.xml',
            outputPath: '.',
            passThreshold: 90,
            reportFileName: 'results/report.html',
            unstableThreshold: 100
            ])
    }
  }
}
