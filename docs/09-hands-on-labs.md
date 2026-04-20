# 09 - Hands-on Labs

The goal of these labs will be to tie together concepts from the earlier sections as they would relate to deploying a functional cloud-first application in Azure

!!! warning The Cloud costs money

    While an effort has been made to ensure the resources suggested in these labs are no cost or zero cost, there will be cases were some do cost money to run.  Ensure that resources are destroyed when not in use, and be aware of the cost implications of what is provisioned

## Lab Architecture

This lab will deploy a 2-tier application (web layer and API layer) with private networking.  This is a common design pattern and will cover areas such as:

* Configuring a network that can support private networking
* Configuring resources for private networking
* Using Managed Identity for inter-resource access

## Lab 00 - Resource Group

Create a Resource Group in a Subscription that will contain the lab resources

## Lab 01 - Networking

* Create a virtual network and subnets
* The default address space will be `10.0.0.0/16`.  Typically ranges will be much smaller.  For this lab, set it to a `/24` range
* The lab will require two subnets - one for private endpoints and one for virtual network integration
* The smallest allowed subnet size for private endpoints is `/28`.  Likewise, virtual network integration requires a subnet size of at least `/27`

!!! tip "Subnet Calculators"
    There are numerous online calculators that can assist with designing subnets.  https://visualsubnetcalc.com/ supports both Azure and AWS subnetting

!!! info "Private subnet by default"
    Subnets created after 31 March 2026 will default to being a private subnet.  This means they will not have default outbound access

## Lab 02 - Compute & Storage

* The application will have an API component and a web component.  The lab will follow a standard pattern of using an Azure Function App for the API and an App Service for the website
* Both Function Apps and App Services need an App Service Plan to provide compute capacity to run.

### Create App Service Plan
* Create an App Service Plan with the Operating System set to Linux and Plan set to Basic B1

!!! warning Cost Implications
    While there is a free plan option (Free F1) it doesn't support vNet integration.  The Basic B1 plan is the cheapest option that supports this feature.  It has a cost of $13.14USD per month.  The Operating System selection can also affect prices, Windows App Service Plans typically cost twice that of Linux plans

### Create Function App Storage

* Function Apps are a server-less hosting option. Because they are server-less, they have no default storage and require a separate Storage Account.
* The Storage Account type needs to support Blob, Queue and Table storage

## Lab 03 - DevOps

* Create pipelines to deploy application code
* Create pipelines to deploy IaC
