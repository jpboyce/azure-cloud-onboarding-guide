# 01 - Fundamentals

## Hiearchy

![Image](images/scope-levels.png)

### Management Group

Management Groups are a governance layer that sits Subscriptions.  Management Groups are a security and policy boundary, meaning security permissions can be applied to them or policies attached, which the effects of these cascading through to child objects.  Management Groups can be nested up to 6 levels.

### Subscription

A Subscription is a logical container and acts as a security, policy and billing boundary.  That is, security permissions can be applied to the Subscription and Policy can be associated with it.  A Subscription's parent is a Management Group.  Due to it acting as a security and billing boundary, it's common for Subscriptions to be used for different environments and/or projects/systems for billing clarity.

### Resource Group

A Resource Group is a logical container for grouping together resources.  The typical grouping approach is to group resources related to a particular solution.  Resource Groups are a permission and policy boundary.

### Resource

A Resource is a single Azure service offering, such as a Storage Account.  A Resource must be located in a Resource Group.

## Regions

An Azure Region is a geographical area that has one or more datacenters (Availability Zones) with high performance networking.  All Regions have at least one Availability Zone.

Some Regions, such as Australia East, have three Availability Zones.  Many Azure services are capable of using these Avaiability Zones to provide resilency.

Some Regions are paired.  This paired arrangement is used for things like geo-redundacy.  In Australia, there are two pairs - Australia East (Sydney) and Australia South East (Melbourne), and Australia Central 1 and Australia Central 2 (both in Canberra).

When creating most Resources, a Region must be selected.