pipeline {
    agent any

    stages {
        stage('CI') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'password', usernameVariable: 'username')]) {
                
                    sh """
                    sudo docker build . -t sarahouf/jenkins_test:1.0 -S
                    sudo docker login --username ${username} --password ${password} -S
                    sudo docker push sarahouf/jenkins_test:1.0 -S
                    """
                }
            }
        }
        stage('CD') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'password', usernameVariable: 'username')]) {
                
                    sh """
                    sudo docker run -d -p 8000:8000 sarahouf/jenkins_test:1.0 -S
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
