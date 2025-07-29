#!/bin/bash
#
# returns an Azure DevOps Personal Access Token
# using the Azure CLI's access token
# see: https://github.com/jongio/azure-cli-awesome/blob/main/create-devops-pat.azcli
#
# Positional Arguments:
#   $1 [REQUIRED] - Azure DevOps Organization Name
#   $2 [OPTIONAL] - the name of the Personal Access Token
#
# Usage:
#   ./generate-azuredevops-pat.sh <your org name>

info_log() {
    # log informational messages to stdout
    echo "Info: ${BASH_SOURCE[0]} ${1}"
}

error_log() {
    # log error messages to stderr
    echo "Error: ${BASH_SOURCE[0]} ${1}" 1>&2
}

exit_with_error() {
    # log a message to stderr and exit 1
    error_log "${1}"
    exit 1
}

if [[ "$#" -lt 1 ]]; then
    # check for the required arguments, if they're not specified return how to use this script
    info_log "this script returns an Azure DevOps Personal Access Token using the Azure CLI's access token"
    exit_with_error "usage: <REQUIRED: Azure DevOps Organization Name> <OPTIONAL: the name of the PAT to store in Azure DevOps>"
fi

organization_name=${1}
pat_name=${2-"AZCLIGeneratedPat"}

# pass a white-space delimited string of scopes
#   for a list of all the scopes you can use:
#   https://docs.microsoft.com/en-us/azure/devops/integrate/get-started/authentication/oauth?view=azure-devops#scopes
scopes="vso.packaging_manage"

uri="https://vssps.dev.azure.com/$organization_name/_apis/Tokens/Pats?api-version=6.1-preview"
resource="https://management.core.windows.net/"
body="{ \"displayName\": \"$pat_name\", \"scope\": \"$scopes\" }"
headers="Content-Type=application/json"

info_log "creating the Personal Access Token '$pat_name' in the Azure DevOps organization '${organization_name}'"

token=$(az rest \
    --method post \
    --uri "$uri" \
    --resource "$resource" \
    --body "$body" \
    --headers "$headers" \
    --query "patToken.token" \
    --output tsv) || exit_with_error "unable to create Personal Access Token in Azure DevOps organization '${organization_name}'"

info_log "created the Personal Access Token '$pat_name' with scopes '$scopes'!"

info_log "run the following command to store the Personal Access Token and log in to Azure DevOps CLI:"

echo "==="
echo "export AZURE_DEVOPS_EXT_PAT=$token && az config set extension.use_dynamic_install=yes_without_prompt && echo \$AZURE_DEVOPS_EXT_PAT | az devops login --organization https://dev.azure.com/$organization_name/"
echo "==="
