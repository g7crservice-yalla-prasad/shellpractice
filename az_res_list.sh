#!/bin/bash

###################### Meta data #######################
#This script will list down all the azure account
#Author: Prasad yalla
#version: v1.0
########################################################

##################### Features ########################
#This script will support following resources
#1.Storage accounts
#2.Virtual machines
#3.Resource groups
#4.Virtual networks
#5.Network security groups
#usage: sh az_re_list.sh <region> <resource>
#######################################################


# Check if number of command line inputs given are correct or not
if [ $# -ne 2 ]; then
    echo "usage: $0 <region> <resource>"
    exit 1
fi

azure_region=$1
azure_service=$2

# Check azure cli is installed or not 
if ! command -v az &> /dev/null; then
    echo "Azure CLI is not installed. Please install the Azure CLI and try again."
    exit 1
fi

# Check whether azure cli is configured or not
if ! az account show &> /dev/null; then
    echo "Azure CLI is not logged in. Please run 'az login' and try again."
    exit 1
fi

case $azure_service in
    vm)
        echo "Listing Virtual Machines in $azure_region"
        az vm list --output table --query "[?location=='$azure_region']"
        ;;
    storage)
        echo "Listing Storage Accounts in $azure_region"
        az storage account list --output table --query "[?location=='$azure_region']"
        ;;
    vnet)
        echo "Listing Virtual Networks in $azure_region"
        az network vnet list --output table --query "[?location=='$azure_region']"
        ;;
    deployment)
        echo "Listing Resource Group Deployments"
        az deployment group list --output table
        ;;
    nsg)
        echo "Listing Network Security Groups in $azure_region"
        az network nsg list --output table --query "[?location=='$azure_region']"
        ;;
    *)
        echo "Invalid Azure service. Please enter a valid service name."
        exit 1
        ;;
esac
