# from registry.cn-hangzhou.aliyuncs.com/rancococ/oraclejre:1.8.0_192.5-alpine
FROM registry.cn-hangzhou.aliyuncs.com/rancococ/oraclejre:1.8.0_192.5-alpine

# maintainer
MAINTAINER "rancococ" <rancococ@qq.com>

# set arg info
ARG version=3.5.43.6
ARG jre_version=1.8.192
ARG wrapper_version=3.5.43.6
ARG wrapper_url=https://github.com/rancococ/wrapper/archive/single-${version}.tar.gz

# copy script
COPY docker-preprocess.sh /

# install wrapper-single
RUN mkdir -p /data/app && \
    tempuuid=$(cat /proc/sys/kernel/random/uuid) && mkdir -p /tmp/${tempuuid} && \
    wget -c -O /tmp/${tempuuid}/wrapper.tar.gz --no-check-certificate ${wrapper_url} && \
    tar -zxf /tmp/${tempuuid}/wrapper.tar.gz --directory=/data/app --strip-components=1 && \
    sed -i 's/^set.JAVA_HOME/#&/g' "/data/app/conf/wrapper.conf" && \
    \rm -rf /tmp/${tempuuid} && \
    \rm -rf /data/app/bin/*.bat && \
    \rm -rf /data/app/bin/*.exe && \
    \rm -rf /data/app/conf/wrapper-property.conf && \
    \rm -rf /data/app/conf/wrapper-additional.conf && \
    \rm -rf /data/app/libcore/*.dll && \
    \rm -rf /data/app/libextend/*.dll && \
    \rm -rf /data/app/tool && \
    find /data/app -type f -name ".gitignore" | xargs rm -rf && \
    find /data/app -type f -name ".keep" | xargs rm -rf && \
    find /data/app | xargs touch && \
    find /data/app -type d -print | xargs chmod 755 && \
    find /data/app -type f -print | xargs chmod 644 && \
    touch /data/app/bin/version && \
    echo "jre:${jre_version}" >> /data/app/bin/version && \
    echo "wrapper:${wrapper_version}" >> /data/app/bin/version && \
    chmod 744 /data/app/bin/* && \
    chmod 644 /data/app/bin/*.jar && \
    chmod 644 /data/app/bin/*.cnf && \
    chmod 644 /data/app/bin/version && \
    chmod 600 /data/app/conf/*.password && \
    chmod 777 /data/app/logs && \
    chmod 777 /data/app/temp && \
    chown -R app:app /data/app && \
    chown -R app:app /docker-preprocess.sh && \
    chmod +x /docker-preprocess.sh && \
    /data/app/bin/wrapper-create-linkfile.sh

# set work home
WORKDIR /data/app

# expose port
EXPOSE 9404 8080 10087 10001 10002

# stop signal
STOPSIGNAL SIGTERM

# entry point
ENTRYPOINT ["/docker-entrypoint.sh"]

# default command
CMD ["/data/app/bin/wrapper-linux-x86-64", "/data/app/conf/wrapper.conf", "wrapper.syslog.ident=myapp", "wrapper.name=myapp", "wrapper.displayname=myapp", "wrapper.pidfile=/data/app/bin/myapp.pid", "wrapper.statusfile=/data/app/bin/myapp.status", "wrapper.java.pidfile=/data/app/bin/myapp.java.pid", "wrapper.java.idfile=/data/app/bin/myapp.java.id", "wrapper.java.statusfile=/data/app/bin/myapp.java.status", "wrapper.script.version=3.5.43"]
