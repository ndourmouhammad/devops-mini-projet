pipeline {
    agent any

    tools {
        // Doit correspondre exactement au nom donné dans "Global Tool Configuration"
        maven 'maven-3.9'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/ndourmouhammad/devops-mini-projet.git', branch: 'main'
            }
        }
        stage('Build') {
            steps {
                // 'mvn' sera maintenant reconnu grâce au bloc 'tools'
                sh 'mvn clean package'
            }
        }
        stage('Docker Build') {
            steps {
                // Prochaine étape : construire l'image après le succès de Maven
                sh 'docker build -t devops-mini-app .'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                // Remplacez 'mon-sonar' par le nom exact configuré dans Jenkins
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }

    }
}