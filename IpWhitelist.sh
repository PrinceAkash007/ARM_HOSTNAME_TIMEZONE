# Set your Azure login credentials
az login --username "shivaprasad@crimsonrds.onmicrosoft.com" --password "Akash@2147"

# Set your subscription ID
subscriptionId="8d25a816-c57d-40b6-9c04-ddc5923a4e18"

# Set the resource group and name of the MySQL server
resourceGroupName="AkashRG"
mysqlServerName="shubham.mysql.database.azure.com"

# Set the tag key and value to filter the VMs
tagKey="Environment"
tagValue="ARM"

# Get the private IP addresses of the VMs with the specified tag
vmPrivateIps=$(az vm list-ip-addresses --subscription $subscriptionId --resource-group $resourceGroupName --query "[?tags.$tagKey=='$tagValue'].{ipAddress:privateIpAddress}" --output tsv)

# Set the firewall rules for the MySQL server to allow the specified IPs
for ip in $vmPrivateIps
do
    az mysql server firewall-rule create --subscription $subscriptionId --resource-group $resourceGroupName --server $mysqlServerName --name "Allow $ip" --start-ip-address $ip --end-ip-address $ip
done
