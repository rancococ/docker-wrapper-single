#!/bin/bash

set -e

# export environment variable
export SINGLE_JMX_EXPORTER_ENABLED=${SINGLE_JMX_EXPORTER_ENABLED:="true"}
export SINGLE_JMX_EXPORTER_PORT=${SINGLE_JMX_EXPORTER_PORT:="9404"}
export SINGLE_HEAP_DUMP_ENABLED=${SINGLE_HEAP_DUMP_ENABLED:="false"}
export SINGLE_PRINT_GC_ENABLED=${SINGLE_PRINT_GC_ENABLED:="true"}
export SINGLE_XMS=${SINGLE_XMS:="4096M"}
export SINGLE_XMX=${SINGLE_XMX:="4096M"}
export SINGLE_XSS=${SINGLE_XSS:="1M"}
export SINGLE_METASPACE_SIZE=${SINGLE_METASPACE_SIZE:="128M"}
export SINGLE_MAX_METASPACE_SIZE=${SINGLE_MAX_METASPACE_SIZE:="1024M"}
export SINGLE_REMOTE_DEBUG_ENABLED=${SINGLE_REMOTE_DEBUG_ENABLED:="false"}
export SINGLE_REMOTE_DEBUG_SUSPEND=${SINGLE_REMOTE_DEBUG_SUSPEND:="n"}
export SINGLE_REMOTE_DEBUG_PORT=${SINGLE_REMOTE_DEBUG_PORT:="10087"}
export SINGLE_JMX_REMOTE_ENABLED=${SINGLE_JMX_REMOTE_ENABLED:="false"}
export SINGLE_JMX_REMOTE_SSL=${SINGLE_JMX_REMOTE_SSL:="false"}
export SINGLE_JMX_REMOTE_AUTH=${SINGLE_JMX_REMOTE_AUTH:="true"}
export SINGLE_JMX_REMOTE_RMI_SERVER_HOSTNAME=${SINGLE_JMX_REMOTE_RMI_SERVER_HOSTNAME:="127.0.0.1"}
export SINGLE_JMX_REMOTE_RMI_REGISTRY_PORT=${SINGLE_JMX_REMOTE_RMI_REGISTRY_PORT:="10001"}
export SINGLE_JMX_REMOTE_RMI_SERVER_PORT=${SINGLE_JMX_REMOTE_RMI_SERVER_PORT:="10002"}
export SINGLE_HTTP_LISTEN_PORT=${SINGLE_HTTP_LISTEN_PORT:="8080"}
export SINGLE_SHUTDOWN_PORT=${SINGLE_SHUTDOWN_PORT:="-1"}
export SINGLE_OTHER_PARAMETERS=${SINGLE_OTHER_PARAMETERS:=""}

# generate wrapper-environment.json
envsubst < /data/app/conf/wrapper-environment.tmpl > /data/app/conf/wrapper-environment.json

# generate wrapper-additional.conf
/data/app/bin/gotmpl-linux-x86-64 --template=f:/data/app/conf/wrapper-additional.tmpl \
                                  --jsondata=f:/data/app/conf/wrapper-environment.json \
                                  --outfile=/data/app/conf/wrapper-additional.conf
