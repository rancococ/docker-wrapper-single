#!/bin/bash

set -e

# export environment variable
fun_export_environment_variable() {
    echo "export environment variable :"

    # prop
    export PROP_APP_NAME=${PROP_APP_NAME:="myapp"}
    export PROP_APP_LONG_NAME=${PROP_APP_LONG_NAME:="myapp"}
    export PROP_APP_DESC=${PROP_APP_DESC:="myapp"}
    export PROP_APP_LAUNCHER=${PROP_APP_LAUNCHER:="org.springframework.boot.loader.JarLauncher"}
    export PROP_RUN_AS_USER=${PROP_RUN_AS_USER:=""}
    # jvm
    export JVM_JMX_EXPORTER_ENABLED=${JVM_JMX_EXPORTER_ENABLED:="true"}
    export JVM_JMX_EXPORTER_PORT=${JVM_JMX_EXPORTER_PORT:="9404"}
    export JVM_HEAP_DUMP_ENABLED=${JVM_HEAP_DUMP_ENABLED:="false"}
    export JVM_PRINT_GC_ENABLED=${JVM_PRINT_GC_ENABLED:="true"}
    export JVM_XMS=${JVM_XMS:="4096M"}
    export JVM_XMX=${JVM_XMX:="4096M"}
    export JVM_XSS=${JVM_XSS:="1M"}
    export JVM_METASPACE_SIZE=${JVM_METASPACE_SIZE:="128M"}
    export JVM_MAX_METASPACE_SIZE=${JVM_MAX_METASPACE_SIZE:="256M"}
    export JVM_MAX_DIRECT_MEMORY_SIZE=${JVM_MAX_DIRECT_MEMORY_SIZE:="4096M"}
    export JVM_REMOTE_DEBUG_ENABLED=${JVM_REMOTE_DEBUG_ENABLED:="false"}
    export JVM_REMOTE_DEBUG_SUSPEND=${JVM_REMOTE_DEBUG_SUSPEND:="n"}
    export JVM_REMOTE_DEBUG_PORT=${JVM_REMOTE_DEBUG_PORT:="10087"}
    export JVM_JMX_REMOTE_ENABLED=${JVM_JMX_REMOTE_ENABLED:="false"}
    export JVM_JMX_REMOTE_SSL=${JVM_JMX_REMOTE_SSL:="false"}
    export JVM_JMX_REMOTE_AUTH=${JVM_JMX_REMOTE_AUTH:="true"}
    export JVM_JMX_REMOTE_RMI_SERVER_HOSTNAME=${JVM_JMX_REMOTE_RMI_SERVER_HOSTNAME:="127.0.0.1"}
    export JVM_JMX_REMOTE_RMI_REGISTRY_PORT=${JVM_JMX_REMOTE_RMI_REGISTRY_PORT:="10001"}
    export JVM_JMX_REMOTE_RMI_SERVER_PORT=${JVM_JMX_REMOTE_RMI_SERVER_PORT:="10002"}
    export JVM_HTTP_LISTEN_PORT=${JVM_HTTP_LISTEN_PORT:="8080"}
    export JVM_SHUTDOWN_PORT=${JVM_SHUTDOWN_PORT:="-1"}
    export JVM_OTHER_PARAMETERS=${JVM_OTHER_PARAMETERS:=""}

    echo "successfully exported environment variable"

    return 0
}

