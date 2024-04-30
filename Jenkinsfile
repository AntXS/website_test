pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    docker.build('my-website:latest')
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run Docker container
                    docker.image('my-website:latest').run('-d -p 80:80 --name my-website-container')
                }
            }
        }

        stage('Run Tests') {
            steps {
                // Run tests (e.g., using curl or a testing framework)
                sh 'curl http://localhost' // Example of a simple test
            }
        }

	stage('Publish Website') {
            steps {
                // Example: Copy website files to a web server
                sh 'scp -r /root/remote_sets/* root@192.168.230.133:/var/www/html'
            }
        }
    }

    post {
        always {
            // Clean up: Stop and remove the Docker container
            script {
                docker.image('my-website:latest').stop()
                docker.container('my-website-container').remove()
            }
        }
    }
}
