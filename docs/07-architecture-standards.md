# 07 - Architecture and Standards

## Well-Architected Framework

The [Well-Architected Framework (WAF)](https://learn.microsoft.com/en-us/azure/well-architected/) is a framework designed to help cloud engineers and architects design high quality infrastructure and services that meet the needs of organisations.  It has five pillars:

1. Reliability: Ensuring the workload can meet business needs around resiliency, recovering from failures, etc
2. Security: Protecting business data and operations
3. Cost Optimisation: Running infrastructure in a manner that is cost efficient
4. Operational Excellence: Streamline operations with standards, monitoring and safe practices
5. Performance Efficiency: Scale to meet the demands required of the workload

### Reliability

The principles of the Reliability pillar are focused on ensuring workloads can continue to operate in the event of issues, or if there is an outage, that recovery can be quickly achieved.  Some of the design stategies for this include:

- Designing the workload for simplicity and efficiency.  Extra complexity increases potential points of failure.  When calculating a composite SLA for a workload, the more components, the lower the SLA will be.  Another point is to preference Platform-as-a-Service (PaaS) offerings over Infrastructure-as-a-Service (IaaS).  While IaaS offers full control and flexibility it does come at the cost of maintenance effort, supporting infrastructure, etc.  PaaS offerings are often easier to setup and administer
- Map critical paths and give them priority.  This will ensure the most important pieces of the workload will get the resiliency support they need to keep operating

### Security

Workloads should be built using a zero-trust approach.  Ways to implement this include:

- Using only trusted credentials from approved locations
- Use least-privilege to limit what permissions an attacker might gain access to in the event of a compromise
- Design controls to limit risk and damage

### Cost Optimisation

Cost Optimisation isn't about running the cheapest options possible.  It is about balancing the outcomes needed from the workloads with cost efficiencies and monitoring to ensure costs are kept in check.  Some of the options include:

- Adjusting capacity up or down depending on demand so capacity is used efficiently
- For stable workloads, use things like Reservations and other prepurchase options
- Utilise other discount options such as Dev/Test pricing on Subscriptions containing non-production environments, or Linux over Windows for Virtual Machines and other services

### Operational Excellence

Operational Excellence is about ensuring workload quality through standardised practices and team cohesion.  Some ways to achieve this include:

- Using common systems and tools to promote collaboration
- Continuious improvement, knowledge sharing and blameless analysis
- Standards for processes such as routine tasks
- Automate workflows, with priority on those with the highest return
- Use IaC with a framework that includes automated pipelines, rigorous testing and rollback

### Performance Efficiency

Performance Efficiency si the ability of the workload to adapt to changing demands.