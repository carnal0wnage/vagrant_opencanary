sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get -y install build-essential libpcap-dev jq libssl-dev libffi-dev python-dev python-pip python-virtualenv 
 
virtualenv venv 
. venv/bin/activate
pip install scapy pcapy #rdpy
pip install opencanary

#echo our Default LAMP config
# NAS, MySQL Banner auth bypass vulnerable, ssh, telnet, ntp, tftp
echo "########################################################"
echo "     Echoing Linux NAS Config     "
echo "########################################################"
echo "
{
    \"device.node_id\": \"opencanary-linuxNAS\",
    \"ftp.banner\": \"FTP server ready\",
    \"ftp.enabled\": true,
    \"ftp.port\":21,
    \"ftp.honeycreds\" : [
    {
    \"username\" : \"admin\",
    \"password\" : \"$pbkdf2-sha512$19000$bG1NaY3xvjdGyBlj7N37Xw    $dGrmBqqWa1okTCpN3QEmeo9j5DuV2u1EuVFD8Di0GxNiM64To5O/Y66f7UASvnQr8.LCzqTm6awC8Kj/aGKvwA\"
    },
    {
    \"username\" : \"admin\",
    \"password\" : \"admin1\"
    },
    {
    \"username\" : \"root\",
    \"password\" : \"password\"
    }
    ],
    \"http.banner\": \"Apache/2.2.22 (Ubuntu)\",
    \"http.enabled\": true,
    \"http.port\": 80,
    \"http.skin\": \"nasLogin\",
    \"http.skin.list\": [
        {
            \"desc\": \"Plain HTML Login\",
            \"name\": \"basicLogin\"
        },
        {
            \"desc\": \"Synology NAS Login\",
            \"name\": \"nasLogin\"
        }
    ],
    \"logger\": {
	\"class\" : \"PyLogger\",
	\"kwargs\" : {
	    \"formatters\": {
		\"plain\": {
		    \"format\": \"%(message)s\"
		}
	    },
	    \"handlers\": {
		\"console\": {
		    \"class\": \"logging.StreamHandler\",
		    \"stream\": \"ext://sys.stdout\"
		},
		\"file\": {
		    \"class\": \"logging.FileHandler\",
		    \"filename\": \"/var/tmp/opencanary.log\"
		},
        \"syslog-unix\": {
            \"class\": \"logging.handlers.SysLogHandler\",
            \"address\": [
                \"localhost\",
                514
            ],
            \"socktype\": \"ext://socket.SOCK_DGRAM\"
        },
        \"json-tcp\": {
        \"class\": \"opencanary.logger.SocketJSONHandler\",
        \"host\": \"log.box.com\",
        \"port\": 12345
        }
	   }
	}
    },
    \"portscan.synrate\": \"5\",
    \"portscan.enabled\": true,
    \"mysql.banner\": \"5.0.51a-3ubuntu5\",
    \"mysql.port\": 3306,
    \"mysql.enabled\": false,
    \"ssh.enabled\": true,
    \"ssh.port\": 8022,
    \"ssh.version\": \"SSH-2.0-OpenSSH_5.1p1 Debian-4\",
    \"ssh.honeycreds\" : [
    {
    \"username\" : \"admin\",
    \"password\" : \"$pbkdf2-sha512$19000$bG1NaY3xvjdGyBlj7N37Xw    $dGrmBqqWa1okTCpN3QEmeo9j5DuV2u1EuVFD8Di0GxNiM64To5O/Y66f7UASvnQr8.LCzqTm6awC8Kj/aGKvwA\"
    },
    {
    \"username\" : \"admin\",
    \"password\" : \"admin1\"
    },
    {
    \"username\" : \"root\",
    \"password\" : \"password\"
    }
    ],
    \"rdp.enabled\": false,
    \"sip.enabled\": false,
    \"snmp.enabled\": false,
    \"ntp.enabled\": false,
    \"tftp.enabled\": false,
    \"ntp.port\": \"123\",
    \"telnet.port\": \"23\",
    \"telnet.enabled\": false,
    \"telnet.banner\": \"\",
    \"telnet.honeycreds\" : [
	{
	    \"username\" : \"admin\",
	    \"password\" : \"$pbkdf2-sha512$19000$bG1NaY3xvjdGyBlj7N37Xw$dGrmBqqWa1okTCpN3QEmeo9j5DuV2u1EuVFD8Di0GxNiM64To5O/Y66f7UASvnQr8.LCzqTm6awC8Kj/aGKvwA\"
	},
	{
	    \"username\" : \"admin\",
	    \"password\" : \"admin1\"
	}
    ],
    \"vnc.enabled\": false
}
" > /root/opencanary_default.conf
cp /root/opencanary_default.conf /home/vagrant/opencanary.conf
chown vagrant /home/vagrant/opencanary.conf
sudo apt-get autoremove -y
sudo apt-get remove rpcbind -y
echo "########################################################"
echo "     Starting opencanaryd     "
echo "########################################################"
opencanaryd --start
echo "########################################################"
echo "     Ifconfig Output:     "
echo "########################################################"
ifconfig
echo "########################################################"
echo "     Canary Log Output:     "
echo "########################################################"
cat /var/tmp/opencanary.log

