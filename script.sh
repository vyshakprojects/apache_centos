
!#/bin/bsah
clear
echo "enter domain name "
read name

#changing templete file temp.txt
sed -i "s/domain/$name/g" temp.txt

yum -y update


#installing package httpd
yum install httpd -y


#disabling httpd for conf edit
systemctl stop httpd


#configuring firewall
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --zone=public --permanent --add-service=https
firewall-cmd --reload


#creating conf file and adding contents from temp.txt file
cat temp.txt > /etc/httpd/conf.d/vhost.conf


#creating documet root directory
mkdir -p /var/www/html/$name


#creating sample html file
echo "Welcome to My sample Website" > /var/www/html/$name/index.html


#checking httpd syntax
'httpd -t'


#starting httpd services
systemctl enable httpd
systemctl start httpd
systemctl status httpd

echo "sample website creation successfull"


#changing tmp.txt file back for future use
#changing templete file temp.txt
sed -i 's/$name/domain/g' temp.txt


