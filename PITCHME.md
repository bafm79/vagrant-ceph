# CEPH

- Software que permite criar um ambiente com espaço de armazenamento escalável, com replicação e tolerância a falhas.
- É um storage de objetos (RADOS), que fornece interface para storage de:
- Objeto
- Bloco
- Arquivo

#HSLIDE

### --- 

- OSDs: Daemon responsável por armazenar os dados, replicá-los, fazer o balanceamento e se comunicar com os monitors deixando-os atualizados quanto ao mapeamento dos dados. Cada processo osd controla um disco e armazena os dados em sistema de arquivos xfs (bluestore irá usar bloco, ainda não estável)
- MONs: Verifica o funcionamento do Cluster CEPH, o mapeamento dos monitores e dos OSD, os mapas dos PG e o CRUSH. Guarda ainda as alterações ocorridas nos Monitors,OSDs e PGs.
- MDSs: Metadata Server, armazena os metadados para dar apoio ao Ceph Filesystem (o Ceph Block Devices e Ceph Object Storage não usam MDS). Ele serve apenas para auxiliar o CEPH FS, tornando possível que usuários de sistemas executem comandos triviais como ls, find, etc…
- CRUSH:	É o algoritmo responsável por determinar como armazenar e coletar os dados. Ele permite que os clientes CEPH se comuniquem diretamente com os OSD invés de precisar de um servidor ou controlador para intermediar a comunicação.
- PG: Placement Group - agrega os objetos dentro de um pool, já que rastrear objetos e seus metadados em um sistema de armazenamento de objetos pode gerar um custo computacional considerável.
- RADOS: Storage de objetos nativo do ceph
- Librados: 	biblioteca para acessar diretamente o storage de objetos RADOS (disponivem em C, java, python, php)
- Rados GW: expõe o storage de objetos compativel com APIs Amazon S3 e Openstack Swift

#HSLIDE

![ceph](http://docs.ceph.com/docs/giant/_images/stack.png)
