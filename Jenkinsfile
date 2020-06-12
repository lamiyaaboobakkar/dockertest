pipeline
{
    options
    {
        buildDiscarder(logRotator(numToKeepStr: '3'))
    }
    agent any
    environment 
    {
        VERSION = 'latest'
        PROJECT = 'training-api'
        IMAGE = 'jenkins'
        ECRURL = 'http://553812159679.dkr.ecr.ap-south-1.amazonaws.com'
        ECRCRED = 'ecr:ap-south-1:ecr-credentials'
    }
    stages  
    {
        stage('Build preparations')
        {
            steps
            {
                checkout scm
            }
        }
        
        stage('Docker build')
        {
            steps
            {
                script
                {
                    // Build the docker image using a Dockerfile
                    docker.build("jenkins")
                }
            }
        }
        stage('Docker push')
        {
            steps
            { withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'ecr-credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) 
             {
                script
                {
                    //Get the ECR Login
                    sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 553812159679.dkr.ecr.ap-south-1.amazonaws.com/jenkins'
                    // Tag the Image
                    sh 'docker tag jenkins:latest 553812159679.dkr.ecr.ap-south-1.amazonaws.com/jenkins:latest'
                    // Push the Docker image to ECR
                    echo "Push Docker Build to ECR"
                    sh 'docker push 553812159679.dkr.ecr.ap-south-1.amazonaws.com/jenkins:latest'    

                }
             }
            }
        }
    }
    
   
}
