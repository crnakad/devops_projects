To monitor the metrics of multiple ubuntu prod instances, we currently are using the Grafana and Prometheus stack. Grafana and Prometheus are installed on an external instance, and the exporters are installed on each of the prod instances (node-exporter to monitor system metrics).Jobs are then created for these exporters inside prometheus to connect to the api provided by the exporters and pull the metrics scraped. Once these metrics are stored in prometheus, they can be visualized in custom made dashboards on Grafana.

To monitor specific endpoints, we can use the blackbox-exporter, which probes these endpoints and returns the status codes.

We can monitor the logs on these instances also by setting up exporters on the instances and loki on the external machine. The exporters could be the loki-docker-plugin, which ships the container logs to loki, or promtail, which scrapes log files on the filesystem and also ships them to loki. We can connect to loki as a datasource from grafana and explore the logs stored there.

We can also use prometheus to create alerting rules, and use the alertmanager to send these alerts to various communication channels.