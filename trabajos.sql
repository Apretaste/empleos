/*
PROFESION
---
Disennador
Profesor
Programador
Escritor
Fisiologia
Cocinero
Belleza
Traductor
Fisiculturista
Entrenador
Medicina
Veterinareo
Multimedia


TRABAJADOR
no se mostrara el curriculo si algun campos con * esta vacio o si tiene menos de 60% de fuerza
---
foto
nombre*
profesion1*
profesion2
profesion3
descripcion(300)
provincia
educacion[] (Anno graduacion, Escuela)
experiencia[] (anno inicio, anno final, Titulo, Compannia)
habilidades[]
idiomas[] (Idioma, Nivel{Fluido|Conversacional|Escrito})


TRABAJO
---
titulo(80)*
detalles(500)*
nombre
email
telefono
profesion a buscar*
fecha de cierre
salario
contrato{proyecto|salario}*
nivel{experto|avanzado|principiante}


COMO CALCULAR FUERZA DEL CURRICULO
---
descripcion - 9%
profesiones - 12%
	4% por cada profesion
educacion - 21%
	7% por cada escuela
experiencia - 30%
	6% por cada experiencia
habilidades - 18%
	2% por cada habilidad
idiomas - 10%
	fluido:5%, Conversacional:3%, Escrito:2%

*/

CREATE TABLE _trabajos_cv_professions (
  id int(11) auto_increment not null primary key,
  profession varchar(255)
);

INSERT INTO _trabajos_cv_professions (profession) VALUES
  ('Disennador'),('Profesor'), ('Programador'), ('Escritor'), ('Fisiologia'), ('Cocinero'),
  ('Belleza'), ('Traductor'), ('Fisiculturista'), ('Entrenador'), ('Medicina'), ('Veterinareo'), ('Multimedia');

CREATE TABLE _trabajos_cv (
  email varchar(255) not null primary key,
  full_name varchar(255),
  profession1 int(11),
  profession2 int(11),
  profession3 int(11),
  description varchar(300),
  province enum('PINAR_DEL_RIO','LA_HABANA','ARTEMISA','MAYABEQUE','MATANZAS','VILLA_CLARA','CIENFUEGOS','SANCTI_SPIRITUS','CIEGO_DE_AVILA','CAMAGUEY','LAS_TUNAS','HOLGUIN','GRANMA','SANTIAGO_DE_CUBA','GUANTANAMO','ISLA_DE_LA_JUVENTUD')
);

CREATE TABLE _trabajos_cv_education (
  id int(11) auto_increment not null primary key,
  email varchar(11) not null,
  graduation_year int(11),
  school varchar(300)
);

DROP TABLE IF EXISTS _trabajos_cv_experience;
CREATE TABLE _trabajos_cv_experience (
  id int(11) auto_increment not null primary key,
  email varchar(255) not null,
  start_year int(11),
  end_year int(11),
  title varchar(300),
  company varchar(300)
);

DROP TABLE IF EXISTS _trabajos_cv_skills;
CREATE TABLE _trabajos_cv_skills (
  id int(11) auto_increment not null primary key,
  email varchar(255) not null,
  skill varchar(255) not null
);

DROP TABLE IF EXISTS _trabajos_cv_langs;
CREATE TABLE _trabajos_cv_langs (
  id int(11) auto_increment not null primary key,
  email varchar(255) not null,
  lang enum ('ESPANNOL', 'INGLES', 'FRANCES', 'ITALIANO', 'RUSO', 'CHINO', 'JAPONES'),
  lang_level enum('NATIVO','FLUIDO','CONVERSACIONAL','ESCRITO')
);

DROP TABLE IF EXISTS _trabajos_job;
CREATE TABLE _trabajos_job (
  id int(11) auto_increment not null primary key,
  email varchar(255) not null,
  title varchar(80) not null,
  deatils varchar(500),
  name varchar(50),
  phone varchar(20),
  looking_for_profession int(11),
  end_date date,
  salary float,
  contract enum('PROYECTO','SALARIO'),
  job_level enum('EXPERTO','AVANZADO','PRINCIPIANTE')
);