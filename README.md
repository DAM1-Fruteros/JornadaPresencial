# Jornada Presencial Mayo San Valero
# Proyecto Aplicación web con Java/JSP con Servlets, AJAX y MariaDB

Este proyecto es una aplicación web desarrollada en Java utilizando JSP para la interfaz de usuario, Servlets para la lógica de negocio y AJAX para la comunicación asíncrona con los Servlets. Los datos se almacenan en una base de datos MariaDB. El proyecto sigue el patrón DAO para la interacción con la base de datos y se despliega en Apache Tomcat.

## Estructura del Proyecto

* **JSP (`.jsp`):** Se utilizan para la capa de visual.
* **Servlets (`.java`):** Manejan la lógica de la aplicación.
* **Clases Java (`.java`):** Contienen el Modelo y la implementación del patrón DAO para interactuar con la base de datos.
* **JavaScript (`.js`):** Utilizado para las llamadas AJAX desde las páginas JSP.

## Base de Datos MariaDB

La base de datos MariaDB contiene las siguientes tres tablas:

* **`users`:** Almacena la información de los usuarios.

* **`products`:** Almacena la información de los productos.

* **`cart`:** Representa el carrito de compras y relaciona usuarios con productos.

## Tecnologías Utilizadas

* **Java:** Lenguaje de programación principal.
* **JSP (JavaServer Pages):** Para la creación de la interfaz de usuario.
* **Servlets:** Para manejar las peticiones HTTP y la lógica de negocio.
* **AJAX (Asynchronous JavaScript and XML/JSON):** Para realizar llamadas asíncronas a los Servlets.
* **MariaDB:** Sistema de gestión de bases de datos relacional.
* **JDBC (Java Database Connectivity):** API de Java para interactuar con la base de datos.
* **Apache Tomcat:** Servidor de aplicaciones Java para desplegar la aplicación web.
* **Patrón DAO (Data Access Object):** Patrón de diseño para separar la lógica de acceso a datos de la lógica de negocio.

## Despliegue

Pasos para desplegar la aplicación:

1.  Asegúrate de tener instalado Apache Tomcat.
2.  Copia el archivo WAR (Web Application Archive) generado de tu proyecto a la carpeta `webapps` de tu instalación de Tomcat.
3.  Inicia el servidor Apache Tomcat.
4.  La aplicación estará accesible a través de la URL configurada en Tomcat, en este caso `http://localhost:8082/practicas_app`).

## Configuración

* **Conexión a la Base de Datos:** La configuración de la conexión a la base de datos MariaDB (usuario: `user` contraseña: `password`) se realizará en las clases DAO o en un archivo de configuración accesible por estas clases. Asegúrate de configurar correctamente estos parámetros para que la aplicación pueda conectarse a la base de datos.

## Roles de Usuario

La aplicación implementa un sistema de roles para diferenciar entre usuarios normales y administradores. La tabla `users` contiene un campo para determinar el rol de cada usuario. La lógica en los Servlets y las páginas JSP debe tener en cuenta estos roles para habilitar o deshabilitar ciertas funcionalidades como editar usuarios, eliminar, añadir a carrito....

## Notas Adicionales

* Este proyecto utiliza el patrón DAO para organizar la capa de acceso a datos, facilitando el mantenimiento y la separación de responsabilidades.
* Las llamadas AJAX permiten una experiencia de usuario más fluida al actualizar partes de la página sin necesidad de recargas completas.

PRESENTACIÓN
https://view.genially.com/6827733355a4ef202f20c114/dossier-app-web-electronicdevices
