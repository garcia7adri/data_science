CREATE SCHEMA tienda_g21 ;

USE tienda_g21;

/* 
****************************************************************************************
****************************************************************************************
COMANDOS DDL. Data Definition Language o Lenguaje de Definición de Datos.
****************************************************************************************
****************************************************************************************
*/

CREATE TABLE productos 
(
id_producto INT NOT NULL AUTO_INCREMENT ,
PRIMARY KEY(id_producto),
nombre VARCHAR(255),
precio INT
);

CREATE TABLE clientes 
(
id_cliente INT NOT NULL AUTO_INCREMENT ,
PRIMARY KEY(id_cliente),
nombre VARCHAR(255),
apellido VARCHAR(100),
edad INT,
telefono INT
);

CREATE TABLE pedidos 
(
id_pedido INT NOT NULL AUTO_INCREMENT ,
PRIMARY KEY(id_pedido),
fecha DATE,
cantidad INT,
id_cliente INT,
id_producto INT,
FOREIGN KEY(id_cliente) REFERENCES clientes(id_cliente),
FOREIGN KEY(id_producto) REFERENCES productos(id_producto)
);

/*ALTER TABLE

Supongamos que deseamos modificar la tabla pedidos, incluyendo en esta la tienda en la
que el cliente compro el producto. Para esto vamos a crear una tabla sedes y usaremos
ALTER para agregar una columna dentro de la tabla pedidos.
*/

CREATE TABLE sedes
(
id_sede INT NOT NULL AUTO_INCREMENT ,
PRIMARY KEY(id_sede),
nombre VARCHAR(255)
);

ALTER TABLE pedidos
	ADD COLUMN id_sede int,
	ADD CONSTRAINT FOREIGN KEY (id_sede)
	REFERENCES sedes(id_sede);

/*DROP TABLE

En el caso que nosotros querramos eliminar una tabla, utilizaremos el comando DROP, 
debemos tener cuidado con esta sentencia y al momento de ejecutarla, pues eliminara 
todos los datos que haya almacenados en la tabla.
*/

CREATE TABLE tabla_a_ser_borrada 
(
id_clientes INT NOT NULL AUTO_INCREMENT ,
PRIMARY KEY(id_clientes),
nombre VARCHAR(255),
apellido VARCHAR(100),
edad INT,
telefono INT
);

DROP TABLE tabla_a_ser_borrada;

/* *************************************************************************************
**************************************************************************************** 
COMANDOS DML - Data Manipulation Language o Lenguaje de Manipulación de Datos
****************************************************************************************
*/

/*SELECT
Nos permite seleccionar una tabla y visualizar su contenido.
*/

SELECT * FROM clientes; #Si no seleccionamos nos mostrara toda la tabla

SELECT nombre, apellido FROM clientes; #Si solo deseamos columnas en especifico


/*INSERT

Este comando nos permite ingresar datos a nuestras tablas.
*/

INSERT INTO clientes(nombre, apellido, edad, telefono)
VALUES("Yon","Arce",24,9876546);

INSERT INTO productos(nombre, precio)
VALUES("USB 64GB", 40);

INSERT INTO sedes(nombre)
VALUES("AGENCIA 3 DE MAYO");

INSERT INTO sedes(nombre)
VALUES("AGENCIA ALTO MISTI"),
("AGENCIA ANTUNEZ DE MAYOLO"),
("AGENCIA CHORRILLOS"),
("AGENCIA EL PORVENIR"),
("AGENCIA JAEN"),
("AGENCIA MACUSANI");

