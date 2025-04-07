# Particionado del disco duro
Notas y observaciones sobre el particionado requerido para el disco duro.

### Encriptación luks2

### sda; sda1, sda2, sda5...
Nombre histórico, son las siglas de **SCSI disk A**. También está aceptado el acrónimo de SATA Drive A.
Los números a continuación también son deudores de formatos de partición antiguos, los siendo los cuatro primeros números los indicadores de las cuatro particiones primarias, y los siguientes enumeran las particiones lógicas.

- /dev/sda1 es la partición **EFI** o la partición de arranque.

#### Particiones primarias, particiones lógicas
Un disco con una etiqueta DOS únicamente puede tener 4 particiones primarias. Para extender el número de particiones, las siguientes son particiones **lógicas**, que se encuentran completamente contenidas dentro de la última partición primaria. Las particiones lógicas son, por tanto, parte de particiones **extendidas**.

Estos conceptos son herencia histórica del esquema de partición **MBR** (Master Boot Record). Este esquema se encuentra en desuso, desplazado por **GUID** (Globally Unique Identifier), parte del estándar **UEFI**.

### LVM, RAID
LVM (o Logical Volume Manager), es un gestor de volúmenes lógicos. Los volúmenes lógicos agrupan 

### KDump


## Links
- https://tldp.org/HOWTO/Partition-Mass-Storage-Definitions-Naming-HOWTO/x99.html