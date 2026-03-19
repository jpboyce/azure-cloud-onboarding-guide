# 04 - Networking

## Virtual Network

Azure Virtual Networks are the foundational Resource for private networks in Azure.  Other Resources such as Virtual Machines connect to a Virtual Network in order to communicate.

Virtual Networks are one of the few Azure Resources with no charge for use.

When creating a Virtual Network, it must be given an Address Space.  This is a range of IP addresses, which will be consumed by the Resources that connect to the Virtual Network.  Typically the range is a private or Rfc1918 range such as 10.0.0.0/16.  It is important to ensure the Address Space does not overlap with others on your network.

### Peering

Virtual Networks can be connected in a process called Peering.  Resources in one Virtual Network can connect to resources in the Peered Virtual Network.  Unlike on-prem networks, Azure handles the routing behaviour under the hood once the Peer is established.

### Subnets

A Subnet is a segment of a Virtual Network.  It is given a portion of the Virtual Network's Address Space.  If the Address Space is 10.0.0.0/16, then a Subnet might be assigned 10.0.1.0/24.  Subnets are used to segment the network for security reasons and for workload reasons.  Not all Resources can be connected to the same Subnet, as some require exclusive control of the Subnet.

!!! note

    When creating a Subnet, Azure will reserve 5 IP addresses

### Network Security Groups

Network Security Groups (NSG) have rules that control what network traffic is allowed.  Each rule has these properties:

- Name: A name that is unique in the NSG
- Priority: A priority value between 100 and 4096.  Rules are processed in order.  Once a rule is matched, processing stops.
- Source/Destination: This Source and Destination of the traffic flow that would be affected by NSG.  This can be `Any`, a specific IP address, an IP range, service tag or application security group.
- Protocol: Options like TCP and UDP are available for this.
- Direction: Whether the rule is to be applied on inbound or outbound traffic
- Port Range: Individual ports or a range of ports or a mix.
- Action: Allow or deny the traffic that matches the rule

A NSG will have some default rules when created:

- AllowVnetInBound: allows all traffic from VirtualNetworks (effectively allows any traffic from a Virtual Network Peer)
- AllowAzureLoadBalanceInBound: Allows traffic on all ports and protocols from the AzureLoadBalancer service
- DenyAllInbound: A deny all rule at the bottom of the priority that acts as a catchall
- AllowVnetOutBound: allows all traffic to other Virtual Networks
- AllowInternetOutBound: Allows traffic on all ports/protocols out to the internet
- DenyAllOutBound: Denies all outbound traffic.