INSERT INTO clientes(nombre, apellido, edad, telefono)
VALUES("JORGE","RAMIREZ",40,9666665),
("JORGE","RAMIREZ",40,9666665),
("MIGUEL","PENA",24,4568795),
("JHONY","CERRON RENGIFO",54,94096),
("FERNANDO","CELIS MONTELUIZ",45,124352),
("JACK HARRY","VELA URBIETTA",45,124930),
("CARMEN DEL ROCIO","CHACON CASTRO",54,485686),
("MARIELLA PASTORA","IRIARTE PAREDES",50,492742),
("ROXANA CAROLINA","SARMIENTO QUISPE",51,495389),
("SILVIA HERMINIA","LUQUE YUPA",49,497093),
("SONIA MÓNICA","ERAS MERCADO",49,498997),
("MARITZA MAGDALENA","COAQUIRA MAMANI",47,504030),
("JULIO CESAR","LOPEZ HUALPACHOQUE",51,504562),
("CHARO MARITZA","COA LARICO DE PECHAROVICH",46,507645),
("CRISTIAN ALBERTO","TACO TAPIA",44,516312),
("GLADYS ROSA","QUEQUE COTRADO",44,516974),
("MARIA SILVIA","CHIPANA HUANCA",44,517254),
("GABRIELA VILMA","GARCIA VARGAS",44,522315),
("SILVIA MARIZELA WENDY","NINA CORONADO",47,793898),
("GEINER","RIVERA MEGO",47,1143906),
("NICOLAS","APAZA CANAZA",51,1284299),
("JOSE HECTOR","LLERENA GAMARRA",50,1297625),
("VILMA","HOLGUIN MAMANI",48,1302407),
("ANGEL JESUS","PEREZ PINEDA",54,1306043),
("JUAN HERMITAnO","VELASQUEZ APAZA",50,1315886),
("ELEUTERIO","APAZA GONZALES",51,1317456),
("ABEL VICENTE","LUNA RAMOS",50,1317825),
("JAVIER MARTIN","INQUILLA BRAVO",51,1318139),
("ROGER","SALAS CHURATA",50,1318362),
("WILY VICENTE","MAMANI BUSTINCIO",50,1318952),
("ANA ROSA","JARECA MAMANI",49,1319773),
("MARISOL","RAMOS RAMOS",49,1320703),
("MARY ROXANA","AQUIZE GARCIA",48,1323158),
("LILIAN LOURDES","FLORES TALAVERA",46,1327112),
("MARLENI","VILCA ALVAREZ",46,1327452),
("ROGER","ZANABRIA RAMOS",46,1335507),
("ENRIQUE MANUEL","ZAMBRANO ORTIZ",47,1342959),
("MILAGROS ANGELICA","HUASCUPI CHOQUE",45,1343232),
("ERICK VIDAL","VIZCARRA URIBE",45,1343579),
("RAYDA","PINO SOTOMAYOR",45,1343715),
("ELIZABETH","CHALCO VELAZCO",48,1772995),
("GLORIA CARMEN","MAQUERA CUTIPA",47,1872832),
("ARNALDO","QUISPE QUISPE",49,2167125),
("DAVID","ARIAS CALLA",45,2172301),
("PAUL ELDWIN","DEL CARPIO LUNA",47,2298421),
("TRAVIS MARTIN","MEDINA FRISANCHO",47,2298643),
("RUBEN DARIO","BEJAR GONZALES",47,2299487),
("ROSY XIOMARA","TAPIA DE ALEMAN",50,2415802),
("PATRICIA MILAGROS","BARRIENTOS PAREDES",45,2416019),
("CARMEN","AMANQUI RUELAS",48,2416607),
("MIRIAM LUZ","ATENCIO SALAS",56,2420502),
("BEATRIZ BRIGIDA","GARATE CUENTAS",51,2432040),
("RENE","CALSIN CALSIN",51,2434662),
("MIRIAN","TUPA FERNANDEZ",51,2435185),
("CIRILO","OCHOCHOQUE MASCO",49,2438592),
("WALDIR","BARRIONUEVO ABARCA",46,2441029),
("ROGER LUIS","FLORES NINA",47,2441511),
("PERCY","SURCO SILLO",47,2446903),
("YONY BISVAL","LERMA HUAYHUA",46,2447235),
("JULIAN KUMAR","ARCE YANQUI",45,2449484),
("JOHNNY PERCY","AMAYA URBINA",55,2778347),
("JUAN CARLOS","GALVEZ NOLE",48,2863931),
("JAVIER ARTURO","SALCEDO OREJUELA",47,2870445),
("JAVIER ANTONIO","ENCALADA DOMINGUEZ",45,2893750),
("NOE JEAN","YONSEN SALGADO",49,4431309),
("ARMANDO JOSE","GARCIA MONTENEGRO",46,4436343),
("MARIO ALBERTO","RAMOS MAMANI",47,4436789),
("STEFANI ZORAIDA","APAZA VENEGAS",45,4437573),
("WILBER MARIN","CENTENO ORDOnO",45,4438279),
("WENDY ANILU","ZEBALLOS CALVO",44,4438502),
("MANUEL ENRIQUE","LAMAS VELASQUEZ",60,4621447),
("JORGE LUIS","RODRIGUEZ BARRIOS",70,4635385),
("CARMEN JULIA","MARIN DEL CARPIO DE URIBE",60,4639014),
("PAUL","PERALTA ARAGON",46,4642410),
("JOHN BELFORD","SERRA MUnOZ",48,4649637),
("OSCAR ALBERTO","BENEGAS -",48,4652638),
("RUBEN MANUEL","CACERES CHAMBILLA",45,4748456),
("MIRIAM YOLANDA","VENTURO BAYLON",44,4749886),
("FREDDY OSCAR","RAMIREZ LOPEZ",58,6017936),
("RAUL AUGUSTO","MANTILLA GANOZA",67,6141395),
("FELIX JUVENAL","VILCA RIQUELME",60,6318693),
("CESAR ARTURO","BORNAZ URQUIZO",50,6435979),
("JULIO ERNESTO","TOMA KIYAMU",47,6790951),
("INES MALVI","YANQUI BOMBILLA",46,6802041),
("MIGUEL JUAN","COCHAS LLOCLLA",62,6969707),
("FERNANDO BENITO","CHAHUARA CONDORI",58,7066596),
("ENRIQUE OMAR","GARCIA DAVILA",59,7300665),
("MARIO ANGEL","CHAVEZ CORDOVA",58,7363933),
("OSCAR MANUEL","CENTENARO CHACHI",49,7629517),
("ERIKA DEL ROCIO","CARLOS BAUTISTA",45,7642855),
("ERIC","TUPAYACHI TACAR",45,7644594),
("ALBERTO NOE","RODRIGUEZ PEZO",58,7699144),
("MARCO ANTONIO","EFFIO IPENZA",58,7731378),
("JAIME","YNGA SUCARI",48,7760233),
("LUCIA MARIE","ESCALANTE CASTAnEDA",54,7970088),
("JORGE LUIS","PISCOYA AnI",53,8129748),
("JAVIER ANTONIO","CACEDA CASTRO",51,8148580),
("DAVID","RAMIREZ TINTA",50,8149411),
("OSCAR RAFAEL","RODRIGUEZ ANAYA",54,8171632),
("JUAN PABLO","NAPAN ZUMAITA",59,8382372),
("ULISES ROBERTO","ENRIQUEZ ALVAREZ",56,8664035),
("ALFONSO INOCENTE","ELIAS ALBINO",54,8680895),
("VICTOR RICARDO","CANTA TERREROS",58,8705459),
("WALTER MANUEL","ALCANTARA VILLANUEVA",58,8780306),
("ROSSANA LIDIA","CHASSELOUP LOPEZ",60,8808058),
("JOSE ARTURO","POVIS YZAGUIRRE",60,9182400),
("MONICA ITALA","HINOJOSA PALOMINO",58,9260862),
("JOHN VLADIMIR","MERINO BUSTAMANTE",53,9392069),
("MARCO ANTONIO","LUCAR BERNINZON",51,9392256);


