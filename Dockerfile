# from registry.cn-hangzhou.aliyuncs.com/rancococ/oraclejre:1.8.0_192.5-centos
FROM registry.cn-hangzhou.aliyuncs.com/rancococ/oraclejre:1.8.0_192.5-centos

# maintainer
MAINTAINER "rancococ" <rancococ@qq.com>

# set arg info
ARG WRAPPER_URL=https://github.com/rancococ/wrapper/archive/v3.5.41.1.tar.gz
ARG JMX_EXPORTER_VERSION=0.12.0
ARG JMX_EXPORTER_URL=https://mirrors.huaweicloud.com/repository/maven/io/prometheus/jmx/jmx_prometheus_javaagent/${JMX_EXPORTER_VERSION}/jmx_prometheus_javaagent-${JMX_EXPORTER_VERSION}.jar

# copy script
COPY ./assets/. /tmp/assets/

# install wrapper
RUN mkdir -p /data/app && \
    mkdir -p /data/app/exporter && \
    tempuuid=$(cat /proc/sys/kernel/random/uuid) && mkdir -p /tmp/${tempuuid} && \
    wget -c -O /tmp/${tempuuid}/wrapper.tar.gz --no-check-certificate ${WRAPPER_URL} && \
    tar -zxf /tmp/${tempuuid}/wrapper.tar.gz -C /tmp/${tempuuid} && \
    wrappername=$(tar -tf /tmp/${tempuuid}/wrapper.tar.gz | awk -F "/" '{print $1}' | sed -n '1p') && \
    \cp -rf /tmp/${tempuuid}/${wrappername}/. /data/app && \
    \cp -rf /data/app/conf/wrapper.single.temp /data/app/conf/wrapper.conf && \
    \cp -rf /data/app/conf/wrapper-property.single.temp /data/app/conf/wrapper-property.conf && \
    \cp -rf /data/app/conf/wrapper-additional.single.temp /data/app/conf/wrapper-additional.conf && \
    sed -i 's/^set.JAVA_HOME/#&/g' "/data/app/conf/wrapper.conf" && \
    \rm -rf /data/app/conf/*.temp && \
    wget -c -O /data/app/exporter/jmx_prometheus_javaagent-${JMX_EXPORTER_VERSION}.jar --no-check-certificate ${JMX_EXPORTER_URL} && \
    \cp -rf /tmp/assets/jmx_exporter.yml /data/app/exporter/ && \
    sed -i "/^-server$/i\-javaagent:%WRAPPER_BASE_DIR%/exporter/jmx_prometheus_javaagent-${JMX_EXPORTER_VERSION}.jar=9404:%WRAPPER_BASE_DIR%/exporter/jmx_exporter.yml" "/data/app/conf/wrapper-additional.conf" && \
    \rm -rf /tmp/assets && \
    \rm -rf /tmp/${tempuuid} && \
    \rm -rf /data/app/bin/*.bat && \
    \rm -rf /data/app/bin/*.exe && \
    \rm -rf /data/app/libcore/*.dll && \
    \rm -rf /data/app/libextend/*.dll && \
    \rm -rf /data/app/tool && \
    find /data/app | xargs touch && \
    find /data/app -type d -print | xargs chmod 755 && \
    find /data/app -type f -print | xargs chmod 644 && \
    chmod 744 /data/app/bin/* && \
    chmod 644 /data/app/bin/*.jar && \
    chmod 644 /data/app/bin/*.cnf && \
    chmod 600 /data/app/conf/*.password && \
    chmod 777 /data/app/logs && \
    chmod 777 /data/app/temp && \
    chown -R app:app /data/app && \
    /data/app/bin/wrapper-create-linkfile.sh

# set work home
WORKDIR /data

# expose port
EXPOSE 8080 10087 10001 10002

# stop signal
STOPSIGNAL SIGTERM

# entry point
ENTRYPOINT ["/docker-entrypoint.sh"]

# default command
CMD ["/data/app/bin/wrapper-linux-x86-64", "/data/app/conf/wrapper.conf", "wrapper.syslog.ident=myapp", "wrapper.pidfile=/data/app/bin/myapp.pid", "wrapper.name=myapp", "wrapper.displayname=myapp", "wrapper.statusfile=/data/app/bin/myapp.status", "wrapper.java.statusfile=/data/app/bin/myapp.java.status", "wrapper.script.version=3.5.41"]
