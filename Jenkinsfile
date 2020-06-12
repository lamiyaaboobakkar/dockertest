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
        IMAGE = 'trainingrepotf'
        ECRURL = 'http://014312505571.dkr.ecr.us-east-1.amazonaws.com'
        ECRCRED = 'ecr:us-east-1:ecr'
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
                    docker.build("trainingrepotf")
                }
            }
        }
        stage('Docker push')
        {
            steps
            { withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws_cred', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) 
             {
                script
                {
                    //Get the ECR Login
                    sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 014312505571.dkr.ecr.us-east-1.amazonaws.com/trainingrepotf'
                    // Tag the Image
                    sh 'docker tag trainingrepotf:latest 014312505571.dkr.ecr.us-east-1.amazonaws.com/trainingrepotf:latest'
                    // Push the Docker image to ECR
                    echo "Push Docker Build to ECR"
                    sh 'docker push 014312505571.dkr.ecr.us-east-1.amazonaws.com/trainingrepotf:latest'    

                }
             }
            }
        }
    }
    
    post 
    {
        always
        {
            // make sure that the Docker image is removed
            sh "docker rmi $IMAGE | true"
        }
    }
}
