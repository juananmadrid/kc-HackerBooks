# Práctica 5: HackerBooks
## Juan A. Caballero
-----------------------------------------------

DATOS DEL SERVIDOR
-----------------------------------------------

URL DE PRÁCTICA:
 
	IP: 		54.203.3.34
	DNS: 		ec2-54-203-3-34.us-west-2.compute.amazonaws.com
	DOMINIOS:	kronox.mobi, www.kronox.mobi


SERVICIOS DEL SERVIDOR
-----------------------------------------------

	Acceso por IP y Dominios: 		WEB PERSONALIZADA
	Acceso por DNS: 				API "NODEPOP" 
	


DESCRIPCIÓN DE LA API "NODEPOP"
-----------------------------------------------

El acceso a la Api está restringido a usuarios registrados. La Api incluye un método para registrarse. Una vez registrados, hacemos login con ese usuario y password para obtener el Token, el cual incluiremos en todas nuestras peticiones para la consulta de datos de artículos. 

Los ficheros estáticos son tratados por Nginx, como puede verse en las cabeceras personalizadas devueltas por Nginx en las peticiones de estáticos, que incluyen el nombre de la Api y del desarrollador. A continuación se muestran: 

	X-Custom-Header:	Nodepop
	X-Owner:			juananmadrid
	
Puede verse, por ejemplo, en los ficheros estáticos de:

  	http://ec2-54-203-3-34.us-west-2.compute.amazonaws.com/


A continuación, se describen los métodos que proporciona la Api. 


MÉTODOS DE REGISTRO Y AUTENTICACIÓN DE USUARIOS
-----------------------------------------------

El API propuesto restringe el acceso a consultas de artículos a usuarios registrados. Para ello, se ha propuesto como método de autenticación JSON WEB TOKEN (JWT) por su amplia implantación en App's móviles. 

Los métodos propuestos para el registro de usuarios y obtención de token para poder listar artículos son los siguientes.

**REGISTRO DE USUARIOS** 

      Ruta:  http://54.203.3.34:3000/apiv1/users
      Tipo:  POST
      Formato: x-www.form-urlencoded
      Incluimos en el BODY los parámetros:
         - name 
         - password

    
**AUTENTICACIÓN** (para obtener token con que hacer consultas de articulos)

      Ruta:  http://54.203.3.34:3000/apiv1/users/login
      Tipo:  POST
      Incluimos en el BODY los parámetros:
         - user
         - pass

El **token** es devuelto en formato **json** en el body para poder usarlo en las peticiones de consulta. En una aplicación real no se devolverá aquí por seguridad para que no pueda ser usado para averiguar el método de generación de ese hash.


MÉTODOS DE LISTADO Y FILTROS
-----------------------------------------------

Se incluyen los métodos de listado y filtrado de artículos por sus campos. Los resultados se muestran en formato JSON. Los métodos propuestos son los siguientes:

Las peticiones de listado deberán incluir token devuelto tras registrarse, y se incluiré en body, headers o por query con el formato siguiente:

AUTENTICACIÓN para listado de artículos. Formato:

      En cabecera: 	x-access-token = token nº
      En query:    	token = token nº
      En body:     	token = token nº
   
PETICIONES GET DE LISTADO 

      Ruta:  		http://54.203.3.34:3000/apiv1/articulos
      Tipo:  		GET
      
FILTROS en QUERY:

     - name 	= caracteres_iniciales_del_nombre
     - prize 	= precio_exacto
     - minp 	= precio_minimo
     - maxp 	= precio_maximo
     - type 	= busqueda_o_venta
     - tag		= work_o_lifestyle_o_motor_o_movil


FUNCIONALIDAD DE IDIOMA PARA RESPONDER ERRORES
-----------------------------------------------

El API proporciona respuestas ante errores en idiomas inglés y español según el idioma de la petición. Para ello, se especificará con el parámetro languague, 
      Incluimos en el HEADERS:
         - language = es-ES (para español)
         - El resto en inglés, se especifique o no (por defecto)
 
 
CLUSTER
-----------------------------------------------

El api inclye también la funcionalidad de cluster mediante la cual arranca tantos hilos de programa, llamados clones, como CPUs tenga el servidor donde se instale el API aquí propuesto. Así aprovechamos al máximo los recursos del servidor para los momentos de máxima demanda de peticiones.


