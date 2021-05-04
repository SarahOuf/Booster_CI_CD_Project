pipeline {
    agent any

    stages {
        stage('CI') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'password', usernameVariable: 'username')]) {
                
                    sh """
                    sudo docker build . -t sarahouf/jenkins_test:1.0
                    sudo docker login --username ${username} --password ${password}
                    sudo docker push sarahouf/jenkins_test:1.0
                    """
                }
            }
        }
        stage('CD') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'password', usernameVariable: 'username')]) {
                
                    sh """
                    sudo docker run -d -p 8000:8000 sarahouf/jenkins_test:1.0
                    """
                }
            }
            post {
                success {
                    slackSend (color: "#008000", message: "pipeline is done")
                }
            }
        }
    }
}
