SET foreign_key_checks = 0;
drop table if exists kapal_bobot;
drop table if exists subkriteria;
drop table if exists kriteria;
drop table if exists kapal;
SET foreign_key_checks = 1;

create table kapal (
  id integer auto_increment primary key,
  nama varchar(255) not null,
  callsign varchar(255) not null,
  gt integer not null,
  tahun integer not null,
  pemilik varchar(255) not null
);

create table kriteria (
  id integer auto_increment primary key,
  nama varchar(255) not null,
  bobot float not null
);

create table subkriteria (
  id integer auto_increment primary key,
  nama varchar(255),
  bobot integer not null,
  core boolean not null,
  id_kriteria integer not null
);

create table kapal_bobot (
  id_kapal integer not null,
  id_sub integer not null,
  bobot integer not null
);

alter table kapal_bobot
  add constraint kapal_nilai_kapal foreign key (id_kapal)
  references kapal (id)
  on delete cascade;

alter table kapal_bobot
  add constraint kapal_nilai_subkriteria foreign key (id_sub)
  references subkriteria (id)
  on delete cascade;