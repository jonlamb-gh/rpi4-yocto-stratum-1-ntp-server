FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# Replace the iptable.rules variables with the env var values using sed
# NOTE: these env vars must also be in BB_ENV_EXTRAWHITE
do_install_append() {
    if [ -z "${IPTABLES_ICMP_ALLOW_IP_RANGE}" ]; then
        bbfatal "Missing env var IPTABLES_ICMP_ALLOW_IP_RANGE"
    fi
    if [ -z "${IPTABLES_SSH_ALLOW_CIDR}" ]; then
        bbfatal "Missing env var IPTABLES_SSH_ALLOW_CIDR"
    fi
    if [ -z "${IPTABLES_DNS_SERVER_IP}" ]; then
        bbfatal "Missing env var IPTABLES_DNS_SERVER_IP"
    fi

    # Delimter == '#'
    sed -i "s#IPTABLES_ICMP_ALLOW_IP_RANGE#${IPTABLES_ICMP_ALLOW_IP_RANGE}#" ${D}/${sysconfdir}/iptables/iptables.rules
    sed -i "s#IPTABLES_SSH_ALLOW_CIDR#${IPTABLES_SSH_ALLOW_CIDR}#" ${D}/${sysconfdir}/iptables/iptables.rules
    sed -i "s#IPTABLES_DNS_SERVER_IP#${IPTABLES_DNS_SERVER_IP}#" ${D}/${sysconfdir}/iptables/iptables.rules
}
