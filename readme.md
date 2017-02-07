# Práctica 5: HackerBooks
## Juan A. Caballero
-----------------------------------------------

DESCRIPCIÓN DE LA PRÁCTICA
-----------------------------------------------


La práctica descrita implementa una App, HacekBooks, que muestra una serie de libros almacenados en un servidor bajo formato Json. Los libros se muestran ordenados bajo un Tags que clasifican los libros. 

Para la programación del modelo de la arquitectura MVC, se ha utilizado un Multidiccionario que almacena libros clasificados en Tags con toda su funcionalidad. 

Al seleccinar cualqueir libro, la App muestra una vista en detalle del libro seleccionado, con la portada del mismo y dos botones en la parte inferior: uno para abrir el pdf del libro y el otro para seleccionarlo o deseleccionarlo como favorito. 

La App presenta dos fallos extraños que se han comentado con los profesores. Uno de ellos consiste en que no muestra el pdf, se queda cargando mostrando un spinner, pero no es capaz de cargarlo desde la WebView y muestra un mensaje de error indicando algo así como que la app se está abriendo desde dos ubicaciones distintas y que no deja abrirla por temas de seguridad.

El otro fallo extraño que también se ha comentado con los profesores es que al descargar el pdf con el JSON y guardarlo en la carpete Documents, al volver a arrancar la app este fichero se borra y se crea uno nuevo, sin saber porqué se borra. 

Para poder lanzar la app evitando este último problema, por un lado, he tenido que cargar el Json en cada ejecución, pues si lo guardo se borra para el siguiente arranque. Dejo comentado el código para que cargue el JSON desde el fichero local Documents una vez descargado en el primer aranque de la app. 

Por otro lado, y por la misma razón, tampoco he podido guardar las imágenes en local para cargarlas en los siguientes arranques de la app. 

Tampoco me ha dado tiempo a implementar el SplitViewController y universalizar la app por falta de tiempo, así como a comprobar el porqué del fallo en el funcionameinto del tag Favoritos, programado con Notificaciones a última hora y que no me da tiempo a comprobar porqué falla. Tampoco pude implementar el cambio de icono cuando se pulsa para indicar si está o no en favoritos.

En fin, para alguien que la primera vez que programa es en este máster y sin habar visto aún nada del curso online de IOS Avanzado no está mal, aunque seguiré la práctica hasta terminarla por completo y aprender así los conceptos que me faltan.

