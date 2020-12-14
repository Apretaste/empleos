DROP TABLE IF EXISTS _empleos_categories CASCADE;
CREATE TABLE _empleos_categories (
    code varchar(50) primary key,
    description varchar(100)
);

insert into _empleos_categories (code, description)
values
    ('professor', 'Profesor'),
    ('design', 'Diseño'),
    ('marketing', 'Marketing'),
    ('coding', 'Programación'),
    ('copywrite', 'Escritura'),
    ('translation', 'Traducción'),
    ('research', 'Investigación'),
    ('testing', 'Muestreo'),
    ('other', 'Otro');

DROP TABLE IF EXISTS _empleos_offers CASCADE;
CREATE TABLE _empleos_offers(
    id char(36) primary key,
    title varchar(255),
    description varchar(4096),
    category varchar(50),
    email varchar(255),
    person_id bigint(11),
    inserted timestamp default CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS _empleos_profile CASCADE;
CREATE TABLE _empleos_profile (
    person_id bigint(11) primary key,
    name varchar(100),
    bio varchar(4096),
    email varchar(255),
    inserted timestamp default CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS _empleos_profile_education CASCADE;
CREATE TABLE _empleos_profile_education (
    id char(36) primary key,
    person_id bigint(11),
    grad_year bigint,
    school varchar(500),
    degree varchar(500),
    inserted timestamp default CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS _empleos_profile_experience CASCADE;
CREATE TABLE _empleos_profile_experience (
     id char(36) primary key,
     person_id bigint(11),
     workplace varchar(500),
     position varchar(255),
     inserted timestamp default CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS _empleos_profile_professions CASCADE;
CREATE TABLE _empleos_profile_professions (
      id char(36) primary key,
      person_id bigint(11),
      profession varchar(50),
      inserted timestamp default CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS _empleos_profile_skills CASCADE;
CREATE TABLE _empleos_profile_skills (
      id char(36) primary key,
      person_id bigint(11),
      skill varchar(100),
      inserted timestamp default CURRENT_TIMESTAMP
);

alter table _empleos_offers add column extra text;
alter table _empleos_offers add column kind enum('OFERTA', 'SOLICITUD') not null default 'OFERTA';