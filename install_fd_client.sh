rpm --import https://www.bacula.org/downloads/Bacula-4096-Distribution-Verification-key.asc

cp -rf bacula-community.repo /etc/yum.repos.d/bacula-community.repo

sed -i s/BACULA_VERSION/$(echo $BACULA_VERSION)/g /etc/yum.repos.d/bacula-community.repo \
  && sed -i s/BACULA_KEY/$(echo $BACULA_KEY)/g /etc/yum.repos.d/bacula-community.repo

rpm -i https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm

yum -y install epel-release

# dnf -y install postgresql \
yum -y install \
	postgresql10 \
	zip \
	bzip2 \
	mtx 

yum install -y bacula-postgresql-$BACULA_VERSION --exclude=bacula-mysql

yum -y clean all && rm -rf /var/cache/yum

for i in `ls /opt/bacula/bin`; do ln -s /opt/bacula/bin/$i /usr/sbin/$i; done 