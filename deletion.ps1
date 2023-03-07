# Define the tag name and value to identify resources to delete
$tagName = "Environment"
$tagValue = "ARM"

# Get all resources with the specified tag
$resources = Get-AzResource -Tag @{ $tagName = $tagValue }

# Filter the resources to separate VM resources
$vmResources = $resources | Where-Object {$_.ResourceType -eq "Microsoft.Compute/virtualMachines"}

# If there are VM resources, delete them first
if ($vmResources.Count -gt 0) {
    foreach ($vmResource in $vmResources) {
        Remove-AzResource -ResourceId $vmResource.ResourceId -Force
    }
}

# Delete all other resources with the specified tag
foreach ($resource in $resources) {
    if ($resource.ResourceType -ne "Microsoft.Compute/virtualMachines") {
        Remove-AzResource -ResourceId $resource.ResourceId -Force
    }
}
