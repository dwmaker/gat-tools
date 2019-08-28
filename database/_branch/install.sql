create sequence core.sq_mapa START WITH 1000;
create sequence core.sq_mapa_servidor START WITH 1000;
create sequence core.sq_mapa_usuario START WITH 1000;

create table core.tb_mapa
(
	id_mapa integer,
	nm_mapa varchar2(50) not null,
	ds_mapa varchar2(500) null,
	nr_versao varchar2(10) null,
	cd_ambiente varchar2(10) null,
	tp_mapa char(1) not null,
	id_mapa_template integer,
	"NM_USUARIO_CRIACAO" VARCHAR2(30 BYTE) not null, 
	"DT_CRIACAO" DATE not null, 
	"NM_USUARIO_ALTERACAO" VARCHAR2(30 BYTE), 
	"DT_ALTERACAO" DATE,
    constraint tb_mapa_pk primary key (id_mapa)
);

create table core.tb_mapa_servidor
(
	id_mapa_servidor integer,
	id_mapa integer not null,
	cd_tecnologia varchar2(20) not null,
	cd_servidor varchar2(20) not null,
	ds_conexao varchar2(255) not null, 
	"NM_USUARIO_CRIACAO" VARCHAR2(30 BYTE) not null, 
	"DT_CRIACAO" DATE not null, 
	"NM_USUARIO_ALTERACAO" VARCHAR2(30 BYTE), 
	"DT_ALTERACAO" DATE,
    constraint tb_mapa_servidor_pk primary key (id_mapa_servidor),
	CONSTRAINT tb_mapa_servidor_UK1 UNIQUE (id_mapa, cd_tecnologia, cd_servidor)
);
create table core.tb_mapa_usuario
(
	id_mapa_usuario integer,
	id_mapa_servidor integer not null,
	nm_usuario varchar2(40) not null,
	ds_senha varchar2(40) not null, 
	"NM_USUARIO_CRIACAO" VARCHAR2(30 BYTE) not null, 
	"DT_CRIACAO" DATE not null, 
	"NM_USUARIO_ALTERACAO" VARCHAR2(30 BYTE), 
	"DT_ALTERACAO" DATE,
    constraint tb_mapa_usuario_pk primary key (id_mapa_usuario),
	CONSTRAINT TB_MAPA_USUARIO_UK1 UNIQUE (ID_MAPA_SERVIDOR, NM_USUARIO)
);

ALTER TABLE core.TB_MAPA_SERVIDOR ADD CONSTRAINT TB_MAPA_SERVIDOR_FK1 FOREIGN KEY (ID_MAPA) REFERENCES core.TB_MAPA(ID_MAPA) ENABLE;

ALTER TABLE core.TB_MAPA_USUARIO ADD CONSTRAINT TB_MAPA_USUARIO_FK1 FOREIGN KEY (ID_MAPA_SERVIDOR) REFERENCES core.TB_MAPA_SERVIDOR (ID_MAPA_SERVIDOR) ENABLE;

