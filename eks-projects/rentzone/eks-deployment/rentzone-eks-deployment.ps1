$REGION = "us-east-1"
$CLUSTER_NAME = "rentzone-cluster"
$AWS_ACCOUNT_ID = "651783246143"

# This command updates the kubeconfig file with the configuration necessary to connect to an AWS EKS cluster.
# After running this command, your kubectl will be configured to interact with the specified cluster in the region.
aws eks --region $REGION update-kubeconfig --name $CLUSTER_NAME


# This kubectl command lists all the contexts available in your kubeconfig file.
# A context in Kubernetes is essentially a combination of a cluster, a user, and a namespace.
# This command helps you see all the configured clusters you can connect to, including their associated users and namespaces.
kubectl config get-contexts


# This command sets the current context for kubectl to a specific EKS cluster.
# After running this command, all subsequent kubectl commands will be executed against the specified cluster
# in the region under the specified AWS account.
kubectl config use-context "arn:aws:eks:$($REGION):$($AWS_ACCOUNT_ID):cluster/$($CLUSTER_NAME)"


#####################################################################################################


$NAMESPACE = "rentzone"

# Create a namespace.
kubectl create namespace $NAMESPACE


# Permanently save the namespace for all subsequent kubectl commands.
kubectl config set-context --current --namespace=$NAMESPACE


# Verify the namespace.
kubectl config view --minify | Select-String 'namespace:'


#####################################################################################################


# This command adds the 'secrets-store-csi-driver' Helm repository to your local Helm configuration.
# By adding this repository, you gain access to the charts it contains, including the Secrets Store CSI Driver.
helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts


# This command updates the local list of charts from all the Helm chart repositories that have been added.
# When you add a repository to Helm (using 'helm repo add'), Helm tracks the charts available in that repository.
# Running 'helm repo update' ensures that you have the latest information about charts available from each added repository.
# This is particularly important to do before installing or upgrading charts to ensure you are getting the latest versions.
helm repo update


# This command uses Helm to install the Secrets Store CSI Driver into your Kubernetes cluster, specifically in the 'kube-system' namespace.
# The CSI (Container Storage Interface) Driver allows Kubernetes to interface with external secrets stores like AWS Secrets Manager, Azure Key Vault, etc.
# 'csi-secrets-store' is the name of the Helm release - a unique identifier for this particular deployment of the chart.
helm install csi-secrets-store secrets-store-csi-driver/secrets-store-csi-driver --namespace kube-system


# Verify that Secrets Store CSI Driver has started.
kubectl --namespace=kube-system get pods -l "app=secrets-store-csi-driver"


# This command applies a Kubernetes manifest file directly from a URL using 'kubectl'.
# The manifest contains the necessary Kubernetes objects for setting up the AWS provider for the Secrets Store CSI Driver.
# This allows the CSI driver to interface with AWS Secrets Manager, enabling pods in your cluster to use secrets stored in AWS.
kubectl apply -f https://raw.githubusercontent.com/aws/secrets-store-csi-driver-provider-aws/main/deployment/aws-provider-installer.yaml


#####################################################################################################


$REGION = "us-east-1"
$CLUSTER_NAME = "rentzone-cluster"

# This command is used to associate an IAM OIDC (OpenID Connect) identity provider with an AWS EKS cluster using eksctl, a command-line tool for EKS.
# IAM OIDC identity providers allow for fine-grained IAM role-based access control for applications running in EKS, using Kubernetes service accounts.
# Run only once on the cluster.
eksctl utils associate-iam-oidc-provider --region=$REGION --cluster=$CLUSTER_NAME --approve


#####################################################################################################


$SERVICE_ACCOUNT_NAME = "rentzone-service-account"
$NAMESPACE = "rentzone"
$REGION = "us-east-1"
$CLUSTER_NAME = "rentzone-cluster"
$AWS_ACCOUNT_ID = "651783246143"
$SECRET_MANAGER_ACCESS_POLICY_NAME = "rentzone-secret-access-policy"

# This command creates a new IAM service account in AWS, specifically for use with an EKS (Elastic Kubernetes Service) cluster.
eksctl create iamserviceaccount `
    --name $SERVICE_ACCOUNT_NAME `
    --namespace $NAMESPACE `
    --region $REGION `
    --cluster $CLUSTER_NAME `
    --attach-policy-arn "arn:aws:iam::$($AWS_ACCOUNT_ID):policy/$($SECRET_MANAGER_ACCESS_POLICY_NAME)" `
    --approve `
    --override-existing-serviceaccounts


#####################################################################################################


$SECRET_PROVIDER_CLASS_FILE_NAME = "secret-provider-class.yaml"

# This command apply the secret-provider-class configuration to a Kubernetes cluster.
kubectl apply -f $SECRET_PROVIDER_CLASS_FILE_NAME


#####################################################################################################


$DEPLOYMENT_FILE_NAME = "deployment.yaml"

# This command apply the 'deployment.yaml' file to create or update resources in your Kubernetes cluster. 
kubectl apply -f $DEPLOYMENT_FILE_NAME


#####################################################################################################


$SERVICE_FILE_NAME = "service.yaml"

# This command apply the 'service.yaml' file to expose the application running in your Kubernetes cluster.
kubectl apply -f $SERVICE_FILE_NAME
