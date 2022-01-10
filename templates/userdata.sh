#!/usr/bin/bash

apt-get -y update
apt -y install unzip
apt -y install nginx
 
echo hello patra > /var/www/html/index.nginx-debian.html 

curl --output amazon-cloudwatch-agent.deb https://s3.amazonaws.com/amazoncloudwatch-agent/debian/amd64/latest/amazon-cloudwatch-agent.deb
dpkg -i amazon-cloudwatch-agent.deb
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

cat <<EOF > /opt/aws/amazon-cloudwatch-agent/bin/config.json
{
	"agent": {
		"run_as_user": "root"
	},
	"logs": {
		"logs_collected": {
			"files": {
				"collect_list": [
					{
						"file_path": "/var/log/nginx/access.log",
						"log_group_name": "access.log",
						"log_stream_name": "{instance_id}"
					},
					{
						"file_path": "/var/log/nginx/error.log",
						"log_group_name": "error.log",
						"log_stream_name": "{instance_id}"
					}
				]
			}
		}
	}
}
EOF

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a start
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s
