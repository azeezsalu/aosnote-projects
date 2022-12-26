# make shell script executable

PowerShell 
Set-ExecutionPolicy -ExecutionPolicy Unrestricted

MAC:
chmod +x build_image.sh

----------------------------------------------------------------

# aws cli command to create an amazon ecr repository
aws ecr create-repository --repository-name <repository-name> --region <region>
  
----------------------------------------------------------------
  
# push image to ecr repository

# retag image 
docker tag <image-tag> <repository-uri>

# login to ecr
aws ecr get-login-password | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com

# push image to the ecr repository 
docker push <repository-uri>
  
----------------------------------------------------------------
