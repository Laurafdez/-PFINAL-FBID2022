~~~

     ___             ___         _  __            __                    __       
    / _ \_______ ___/ (_)_______(_)/_/ ___    ___/ /__   _  ____ _____ / /__  ___
   / ___/ __/ -_) _  / / __/ __/ / _ \/ _ \  / _  / -_) | |/ / // / -_) / _ \(_-<
  /_/  /_/  \__/\_,_/_/\__/\__/_/\___/_//_/  \_,_/\__/  |___/\_,_/\__/_/\___/___/
                                                                               

~~~
FBID - MUIRST

2022

Laura Fernández Galindo & Patricia Ortuño Otero

# Instrucciones

>__Note__ Debe escoger una de las dos opciones de creación de una máquina virtual Ubuntu 22.04 para desplegar el escenario. Se proporcionan instrucciones para una instalación local en VirtualBox a partir de una imagen ISO, y para la creación de un Ubuntu Desktop a través de Google Cloud. Luego se debe escoger que modo de ejecución se desea, local o en contenedores con Docker Compose.

- [Crear VM Ubuntu en VirtualBox](#crearvmlocal)
- [Crear VM Ubuntu en Google Cloud (RECOMENDADO)](#crearvm)
- [Ejecutar el escenario local](#base)
- [Ejecutar el escenario con Docker Compose (RECOMENDADO)](#docker)

## Crear máquina virtual Ubuntu 22.04 VirtualBox <a name="crearvmlocal"></a>

A continuación, se proporcionan las instrucciones para crear una máquina virtual con Ubuntu 22.04 en VirtualBox, para el despliegue del escenario localmente.

1. Descargar [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. Crear una nueva máquina, con las siguientes características:
     - Tipo: Linux
     - Versión: Ubuntu 22.04 LTS (Jammy Jellyfish) (64 bit)
     - Memoria base (*recomendado*): > 4096 MB
     - Procesadores (*recomendado*): > 2
     - Tamaño de disco (*recomendado*): > 25 GB
3. Para tener acceso a Internet: Configuración -> Red -> Adaptador1 -> Adaptador puente
4. Inicie la máquina
5. Le solicitará una imagen ISO para hacer la instalación. Descargar [Ubuntu 22.04 Desktop Image (64-bit AMD64)](https://releases.ubuntu.com/22.04/) de la web oficial.
6. Siga los pasos para realizar la instalación. Se recomienda escoger la instalación mínima por cuestiones de rendimiento y velocidad de la descarga.
7. Al terminar la descarga, reinicie la máquina virtual. Presione *Enter* cuando se le solicite.
8. Clonar este repositorio dentro de la máquina creada, y acceda al mismo:
     ```console
     cd
     git clone https://github.com/patriciaOrtuno28/PFINAL-FBID2022.git
     cd PFINAL-FBID2022
     ```

>__Note__ Para cambiar la resolución acceda a Settings -> Displays -> Resolution

## Crear máquina virtual Ubuntu 22.04 Google Cloud (RECOMENDADO) <a name="crearvm"></a>

1. Acceder a [Google Cloud Compute](https://console.cloud.google.com/compute) con sus credenciales.
2. Crear una nueva instancia:
  - Compute Engine -> Instancias de VM
  - Crear instancia
    - Zona: europe-southwest1-a
    - Disco de arranque:
      - Ubuntu 22.04 LTS Minimal (Arquitectura x86-64)
      - Tamaño de disco (*recomendado*): > 15 GB
    - Firewall: permitir tráfico HTTP y HTTPS
3. Clonar este repositorio dentro de la máquina creada, y acceda a él:
     ```console
     cd
     git clone https://github.com/patriciaOrtuno28/PFINAL-FBID2022.git
     cd PFINAL-FBID2022
     ```
     >__Note__ Si la máquina no reconoce el comando git, ejecute el siguiente comando: `sudo apt-get update && sudo apt install -y git`
     
4. Para la realización de esta práctica se utilizará Ubuntu 22.04 Desktop. Para ello, se proporciona un fichero automatizado de instalación de las dependencias necesarias.

     >__Note__ Si se pide el reinicio de algún servicio, marque ambas opciones (utilizando la barra espaciadora). Cuando estén marcados (aparecerá un [*]), presione   Enter.

     >__Warning__ El usuario que se va a crear se llama `fbid`

     ```console
     chmod 777 desktop.sh
     ```
     Ahora podemos ejecutarlo:
     ```console
     ./desktop.sh
     ```
     
     Se le solicitarán los siguientes datos:
     - Keyboard Layout: (*Spanish*) 84 y 1 respectivamente.
     - New password: <*your_new_password*>
     - Como resultado del adduser se le solicitará una contraseña. Introduzca la misma que introdujo anteriormente. El resto de campos déjelos vacios.

5. Para tener conectividad dentro de esta máquina, vamos a añadir una nueva regla al Firewall en Google Cloud:
     - Google Cloud -> Red de VPC -> Firewall
     - Crear una regla de Firewall
          - Nombre: ubuntu-desktop
          - Etiquetas de destino: ubuntu-desktop
          - Rangos de IPv4 de origen: 0.0.0.0/0
          - Protocolos y puertos especificados: TCP - 4000 y UDP - 4000
     
     Verá el siguiente mensaje por pantalla: `Se creó correctamente la regla de firewall "ubuntu-desktop".`
6. Hay que añadir esa regla a la instancia creada. Para ello hacemos clic sobre el nombre de la instancia y seleccionamos Editar. Hay que bajar hasta etiquetas de red y añadir `ubuntu-desktop`, dentro de Interfaces de red.
7. Para trabajar con Ubuntu Desktop con interfaz gráfica, en vez de la terminal proporcionada por Google Cloud, descargue [NoMachine](https://downloads.nomachine.com/es/). Tras completar la instalación, se le solicitará reiniciar el dispositivo.
8. Para añadir una nueva máquina seleccionar Añadir e introducir los siguientes datos:
     - Nombre: fbid
     - Host: IP externa (*Se puede ver donde hemos creado la instancia*)
     - Puerto: 4000 (*El que habíamos abierto en el Firewall*)
     - Protocolo: NX
9. Darle a Conectar en la máquina creada. Aparecerá una advertencia sobre la huella del certificado. Pinche OK.
10. Inicie sesión con las credenciales que creó durante la ejecución del fichero desktop.sh.
11. Verá el siguiente mensaje `No se puede detectar ninguna pantalla en ejecución ¿Desea que NoMachine cree una nueva y proceda a conectarse con el escritorio?` Pinche Sí.

## Ejecutar el escenario local <a name="base"></a>

### Instalar las dependencias 
#### Tecnologías
- [Python3](https://es.wikipedia.org/wiki/Python)
- [Pip](https://es.wikipedia.org/wiki/Pip_(administrador_de_paquetes))
- [Sbt](https://en.wikipedia.org/wiki/Sbt_(software))
- [MongoDB](https://www.mongodb.com/)
- [Spark](https://spark.apache.org/)
- [Scala](https://www.scala-lang.org/)
- [Zookeeper](https://zookeeper.apache.org/)
- [Kafka](https://kafka.apache.org/)

#### Instalación
Para la realización de esta práctica de predicción de vuelos, se requiere un escenario con las tecnologías mencionadas en el apartado anterior previamente instaladas. Para ello se proporciona un script automatizado que las instalará, con versiones acordes al escenario a ejecutar posteriormente.

>__Note__ Si escogió la instalación en Google Cloud, acceda al directorio base `cd` y clone de nuevo el proyecto dentro del Ubuntu Desktop: `git clone https://github.com/patriciaOrtuno28/PFINAL-FBID2022.git` Acceder: `cd PFINAL-FBID2022`

>__Note__ Si se pide el reinicio de algún servicio, marque ambas opciones (utilizando la barra espaciadora). Cuando estén marcados (aparecerá un [*]), presione Enter.

Primero, se debe proporcionar permisos al archivo a ejecutar:
```console
chmod 777 VM.sh
```
Ahora podemos ejecutarlo:
```console
./VM.sh
```
Este proceso puede demorarse varios minutos ya que está instalando múltiples tecnologías.

Cuando haya terminado la instalación, verá el siguiente mensaje por la consola:
```
All dependencies have been successfully installed. Please proceed with the execution of the flight-delay predictor scenario.
```

### Iniciar el escenario
Para inicializar el escenario de predicción de retrasos (o adelantos) de vuelos, se proporciona un fichero que automatiza todas las funciones mencionadas en [Práctica Big Data 2019](https://github.com/ging/practica_big_data_2019).

Primero, se debe proporcionar permisos al archivo a ejecutar:
```console
chmod 777 deploy.sh
```
Ahora podemos ejecutarlo:
```console
./deploy.sh
```

>__Warning__ Se solicitará una contraseña por pantalla. Es para el usuario de Airflow.

Una vez finalizada la ejecución del escenario, se mostrará un mensaje por consola con una URL http://localhost:5000/flights/delays/predict_kafka. A través de la misma, se accede a una web donde poder predecir los retrasos o adelantos en los vuelos entre un origen y destino, y para una fecha concreta.

Para acceder a la consola de Apache Airflow utilice la siguiente URL: http://localhost:8080.

(Opcional) Si quiere observar el estado de la base de datos tras estas predicciones, ejecute los siguientes comandos:
```console
chmod 777 database.sh
./database.sh
```

>__Note__ Para acceder a la URL indicada, si ha escogido el método de instalación en VirtualBox, acceda a través de Firefox. Si por el contrario ha escogido Google Cloud, hemos incluido la instalación de Google Chrome en VM.sh, por lo que podrá localizarlo en el menú de aplicaciones de su máquina.

#### Apache Airflow

##### ¿Qué es Apache Airflow?
Apache Airflow es una herramienta que se usa para la orquestación de servicios, permite la creación, la planificación y el seguimiento de flujos de trabajo. Las aplicaciones principales son: la automatización de la ingesta de datos, las tareas de administración y las acciones de mantenimiento periódicas. 

##### ¿Qué son los DAGs?
Airflow trabaja con DAGs (Directed Acyclic Graphs), son colecciones de tareas a ejecutar, cada una de estas tareas están relacionadas. Estas relaciones son de sentido único y acíclicas, es decir, no permiten volver a hacia atrás. Cada una de estas tareas quedan recogidas en un nodo. Un nodo, es una representación visual de cada uno de los trabajos que se están ejecutando. Por otro lado, los operadores son los encargados de determinar cómo se debe ejecutar cada una de las tareas.

##### Arquitectura de Airflow
Airflow esta compuesto por un servidor web que se encarga de gestionar las peticiones, es decir, que sirve de API y por un *Scheduler* que lleva a cabo el proceso de entender, ejecutar y monitorizar las tareas descritas en los DAGs.  Una característica importante del Scheduler es que presenta un ejecutor encargado de repartir las tareas y de lanzar los workers. Utiliza bases de datos como SQLite para almacenar los metadatos, los usuarios y las ejecuciones realizadas. Podemos ejecutar Airflow por medio de programas como Kubernetes, Sequential, Dask, etc.

<img src="assets/images/topology_airflow.png" width="400" height="250"/>

##### ¿Para que utilizamos Airflow en este escenario?
Se va a desplegar un DAG que tenga como tarea entrenar el modelo de datos para hacer predicciones con el mismo. Se le establece una tarea de PySpark para extraer los campos de la base de datos que vamos a utilizar para entrenar el modelo clasificador, y otra tarea para el propio evento de entrenar.

##### ¿Qué pasa si falla la tarea de entrenar el modelo? ¿Cuál es la periodicidad de la misma?
Si una task falla, el resto de tareas se realizarán sin ningún tipo de problema. Esto se debe principalmente a que cada una de las tareas son independientes las unas de las otras. En este caso, la tarea de obtención de los campos de la base de datos se ejecutaría sin dar error.

No tiene ningún tipo de periodicidad. Esto es debido a que en su campo schedule presenta el valor de None, lo cual significa que no está programada y que su uso es para DAG exclusivamente, es decir, que está activado solo externamente. Si presentase el valor de @once, la tarea solo se realizaría una vez; si presentase el valor de @hourly, el task se ejecutaría una vez cada hora. En cambio, si valiese @daily la tarea se realizaría una vez al día a medianoche. Lo mismo ocurriría para @weekly, @monthly y @yearly, en las cuales el  task se realizaría una vez a la semana, al mes y al año respectivamente, siempre a medianoche.

#### Destruir el escenario (Opcional)
En caso de desearse revertir el proceso de instalación del escenario de predicción de vuelos, se proporciona un fichero adicional que ejecuta dicha acción. Se recomienda lanzar el comando antes de cerrar las terminales que se abrieron automáticamente durante la ejecución del sistema.

Primero, se debe proporcionar permisos al archivo a ejecutar:
```console
chmod 777 destroy.sh
```
Ahora podemos ejecutarlo:
```console
./destroy.sh
```

## Ejecutar el escenario con Docker Compose (RECOMENDADO) <a name="docker"></a>

### Instalar las dependencias

Primero, se debe proporcionar permisos al archivo a ejecutar:
```console
chmod 777 VMDocker.sh
```
Ahora podemos ejecutarlo:
```console
./VMDocker.sh
```

>__Note__ Se recomienda ejecutar el escenario con las imágenes de DockerHub por cuestiones de latencia en la puesta en marcha del escenario. Puede acceder a los enlaces de DockerHub donde hemos subido nuestras imágenes:

> [Imagen en DockerHub de Spark](https://hub.docker.com/repository/docker/patriciaortuno28/fbid_spark)

> [Imagen en DockerHub de Flask](https://hub.docker.com/repository/docker/patriciaortuno28/fbid_flask)

### Iniciar el escenario con imágenes subidas a DockerHub (RECOMENDADO)

```console
cd docker_compose_dockerhub
sudo docker-compose up -d
```

### Iniciar el escenario con imágenes locales

```console
cd docker_compose_local
sudo docker-compose up -d
```

### Acceder a la web de predicciones

Para conocer la IP del contenedor Flask y acceder al servicio web ejecute:
```console
sudo docker inspect flask
```

Con esa IP acceda a http://ipaddress:5000/flights/delays/predict_kafka.

### Destruir el escenario (Opcional)

Ejecutar desde la carpeta del Docker Compose que se haya utilizado para levantar el escenario:
```console
sudo docker-compose down
sudo docker system prune -a
```

## Referencias

<a href="https://www.flaticon.es/resultados?word=web" target="_blank">Flaticon</a>

