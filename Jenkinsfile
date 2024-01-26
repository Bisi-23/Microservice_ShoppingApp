pipeline {
    agent any
    environment {
        SCANNER_HOME = tool 'sonar-scanner'

   }

    stages {
            stage('SonarQube') {
             steps {
                withSonarQubeEnv('sonar') {
                    sh '''$SCANNER_HOME/bin/sonar-scanner -Dsonar.projectKey=shopshop -Dsonar.ProjectName=shopshop -Dsonar.java.binaries=.'''
                }
            }
        }
            stage('adservice') {
              steps {
               script {
                 withDockerRegistry(credentialsId: 'dockerhub', toolName: 'docker') {
                    dir('/var/lib/jenkins/workspace/shopshop/src/adservice/') {
                        sh "docker build -t bisi23/adservice:latest ."
                        sh "docker push bisi23/adservice:latest"
                        sh "docker rmi bisi23/adservice:latest"
                    }
                }
            }
        }
            }
            stage('cartservice') {
              steps {
               script {
                 withDockerRegistry(credentialsId: 'dockerhub', toolName: 'docker') {
                    dir('/var/lib/jenkins/workspace/shopshop/src/cartservice/") {
                        sh "docker build -t bisi23/cartservice:latest ."
                        sh "docker push bisi23/cartservice:latest"
                        sh "docker rmi bisi23/cartservice:latest"
                    }
                }
            }
        }
       }
            stage('checkoutservice') {
              steps {
               script {
                 withDockerRegistry(credentialsId: 'dockerhub', toolName: 'docker') {
                    dir('/var/lib/jenkins/workspace/shopshop/src/checkoutservice/") {
                        sh "docker build -t bisi23/checkoutservice:latest ."
                        sh "docker push bisi23/checkoutservice:latest"
                        sh "docker rmi bisi23/checkoutservice:latest"
                    }
                }
            }
        }
            }
            stage('currencyservice') {
              steps {
               script {
                 withDockerRegistry(credentialsId: 'dockerhub', toolName: 'docker') {
                    dir('/var/lib/jenkins/workspace/shopshop/src/currencyservice/") {
                        sh "docker build -t bisi23/currencyservice:latest ."
                        sh "docker push bisi23/currencyservice:latest"
                        sh "docker rmi bisi23/currencyservice:latest"
                    }
                }
            }
        }

            }
            stage('emailservice') {
              steps {
               script {
                 withDockerRegistry(credentialsId: 'dockerhub', toolName: 'docker') {
                    dir('/var/lib/jenkins/workspace/shopshop/src/emailservice/") {
                        sh "docker build -t bisi23/emailservice:latest ."
                        sh "docker push bisi23/emailservice:latest"
                        sh "docker rmi bisi23/emailservice:latest"
                    }
                }
            }
        }
            }
            stage('frontend') {
              steps {
               script {
                 withDockerRegistry(credentialsId: 'dockerhub', toolName: 'docker') {
                    dir('/var/lib/jenkins/workspace/shopshop/src/frontend/") {
                        sh "docker build -t bisi23/frontend:latest ."
                        sh "docker push bisi23/frontend:latest"
                        sh "docker rmi bisi23/frontend:latest"
                    }
                }
            }
        }
            }
            stage('loadgenerator') {
              steps {
               script {
                 withDockerRegistry(credentialsId: 'dockerhub', toolName: 'docker') {
                    dir('/var/lib/jenkins/workspace/shopshop/src/loadgenerator/") {
                        sh "docker build -t bisi23/loadgenerator:latest ."
                        sh "docker push bisi23/loadgenerator:latest"
                        sh "docker rmi bisi23/loadgenerator:latest"
                    }
                }
            }
        }
            }
             stage('paymentservice') {
              steps {
               script {
                 withDockerRegistry(credentialsId: 'dockerhub', toolName: 'docker') {
                    dir('/var/lib/jenkins/workspace/shopshop/src/paymentservice/") {
                        sh "docker build -t bisi23/paymentservice:latest ."
                        sh "docker push bisi23/paymentservice:latest"
                        sh "docker rmi bisi23/paymentservice:latest"
                    }
                }
            }
        }
             }
             stage('productcatalogservice') {
              steps {
               script {
                 withDockerRegistry(credentialsId: 'dockerhub', toolName: 'docker') {
                    dir('/var/lib/jenkins/workspace/shopshop/src/productcatalogservice/") {
                        sh "docker build -t bisi23/productcatalogservice:latest ."
                        sh "docker push bisi23/productcatalogservice:latest"
                        sh "docker rmi bisi23/productcatalogservice:latest"
                    }
                }
            }
        }
             }
             stage('recommendationservice') {
              steps {
               script {
                 withDockerRegistry(credentialsId: 'dockerhub', toolName: 'docker') {
                    dir('/var/lib/jenkins/workspace/shopshop/src/recommendationservice/") {
                        sh "docker build -t bisi23/recommendationservice:latest ."
                        sh "docker push bisi23/recommendationservice:latest"
                        sh "docker rmi bisi23/recommendationservice:latest"
                    }
                }
            }
        }
             }
             stage('shippingservice') {
              steps {
               script {
                 withDockerRegistry(credentialsId: 'dockerhub', toolName: 'docker') {
                    dir('/var/lib/jenkins/workspace/shopshop/src/shippingservice/") {
                        sh "docker build -t bisi23/shippingservice:latest ."
                        sh "docker push bisi23/shippingservice:latest"
                        sh "docker rmi bisi23/shippingservice:latest"
                    }
                }
            }
        }
    }

              stage('EKS-Deployment') {
            steps {
               withKubeConfig(caCertificate: '', clusterName: 'my-cluster', contextName: '', credentialsId: 'k8s', namespace: 'webapps', restrictKubeConfigAccess: false, serverUrl: 'https://7FBBEAE57184A8BD04AB8923BA32A52F.gr7.us-east-1.eks.amazonaws.com') {
                    sh 'kubectl apply -f deployment-service.yaml'
                    sh 'kubectl get pods'
                    sh 'kubectl get svc'

                }
                }
            }
        }
   }
