# vagrant_opencanary
Spin up opencanary systems with vagrant

<b>What's in the repo</b>

I created a bunch of vagrant scripts that deploy opencanary via pip install opencanary to an Ubuntu hosts (tested on Ubuntu trusty).
The script updates Ubuntu, echo's over the opencanary.conf file, and starts it up. Right now its configured to send logs to the splunk forwarder via the json-tcp logger (see any of the configs in /scripts/).

1. Tweak any configurations you need from the various starting point opencanaryies in the repo.

2. Update the Vagrant file to point at the opencanary vagrant config.

3. vagrant up

4. Secure the host. Probably want to harden or turn off the regular ssh and make it console only via ESX or at a minimum change the vagrant account password. Obviously we wont alert on connections to the real ssh server. 

<b>How to add honey creds</b>
To add honey creds you have to add a protocol.honeycreds field. Example shown below:

```
\"ssh.honeycreds\" : [
    {
     \"username\" : \"admin\",
     \"password\" : \"$pbkdf2-sha512$19000$bG1NaY3xvjdGyBlj7N37Xw$dGrmBqqWa1okTCpN3QEmeo9j5DuV2u1EuVFD8Di0GxNiM64To5O/Y66f7UASvnQr8.LCzqTm6awC8Kj/aGKvwA\"
    },
    {
    \"username\" : \"admin\",
    \"password\" : \"admin1\"
    }
    ],
```
