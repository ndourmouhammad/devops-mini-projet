pipeline {
    agent any

    tools {
        maven 'maven-3.9'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/ndourmouhammad/devops-mini-projet.git', branch: 'main'
            }
        }

        stage('Build & Test') {
            steps {
                // 'verify' exécute les tests ET génère le rapport JaCoCo
                sh 'mvn clean verify'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                // Utilise la config 'SonarQube' liée à votre IP 10.154.114.174
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Docker Build') {
            steps {
                // On construit l'image seulement si les tests et Sonar sont OK
                sh 'docker build -t devops-mini-app .'
            }
        }
    }
}