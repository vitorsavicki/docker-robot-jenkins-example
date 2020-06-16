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

    stage(’Test’) {
      steps {
<<<<<<< HEAD
        sh ‘robot -d out/ my_test/’
=======
        sh 'cat docker-compose.yml'
        sh "docker-compose run robot"
>>>>>>> fb11deb8c6e4563d0c96b8e2a45819f0753a4146
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
