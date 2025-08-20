#!/bin/bash
#pip install micropython-mpremote

esptool.py --chip esp32 --port /dev/ttyUSB0 erase_flash

#(venv) wgn@fedora:/run/media/wgn/libvirt_ext4/Projects-Srcs-Etec/catracas-esp32-micropython$ esptool.py --chip esp32 --port /dev/ttyUSB0 erase_flash
#Warning: DEPRECATED: 'esptool.py' is deprecated. Please use 'esptool' instead. The '.py' suffix will be removed in a future major release.
#Warning: Deprecated: Command 'erase_flash' is deprecated. Use 'erase-flash' instead.
#esptool v5.0.2
#Connected to ESP32 on /dev/ttyUSB0:
#Chip type:          ESP32-D0WDQ6 (revision v1.0)
#Features:           Wi-Fi, BT, Dual Core + LP Core, 240MHz, Vref calibration in eFuse, Coding Scheme None
#Crystal frequency:  40MHz
#MAC:                9c:9c:1f:c5:0e:a8
#
#Stub flasher running.
#
#Flash memory erased successfully in 7.0 seconds.
#
#Hard resetting via RTS pin...

# https://micropython.org/download/ESP32_GENERIC/
# esptool.py --chip esp32 --port /dev/ttyUSB0 --baud 460800 write_flash -z 0x1000 firmware.bin
#(venv) wgn@fedora:/run/media/wgn/libvirt_ext4/Projects-Srcs-Etec/catracas-esp32-micropython$ esptool.py --chip esp32 --port /dev/ttyUSB0 --baud 460800 write_flash -z 0x1000 '/run/media/wgn/libvirt_ext4/Projects-Srcs-Etec/ESP32_GENERIC-20250809-v1.26.0.bin' 



#(venv) wgn@fedora:/run/media/wgn/libvirt_ext4/Projects-Srcs-Etec/catracas-esp32-micropython$ pip3 install mpremote


#Passo 2: Copiar os Arquivos

#O comando básico para copiar é mpremote cp <origem> :<destino>, onde o : (dois pontos) representa a raiz do sistema de arquivos do ESP32.

#O desafio é que mpremote não tem uma opção de --exclude como outras ferramentas.


# Conecta na porta, copia o conteúdo de src/ para a raiz (:) do ESP32
#mpremote connect /dev/ttyUSB0 fs cp -r src/. :

#mpremote ls

mpremote repl

