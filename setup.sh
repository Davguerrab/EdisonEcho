#! /bin/bash

opkg update
opkg install libasound2-dev python-pip mpg123 alsa-utils alsa-lib-dev  python-audio python-opencv
pip install -r requirements.txt
cp edison_developing/initd_alexa.sh /etc/alexa
cd /etc
ln -s ../alexa S99alexa
touch /var/log/alexa.log

#Install MRAA library from Intel GitHub
#echo "Installing other dependencies"
#apt-get install swig

echo "Installing MRAA"
#git clone https://github.com/intel-iot-devkit/mraa.git
#mkdir mraa/build && cd $_
#cmake .. -DBUILDSWIGNODE=OFF
#make
#make install
#cd
echo "MRAA install DONE"

echo "Enter your ProductID:"
read productid
echo ProductID = \"$productid\" >> edison_developing/creds.py

echo "Enter your Security Profile Description:"
read spd
echo Security_Profile_Description = \"$spd\" >> edison_developing/creds.py

echo "Enter your Security Profile ID:"
read spid
echo Security_Profile_ID = \"$spid\" >> edison_developing/creds.py

echo "Enter your Security Client ID:"
read cid
echo Client_ID = \"$cid\" >> edison_developing/creds.py

echo "Enter your Security Client Secret:"
read secret
echo Client_Secret = \"$secret\" >> edison_developing/creds.py

ip = `ifconfig wlan0 | grep "inet addr" | cut -d ':' -f 2 | cut -d ' ' -f 1`
python edison_developing/auth_web.py 
echo "Open http://$ip:5000"

echo "You can now reboot"

