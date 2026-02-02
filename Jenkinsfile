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
        stage('Deploy to Nexus') {
                    steps {
                        // Vérifiez bien que l'ID est 'nexus-credentials' ou 'nexus-auth' selon ce que vous avez créé
                        withCredentials([usernamePassword(credentialsId: 'nexus-credentials',
                                         passwordVariable: 'NEXUS_PWD',
                                         usernameVariable: 'NEXUS_USER')]) {
                            sh "echo '<settings xmlns=\"http://maven.apache.org/SETTINGS/1.0.0\"><servers><server><id>nexus-releases</id><username>${NEXUS_USER}</username><password>${NEXUS_PWD}</password></server></servers></settings>' > tmp_settings.xml"

                            sh 'mvn deploy -s tmp_settings.xml -DskipTests'

                            sh 'rm tmp_settings.xml'
                        }
                    }
                }
    }
}