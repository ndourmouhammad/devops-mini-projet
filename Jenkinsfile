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
                // Jenkins récupère le login/pass de l'ID 'nexus-auth'
                withCredentials([usernamePassword(credentialsId: 'nexus-credentials',
                                 passwordVariable: 'NEXUS_PWD',
                                 usernameVariable: 'NEXUS_USER')]) {

                    // On crée un settings.xml temporaire uniquement pour cette commande
                    sh """
                    echo '<settings>
                            <servers>
                                <server>
                                    <id>nexus-releases</id>
                                    <username>${NEXUS_USER}</username>
                                    <password>${NEXUS_PWD}</password>
                                </server>
                            </servers>
                          </settings>' > tmp_settings.xml
                    """

                    // On déploie en utilisant ce fichier temporaire
                    sh 'mvn deploy -s tmp_settings.xml -DskipTests'

                    // Sécurité : on supprime le fichier après usage
                    sh 'rm tmp_settings.xml'
                }
            }
        }
    }
}