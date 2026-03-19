# 03 - Identity and Security

## Identity

Azure is tightly coupled with Microsoft Entra ID, which acts as the identity provider.  Entra ID was previously known as Azure Active Directory.

## RBAC

RBAC or Roles Based Access Control is the method of granting permissions for users or groups to different objects in Azure.  An RBAC assignment
always consists of the following items:

- Scope: This is where the permissions are granted.  This can be an individual Resource, a Resource Group, Subscription or Management Group
- Role: The role defines what can be done.  There are general roles like Owner, Contributor and Reader, as well as Resource specific roles. Custom roles can also be created.  A Role should be selected on the basis of least privilege
- Users/Groups: The Users or Groups that will be granted the permissions.  This can be regular user accounts, groups, service principals or managed identities

## Managed Identity

In the past, authentication and authorisation between Azure resources used methods like access keys or App Registration Secrets.  This created an administrative burden as these had to be rotated on a regular basis.  These secrets were also typically long-lived (generally a year) which creates a large window of exposure if the secret is compromised.

Managed Identity removes these issues.  A Managed Identity is an identity resource that is associated with a resource.  Like any other identity, it can then be granted an RBAC assignment.