# generate wrapper-environment.json
fun_generate_wrapper_environment_file() {
    echo "generate wrapper-environment.json :"

    set +e

    # generate wrapper-environment.json
    if [ ! -f "/data/app/conf/wrapper-environment.json" ]; then
        echo "file [/data/app/conf/wrapper-environment.json] does not exist, generate /data/app/conf/wrapper-environment.json."

        # environment file
        envfile_path=/data/app/conf/wrapper-environment.json
        touch ${envfile_path}
        echo "{"                                                                                      >> ${envfile_path}
        echo "    \"Prop\": {"                                                                        >> ${envfile_path}
        echo "        \"AppName\": \"${PROP_APP_NAME}\","                                             >> ${envfile_path}
        echo "        \"AppLongName\": \"${PROP_APP_LONG_NAME}\","                                    >> ${envfile_path}
        echo "        \"AppDesc\": \"${PROP_APP_DESC}\","                                             >> ${envfile_path}
        echo "        \"AppLauncher\": \"${PROP_APP_LAUNCHER}\","                                     >> ${envfile_path}
        echo "        \"RunAsUser\": \"${PROP_RUN_AS_USER}\""                                         >> ${envfile_path}
        echo "    },"                                                                                 >> ${envfile_path}
        echo "    \"Jvm\": {"                                                                         >> ${envfile_path}
        echo "        \"JmxExporter\": {"                                                             >> ${envfile_path}
        echo "            \"Enabled\": \"${JVM_JMX_EXPORTER_ENABLED}\","                              >> ${envfile_path}
        echo "            \"Port\": \"${JVM_JMX_EXPORTER_PORT}\""                                     >> ${envfile_path}
        echo "        },"                                                                             >> ${envfile_path}
        echo "        \"HeapDumpEnabled\": \"${JVM_HEAP_DUMP_ENABLED}\","                             >> ${envfile_path}
        echo "        \"PrintGcEnabled\": \"${JVM_PRINT_GC_ENABLED}\","                               >> ${envfile_path}
        echo "        \"Xms\": \"${JVM_XMS}\","                                                       >> ${envfile_path}
        echo "        \"Xmx\": \"${JVM_XMX}\","                                                       >> ${envfile_path}
        echo "        \"Xss\": \"${JVM_XSS}\","                                                       >> ${envfile_path}
        echo "        \"MetaspaceSize\": \"${JVM_METASPACE_SIZE}\","                                  >> ${envfile_path}
        echo "        \"MaxMetaspaceSize\": \"${JVM_MAX_METASPACE_SIZE}\","                           >> ${envfile_path}
        echo "        \"MaxDirectMemorySize\": \"${JVM_MAX_DIRECT_MEMORY_SIZE}\","                    >> ${envfile_path}
        echo "        \"RemoteDebug\": {"                                                             >> ${envfile_path}
        echo "            \"Enabled\": \"${JVM_REMOTE_DEBUG_ENABLED}\","                              >> ${envfile_path}
        echo "            \"Suspend\": \"${JVM_REMOTE_DEBUG_SUSPEND}\","                              >> ${envfile_path}
        echo "            \"Port\": \"${JVM_REMOTE_DEBUG_PORT}\""                                     >> ${envfile_path}
        echo "        },"                                                                             >> ${envfile_path}
        echo "        \"JmxRemote\": {"                                                               >> ${envfile_path}
        echo "            \"Enabled\": \"${JVM_JMX_REMOTE_ENABLED}\","                                >> ${envfile_path}
        echo "            \"Ssl\": \"${JVM_JMX_REMOTE_SSL}\","                                        >> ${envfile_path}
        echo "            \"Auth\": \"${JVM_JMX_REMOTE_AUTH}\","                                      >> ${envfile_path}
        echo "            \"RmiServerHostname\": \"${JVM_JMX_REMOTE_RMI_SERVER_HOSTNAME}\","          >> ${envfile_path}
        echo "            \"RmiRegistryPort\": \"${JVM_JMX_REMOTE_RMI_REGISTRY_PORT}\","              >> ${envfile_path}
        echo "            \"RmiServerPort\": \"${JVM_JMX_REMOTE_RMI_SERVER_PORT}\""                   >> ${envfile_path}
        echo "        },"                                                                             >> ${envfile_path}
        echo "        \"HttpListenPort\": \"${JVM_HTTP_LISTEN_PORT}\","                               >> ${envfile_path}
        echo "        \"ShutdownPort\": \"${JVM_SHUTDOWN_PORT}\","                                    >> ${envfile_path}
        echo "        \"OtherParameters\": ["                                                         >> ${envfile_path}
        env | grep "JVM_OTHER_PARAMETERS_" | while read line
        do
        echo "            \"${line#*=}\","                                                            >> ${envfile_path}
        done
        echo "            \"\""                                                                       >> ${envfile_path}
        echo "        ]"                                                                              >> ${envfile_path}
        echo "    }"                                                                                  >> ${envfile_path}
        echo "}"                                                                                      >> ${envfile_path}

        chown app:app /data/app/conf/wrapper-environment.json
        chmod 644 /data/app/conf/wrapper-environment.json
    else
        if [ ! -r "/data/app/conf/wrapper-environment.json" ]; then
            echo "file [/data/app/conf/wrapper-environment.json] already exists, but it is not readable."
            exit 1
        else
            echo "file [/data/app/conf/wrapper-environment.json] already exists and is readable."
        fi
    fi

    echo "successfully generated wrapper-environment.json"

    set -e

    return 0
}

# generate wrapper-property.conf
fun_generate_wrapper_property_file() {
    echo "generate wrapper-property.conf :"

    # generate wrapper-property.conf
    if [ ! -f "/data/app/conf/wrapper-property.conf" ]; then
        echo "file [/data/app/conf/wrapper-property.conf] does not exist, generate /data/app/conf/wrapper-property.conf."
        /data/app/bin/gotmpl-linux-x86-64 --template=f:/data/app/conf/wrapper-property.tmpl \
                                          --jsondata=f:/data/app/conf/wrapper-environment.json \
                                          --outfile=/data/app/conf/wrapper-property.conf
        chown app:app /data/app/conf/wrapper-property.conf
        chmod 644 /data/app/conf/wrapper-property.conf
    else
        if [ ! -r "/data/app/conf/wrapper-property.conf" ]; then
            echo "file [/data/app/conf/wrapper-property.conf] already exists, but it is not readable."
            exit 1
        else
            echo "file [/data/app/conf/wrapper-property.conf] already exists and is readable."
        fi
    fi

    echo "successfully generated wrapper-property.conf"

    return 0
}

# generate wrapper-additional.conf
fun_generate_wrapper_additional_file() {
    echo "generate wrapper-additional.conf :"

    # generate wrapper-additional.conf
    if [ ! -f "/data/app/conf/wrapper-additional.conf" ]; then
        echo "file [/data/app/conf/wrapper-additional.conf] does not exist, generate /data/app/conf/wrapper-additional.conf."
        /data/app/bin/gotmpl-linux-x86-64 --template=f:/data/app/conf/wrapper-additional.tmpl \
                                          --jsondata=f:/data/app/conf/wrapper-environment.json \
                                          --outfile=/data/app/conf/wrapper-additional.conf
        chown app:app /data/app/conf/wrapper-additional.conf
        chmod 644 /data/app/conf/wrapper-additional.conf
    else
        if [ ! -r "/data/app/conf/wrapper-additional.conf" ]; then
            echo "file [/data/app/conf/wrapper-additional.conf] already exists, but it is not readable."
            exit 1
        else
            echo "file [/data/app/conf/wrapper-additional.conf] already exists and is readable."
        fi
    fi

    echo "successfully generated wrapper-additional.conf"

    return 0
}

echo "preprocess start."
# export environment variable
fun_export_environment_variable
# generate wrapper-environment.json
fun_generate_wrapper_environment_file
# generate wrapper-property.conf
fun_generate_wrapper_property_file
# generate wrapper-additional.conf
fun_generate_wrapper_additional_file
echo "preprocess end."

echo ""

exit $?
