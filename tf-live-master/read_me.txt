Objective
============
3 tier application with Active Passive DR in multi region.

Infrastructure
==============
1. Primary region -: us-east-1
- 1 VPC
- 1 ALB
- 2 Webservers
- 4 App servers
- 1 DB

2. Secondary region -: us-east-2
- 1 VPC
- 
- 1 ALB
- 2 Webservers
- 4 App servers
- 1 DB

Pillar Aspects
============
1. Operation excellence
2. Performance -: Use Global accelerator,Cloud Front,better instance type 
3. Security -: WAF,Guard Duty, Shield (Anti-DDOS, basic or advanced)
4. Reliability & Resillience -: Multi AZ, Multi Region, DR (Active-Passive)
5. Cost optimzation -: Continual review and monitor workload 



Security-:
=========
1. KMS
2. Gurad Duty
3. WAF