# AI-Based SDN Microsegmentation for Zero Trust Security

## Overview
This project demonstrates network microsegmentation using Software-Defined Networking (SDN). A centralized ONOS controller manages flow rules on an OpenFlow switch to enforce least-privilege communication between hosts.

## Objectives
- Implement traffic isolation using ONOS and OpenFlow.
- Block communication between specified hosts using high-priority drop rules.
- Verify that permitted host communication continues to work.
- Record flow-table evidence and evaluate connectivity before and after policy enforcement.

## Architecture

```text
             ONOS Controller
                    |
             OpenFlow 1.3
                    |
                Switch s1
              /     |     \
            h1      h2      h3
         10.0.0.1  .0.2    .0.3
```

The prototype blocks traffic in both directions between h1 and h3 while allowing communication between the other host pairs.

## Technologies
- Ubuntu Linux
- Mininet
- Open vSwitch
- OpenFlow 1.3
- ONOS SDN Controller
- Bash and curl

## Experimental Results
- Before policy enforcement: all 6 directed host-to-host connectivity checks succeeded.
- After policy enforcement: h1 ↔ h3 communication was blocked in both directions.
- Permitted pairs h1 ↔ h2 and h2 ↔ h3 remained reachable.
- Open vSwitch flow-table output confirmed that the isolation rules used `actions=drop`.

## Limitations
This is a virtual lab prototype. Latency and throughput measurements depend on the host machine and virtual networking environment; they should not be interpreted as physical network performance. An integrated AI-based anomaly detection component has not yet been verified as part of this repository.

## Repository Structure
- `scripts/` — policy installation script
- `results/` — switch information and flow-table evidence
- `README.md` — project documentation

## Security
Supply controller credentials through environment variables. Do not commit passwords, packet captures, private traffic metadata, or logs.
