# SDN Microsegmentation Benchmark Results

## Environment
- Controller: ONOS 3.0.0
- Network emulator: Mininet
- Switch: Open vSwitch, OpenFlow 1.3
- Topology: One switch, three hosts
- Baseline: SDN forwarding without custom microsegmentation drop rules
- Policy condition: SDN forwarding with two priority-50000 IP drop rules

## Connectivity and latency

| Condition | Source | Destination | Packets | Loss | Average RTT |
|---|---|---|---:|---:|---:|
| Baseline | h1 | h2 | 20 | 0% | 1.310 ms |
| Baseline | h2 | h3 | 20 | 0% | 1.257 ms |
| Baseline | h1 | h3 | 20 | 0% | 1.264 ms |
| Baseline | h3 | h1 | 20 | 0% | 0.147 ms |
| Policy enabled | h1 | h3 | 10 | 100% | N/A |
| Policy enabled | h3 | h1 | 10 | 100% | N/A |
| Policy enabled | h1 | h2 | 20 | 0% | 1.089 ms |
| Policy enabled | h2 | h3 | 20 | 0% | 1.068 ms |

## TCP throughput

Each measurement used a 10-second iperf TCP test.

| Condition | Path | Trial 1 | Trial 2 | Trial 3 | Mean |
|---|---|---:|---:|---:|---:|
| Baseline | h1 -> h2 | 59.7 | 68.4 | 63.2 | 63.77 Gbit/s |
| Baseline | h3 -> h2 | 61.6 | 67.3 | 58.2 | 62.37 Gbit/s |
| Policy enabled | h1 -> h2 | 63.4 | 64.4 | 66.4 | 64.73 Gbit/s |
| Policy enabled | h3 -> h2 | 63.0 | 62.9 | 64.2 | 63.37 Gbit/s |

## Flow-table verification

Open vSwitch reported the following policy rules after the blocked ping tests:

- h1 (10.0.0.1) -> h3 (10.0.0.3): priority 50000, 10 packets, 980 bytes, drop action.
- h3 (10.0.0.3) -> h1 (10.0.0.1): priority 50000, 10 packets, 980 bytes, drop action.

## Interpretation and limitations

- Both targeted directions were blocked in the 10-packet tests.
- The two tested permitted directions remained reachable with zero packet loss.
- The observed mean throughput was similar across the baseline and policy-enabled conditions.
- The small throughput differences do not establish that the policy improves performance.
- Results are from a virtual Mininet/OVS environment and are not representative of physical-network capacity.
- RTT and throughput are subject to host scheduling, flow setup, and virtualization variability.
- These are prototype results from a single-switch, three-host topology; larger topologies and repeated controlled trials are needed for stronger conclusions.
