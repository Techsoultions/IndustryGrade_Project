pipeline {
    agent any

    options {
        buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
        timestamps()
        timeout(time: 2, unit: 'HOURS')
        skipDefaultCheckout()
    }

    tools {
        
        maven 'maven3.6'
      
    }

    environment {

        GIT_CREDENTIALS_ID = 'anji_git_hub_acct'
        SOURCE_GIT_REPO = 'https://github.com/Techsoultions/IndustryGrade_Project.git'
        BUILD_NUM = "${BUILD_ID}"
    
  }

    stages{

        stage('Checkout code for SCM')
        {
          steps
          {
            script{
               echo " Code Check out from github......... "  
               git branch: 'main', credentialsId: "${GIT_CREDENTIALS_ID}", url: "${SOURCE_GIT_REPO}"   
            }
          }
        }

        stage('Buildig,testing and generating artifact(WAR or JAR)')
        {
          steps
          {
            script{
                echo " Buildig,testing and generating artifact!!!!!!!!!!!!!! "
                sh 'mvn clean install'
           }
          }
        }

        stage('Building Docker image')
        {
            steps{
                script{
                   sh " docker build -t anjidockerid/abc-org:${BUILD_NUM} . "
                }
            }

        }
        stage('Pushing docker iamge - docker hub')
        {
            steps{
                script{
                    withCredentials([usernamePassword(credentialsId: 'DockerId', passwordVariable: 'docker_pwd', usernameVariable: 'docker_id')]) {
                     sh "docker login -u ${docker_id} -p ${docker_pwd}"
                     sh "docker push anjidockerid/abc-org:${BUILD_NUM}"   
                    }
                }
            }

        }
        /*stage('Removing the local docker images')
        {
            steps{
                script{
                sh ' docker rmi -f $(docker images -aq) '
                }
            }
        }*/
        
    }

    post {
    always {
      deleteDir() /* clean up our workspace */
    }

    success {
      script {
        echo " Removing the local docker images "
        sh ' docker rmi -f $(docker images -q) '
      }
    }

}
}
