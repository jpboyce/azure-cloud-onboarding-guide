# 08 - Monitoring and Alerting

## Adhoc Metrics

Most Azure resources have a Metrics blade (usually under the Monitoring heading).  From here, it's possible to view Metrics of the resource on an adhoc basis.  These metrics are always specific to the resource type - so a Storage Account would have metrics appropriate for storage (ie. disk operations/second) while a Virtual Machine would have a different set of metrics (CPU usage, memory usage, network traffic)

## Log Analytics Workspaces

Log Analytics Workspaces are an Azure resource designed for storing logs.  They can store logs from Azure and non-Azure resources.  Other tools can then leverage this data to allow outcomes such as alerting, visualisation of metrics, etc.

## Application Insights

Application Insights is the Application Performance Monitoring (APM) feature of Azure Monitor.  It allows deep analysis of complex applications through a range of dashboard and visualisation options.  
