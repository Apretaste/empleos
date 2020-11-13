CREATE TABLE _trabajos_categories (
    code varchar(50) primary key,
    description varchar(100)
);

insert into _trabajos_categories (code, description)
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

DROP TABLE IF EXISTS _trabajos_offers CASCADE;
CREATE TABLE _trabajos_offers(
    id char(36) primary key,
    title varchar(255),
    description varchar(4096),
    category varchar(50),
    email varchar(255),
    person_id bigint(11),
    inserted timestamp default CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS _trabajos_profile CASCADE;
CREATE TABLE _trabajos_profile (
    person_id bigint(11) primary key,
    name varchar(100),
    bio varchar(4096),
    inserted timestamp default CURRENT_TIMESTAMP
);

CREATE TABLE _trabajos_profile_education (
    id char(36) primary key,
    person_id bigint(11),
    grad_year bigint,
    school varchar(500),
    degree varchar(500),
    inserted timestamp default CURRENT_TIMESTAMP
);

CREATE TABLE _trabajos_profile_experience (
     id char(36) primary key,
     person_id bigint(11),
     workplace varchar(500),
     position varchar(255),
     inserted timestamp default CURRENT_TIMESTAMP
);

CREATE TABLE _trabajos_profile_professions (
      id char(36) primary key,
      person_id bigint(11),
      profession varchar(50),
      inserted timestamp default CURRENT_TIMESTAMP
);

CREATE TABLE _trabajos_profile_skills (
      id char(36) primary key,
      person_id bigint(11),
      skill varchar(100),
      inserted timestamp default CURRENT_TIMESTAMP
);

DROP TABLE _trabajos_conversation CASCADE;

CREATE TABLE _trabajos_conversation (
    id char(36) primary key,
    inserted timestamp default CURRENT_TIMESTAMP,
    read_date timestamp null,
    from_user bigint(11),
    to_user bigint(11),
    message varchar(4096)
);

alter table _trabajos_conversation add column offer_id char(36);