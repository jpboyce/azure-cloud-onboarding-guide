# 06 - DevOps

Many cloud environments will use some form of DevOps tools to assist in various processes.  When an organisation uses Azure as their cloud provider, Azure DevOps is one of the more common choices for providing these DevOps tools.  To understand the use of these tools and why they might be used, it's good to consider the some of the principles of DevOps:

- Collaboration between teams (typically development and operations teams)
- Automation to reduce the amount of effort on manual, repetative tasks to increase speed and reduce errors
- Continuous Integration and Delivery (CI/CD) where code changes are regularly merged and then built and tested to enable rapid and reliable releases

## Azure DevOps

Azure DevOps (ADO) is Microsoft's cloud hosted solution for DevOps tooling.  While there are many areas in ADO, a cloud engineer will typically be active in two areas: repositories and pipelines.

### Repositories

ADO Repositories or Repos are a version control system for managing code.  These Repos can either use Git or Team Foundation Version Control (TFVC).  When using Git, the Repo will have common functionality such as ignore files, branches, committs, etc.

### Pipelines

Pipelines are the component that allows ADO to perform continuous integration, continuous testing and continuous delivery.  The Pipelines interface segments the pipeline objects into two groups - Pipelines created using YAML or as "Classic Pipelines" are under the general Pipelines heading while those created as "Classic Release" pipelines are under the Release heading.

!!! note

    While there is generally feature parity across YAML, Classic Pipelines and Classic Releases, there are gaps.  Notably, both Classic options can't run Container jobs or Deployment jobs.  Also, YAML pipelines cannot use Gates, which is a common feature used in Classic Release pipelines to control deployment approvals

#### Agents and Pools

When a Pipeline is run, it is executed on an Agent, similar to a Github Runner.  Microsoft provides agents that they manage, called Microsoft-hosted Agents.  These are built using the same template as Github Runners and have many development and utility tooling installed that can be used by the Pipeline.  ADO has a predefined pool of these agents for use.  In most cases, this pool will suit the needs of most teams.

There are some situations where the Microsoft-hosted agents won't work.  In those cases, Self-hosted agents can be used.  This is typically a Virtual Machine managed by the customer.  Some use cases for using a Self-hosted Agent are:

- Network line of sight: The target of a Pipeline may be not accessible by the Microsoft-hosted agent.  Using a Self-hosted agent that has network access gets around this
- Performance: There is more control over the peformance given to the agent
- Configuration: There may be a need to have additional tools or different configuration that may be difficult or impossible to implement on a Microsoft-hosted agent

!!! info

    Microsoft-hosted Windows and Linux agents run on Virtual Machines with 2 core CPUs, 7GB of RAM and 14GB of SSD disk space.  At least 10GB of this is free space.  Microsoft does not offer the option to increase these specifications, so if the needs of a pipeline are greater than that, a Self-hosted agent must be used