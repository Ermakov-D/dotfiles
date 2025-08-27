#!/bin/bash

# --- Переменные конфигурации ---
INTERFACE="enp6s0"
IPV6_ADDR="2a03:e2c0:4f0d:2::10/64" # Стандартная /64 маска подсети для IPv6
IPV6_DEF_GW="2a03:e2c0:4f0d:2::1"
# Функция для проверки наличия IPv6 адреса
check_ipv6() {
    # Ищем любую строку 'inet6' в выводе команды ip.
    # Флаг -q (quiet) отключает вывод, мы проверяем только код возврата.
    if ip -6 addr show dev "$INTERFACE" 2>/dev/null | grep -q -E "^\s+inet6.*scope global" ; then
        echo "󰱔 IPv6"
    else
        echo "󰱟 noIPv6"
    fi
}

# Функция для назначения IPv6 адреса
activate_ipv6() {
    sudo /usr/bin/ip addr add "$IPV6_ADDR" dev "$INTERFACE"
}

# Функция для удаления IPv6 адреса
deactivate_ipv6() {
    # Проверяем, запущен ли скрипт с правами root
    if [ "$EUID" -ne 0 ]; then
        echo "Ошибка: Для этой операции требуются права суперпользователя (sudo)."
        exit 1
    fi
    echo "Удаляю IPv6 адрес $IPV6_ADDR с интерфейса $INTERFACE..."
    ip addr del "$IPV6_ADDR" dev "$INTERFACE"
    echo "Адрес успешно удален."
}

# --- Основная логика скрипта ---
# Анализируем первый аргумент, переданный скрипту
case "$1" in
    "--activate")
        sudo /usr/bin/ip addr add "$IPV6_ADDR" dev "$INTERFACE"
        sudo /usr/bin/ip route add default via "$IPV6_DEF_GW" dev "$INTERFACE"
        ;;
    "--deactivate")
        sudo /usr/bin/ip route delete default via "$IPV6_DEF_GW" dev "$INTERFACE"
        sudo /usr/bin/ip addr del "$IPV6_ADDR" dev "$INTERFACE"
        ;;
    --"action")
        if ip -6 addr show dev "$INTERFACE" 2>/dev/null | grep -q -E "^\s+inet6.*scope global"; then
            #echo "Deactivate"
            sudo /usr/bin/ip route delete default via ${IPV6_DEF_GW} dev ${INTERFACE}
            sudo /usr/bin/ip addr del ${IPV6_ADDR} dev ${INTERFACE}
        else
            #echo "Activate"
            sudo /usr/bin/ip addr add ${IPV6_ADDR} dev ${INTERFACE}
            sudo /usr/bin/ip route add default via ${IPV6_DEF_GW} dev ${INTERFACE}
 
        fi
        ;;
    *)
        check_ipv6
        ;;
esac

exit 0

