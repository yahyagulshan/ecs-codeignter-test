# ecs-codeignter-demo
## 1st step
### For changing in Prod Env need the below credentials to be added in git hub secrets.

PRODUCTION_AWS_REGION     
PRODUCTION_CONTAINER_NAME 
PRODUCTION_DB_HOST        
PRODUCTION_DB_NAME        
PRODUCTION_DB_PASSWORD    
PRODUCTION_DB_USERNAME    
PRODUCTION_ECS_CLUSTER_NAME  
PRODUCTION_ECS_REPOSITORY_URI 
PRODUCTION_ECS_SERVICE_NAME  
PRODUCTION_TASK_DEFINITION_NAME 

## 2nd step
### in the autoscaling group on aws console maximum desired capasity = 2

## 3rd step
### add user policy 
change with account id

`{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowPushPull",
            "Effect": "Allow",
            "Action": [
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:CompleteLayerUpload",
                "ecr:GetDownloadUrlForLayer",
                "ecr:InitiateLayerUpload",
                "ecr:PutImage",
                "ecr:UploadLayerPart"
            ],
            "Resource": "arn:aws:ecr:us-east-1:5555555555555555:repository/*"
        }
    ]
}`

## 4th step
### user needs 3 more policies (access on ECS Cluster and ECR)
* 1- AmazonECS_FullAccess
* 2- SecretsManagerReadWrite
* 3- AmazonEC2ContainerRegistryFullAccess

## 5th step
### in staging-task-defination.json file (change these lines as per your task-definition file)

* line # 5 change name 
* line # 11 name
* line # 26 log-group

### in the production-task-defination.json file (change these lines as per your task-definition file)

* line # 5 change name 
* line # 11 name
* line # 26 log-group
  