INSERT INTO productos(nombre,precio)
VALUES ("DISCO DURO INTERNO  MINI SATA 500GB",20),
("DISCO DURO INTERNO  SATA 250GB",21),
("DISCO DURO INTERNO  SATA 500GB",35),
("DISCO DURO INTERNO SATA 250GB LAPTOP",40),
("FUENTE DE PODER - CPU",32),
("LECTORA/QUEMADORA EXTERNA CD/DVD - CPU",33),
("LECTORA/QUEMADORA INTERNA CD/DVD - CPU",50),
("MAINBOARD - CPU",89),
("MEMORIA RAM 2GB LENOVO 0809",45),
("MEMORIA RAM 2GB LENOVO 5049",45),
("MEMORIA RAM 2GB LENOVO T420",45),
("MEMORIA RAM 2GB LENOVO T500",45),
("MEMORIA RAM 4GB LENOVO 5485",45),
("MOUSE INALAMBRICO",28),
("MOUSE USB",39),
("PROCESADOR - CPU",450),
("TARJETA DE VIDEO - CPU",500),
("TECLADO USB",40),
("WEBCAM",40),
("MEMORIA RAM 4GB TINY",18),
("MEMORIA RAM 8GB LAPTOP",90),
("PARLANTE TELECONFERENCIA USB",80),
("MEMORIA RAM 8GB LENOVO 5049",120);

