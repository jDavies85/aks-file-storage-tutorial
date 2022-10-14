$ResourceGroup="aks-fileshare-integration"
$azFileStorage="mystorage70752"
#Get the storage key
$StorageKey=(az storage account keys list --resource-group $ResourceGroup --account-name $azFileStorage --query "[0].value" -o tsv)

#store it as a secret
kubectl create secret generic azure-secret `
        --from-literal=azurestorageaccountname=$azFileStorage `
        --from-literal=azurestorageaccountkey= $StorageKey `
        -n default