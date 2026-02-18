#!/bin/bash
dateipfad=$(cd `dirname $0` && pwd)
echo $dateipfad
filename="/etc/systemd/system/smartmeter.service"
sudo rm /etc/systemd/system/smartmeter.service
echo "[Unit]" >> "$filename"
echo "Description=SmartMeterData Script" >> "$filename"
echo "After=multi-user.target network.target influxdb.service" >> "$filename"
echo "" >> "$filename"
echo "[Service]" >> "$filename"
echo "Type=simple" >> "$filename"
echo "Restart=always" >> "$filename"
echo "RestartSec=10" >> "$filename"
echo "StandardOutput=journal" >> "$filename"
echo "StandardError=journal" >> "$filename"
echo "ExecStart=/usr/bin/python3 $dateipfad/AusleseSkript.py" >> "$filename"
echo "" >> "$filename"
echo "[Install]" >> "$filename"
echo "WantedBy=multi-user.target" >> "$filename"
echo "File $filename created."
sudo systemctl daemon-reload 
sudo systemctl enable smartmeter.service
sudo systemctl start smartmeter.service