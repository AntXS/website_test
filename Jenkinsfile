pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'brain-test:latest'
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE, '-f Dockerfile .')
                }
            }
        }
        
        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
		    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                	sh "docker login -u ${DOCKER_HUB_USERNAME} -p ${DOCKER_HUB_PASSWORD}"
                	sh "docker push do12ck34er56/${DOCKER_IMAGE}"
                    }
                }
            }
       } 
        stage('Deploy to Kubernetes') {
	    steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS Credentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    script {
                        sh """
                            export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
                            export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
                            /tmp/kubectl --kubeconfig=/tmp/.kube/config apply -f /tmp/kubernetes/deployment.yaml
                            /tmp/kubectl --kubeconfig=/tmp/.kube/config apply -f /tmp/kubernetes/service.yaml
                           """
                   }
              }
           }
        }
    }
}

