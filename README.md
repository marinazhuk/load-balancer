# Load Balancer

Need to set up: 
* load balancer on Openresty with
  * 1 server for UK 
  * 2 servers for US 
  * 1 server for the rest
  * backup server
* Health check should happen every 5 seconds
* Need to use ngrok and touch vpn chrome extension to test geo balancing


## Testing

Following headers were added to Load Balancer for testing purposes:
* **X-Backend-Server-Ip** *$upstream_addr* with values
  * uk-serve - 172.19.0.2
  * us-server1 - 172.19.0.3
  * us-server2 - 172.19.0.4
  * rest-world-server - 172.19.0.5
  * backup: 172.19.0.6
* **X-Backend-Server-Name** *$upstream*
* **X-Client-Country** *$geoip2_data_country_code*
* **X-Client-Ip** *$http_x_forwarded_for*


### US example:
* #### first request 
goes to **us-server2** IP *172.19.0.4*
![us_first_request.png](screenshots%2Fus_first_request.png)
* #### second request
goes to **us-server1** IP *172.19.0.3*
![us_second_request.png](screenshots%2Fus_second_request.png)

* #### both servers are down
goes to **backup** IP *172.19.0.6*
![us_backup.png](screenshots%2Fus_backup.png)
#### Healthcheck 
![healthcheck.png](screenshots%2Fhealthcheck.png)

### Rest of the world example:
goes to **rest-world-server** IP *172.19.0.5*
![rest_world.png](screenshots%2Frest_world.png)
