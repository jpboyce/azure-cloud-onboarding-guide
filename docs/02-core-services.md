# 02 - Core Services

## Storage Accounts

An Azure Storage Account is a Resource capable of providing a number of storage related services including blob storage, file shares, queues and tables.  There are several types of Storage Account, with the most common being Standard General Purpose V2.  This type supports all the storage services as well as redundancy options.

### Storage Services

#### Blob Service

Blob Storage is Azure's object storage service and is designed to serve content such as images, documents and streaming media like video and audio.

#### Azure Files Service

Azure Files allows a Storage Account to function similar to a traditional file server, with shares being accessible via Server Message Block (SMB) or Network File System (NFS).  As such, both Windows and Linux systems can access the shares.

#### Queues Service

Storage Accounts have a Queue service that can be used to store and retrieve messages.  This offers functionality similar to other message queue systems like RabbitMQ.

#### Table Service

Storage Accounts have a Table Service that can store non-relational structured data (AKA structured noSQL).

### Resiliency

Standard General Purpose V2 Storage Accounts have a wide range of resiliency and reliability options.  For redundancy:

- Locally Redundant Storage (LRS): The Storage Account is located in one Availability Zone.  However, the data is replicated multiple times to protect against disk failures
- Zone Redundant Storage (ZRS): The Storage Account is replicated across multiple Availability Zones in the Region.  If an Availability Zone is unhealth, requests will be automatically routed to the healthy zones.
- Geo-redundant Storage (GRS): The primary Region functions like LRS (ie. only one Availability Zone used).  Data is replicated to a paired Region.
- Geo-zone-redundant Storage (GRZS): The primary Region functions like ZRS (data replicated across all 3 Availability Zones) with data also geo-replicated to a paired region.