# Ahora si podemos ver cómo se ven las tablas
SELECT nombre,apellido FROM clientes WHERE id_cliente BETWEEN 3 AND 20;

SELECT nombre,apellido FROM clientes WHERE nombre = "Yon" AND apellido = "Arce";

SELECT nombre,apellido FROM clientes WHERE nombre = "Yon" OR apellido = "RAMIREZ";

SELECT nombre,apellido FROM clientes WHERE edad > 50;

SELECT nombre FROM productos WHERE precio > 50;

SELECT nombre,precio FROM productos WHERE precio <> 45;

SELECT nombre,precio FROM productos WHERE precio = 45;

SELECT nombre,apellido FROM clientes WHERE nombre LIKE "JAVIER%";


/*UPDATE

Permite modificar los valores de una tabla
*/

UPDATE clientes SET telefono = 966666612 WHERE id_cliente = 1; 
#Con el comando WHERE especificamos en que fila se reemplazara
#Debemos especificar siempre con WHERE, pues el no hacerlo implicaria modificar todos los valores de la tabla

/*DELETE

Se permite eliminar los valores de una tabla, recordemos usar el WHERE pues podemos volarnos
toda la tabla.
*/

DELETE FROM clientes WHERE id_cliente = 2;


/*
**************************************************************************************** 
CLAUSULAS
**************************************************************************************** 
*/

# 1. Order by
SELECT * FROM productos ORDER BY id_producto ASC;

# 2. Where (Filtrar) & Condicionales
SELECT * FROM clientes WHERE id_cliente < 15 ORDER BY nombre ASC;

SELECT * FROM clientes WHERE nombre = "Jorge";

DELETE FROM clientes WHERE id_cliente = 111 OR id_cliente = 112;

/*
**************************************************************************************** 
FUNCION DE AGREGACION
**************************************************************************************** 
*/

SELECT COUNT(*) FROM clientes;

# SUM: Sumamos los precios de todos los productos en venta

SELECT SUM(precio) FROM productos WHERE nombre LIKE "MEMORIA%"; 

# AVG: Proviene de average(promedio), tomaremos el promedio de la edad de todos los clientes
SELECT nombre, AVG(edad) FROM clientes GROUP BY nombre;

INSERT INTO clientes(nombre,apellido,edad,telefono)
VALUES("Jorge","Lopez",20,1234567);


SELECT * FROM clientes WHERE nombre = "Jorge";

DELETE FROM clientes WHERE id_cliente = 111 OR id_cliente = 112;

SELECT nombre, AVG(edad) FROM clientes WHERE nombre = "Jorge";


# MIN: Encontremos a la persona mas joven
SELECT nombre,apellido, MIN(edad) FROM clientes;
# MAX: Encontremos a la persona mas longeva
SELECT nombre, MIN(edad) FROM clientes GROUP BY nombre;

UPDATE clientes SET edad = 20 WHERE id_cliente = 4; #Cambiamos la edad del 2° Yon para ver como actua AVG


