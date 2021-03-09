--   tipo:      Oracle Database 11g


CREATE TABLE tbl_crc_cliente (
    id_cliente                 NUMBER(8) NOT NULL,
    id_tipo_cliente            NUMBER(2) NOT NULL,
    id_tipo_documento          NUMBER(2) NOT NULL,
    identificacion             VARCHAR2(20) NOT NULL,
    nombres                    VARCHAR2(60) NOT NULL,
    apellidos                  VARCHAR2(60) NOT NULL,
    email                      VARCHAR2(60) NOT NULL,
    fecha_creacion             DATE NOT NULL,
    id_estado_cliente          NUMBER(3) NOT NULL,
    telefono_contacto          VARCHAR2(20) NOT NULL,
    estado                     NUMBER(3) NOT NULL,
    limite_maximo_presupuesto  VARCHAR2(20),
    direccion                  VARCHAR2(150) NOT NULL
);

COMMENT ON COLUMN tbl_crc_cliente.id_cliente IS
    'Campo para id de tabla de cliente';

CREATE INDEX tbl_crc_clienteid ON
    tbl_crc_cliente (
        id_cliente
    ASC );

CREATE INDEX tbl_crc_clienteif ON
    tbl_crc_cliente (
        identificacion
    ASC );

CREATE INDEX tbl_crc_clienteidif ON
    tbl_crc_cliente (
        id_cliente
    ASC,
        identificacion
    ASC );

ALTER TABLE tbl_crc_cliente ADD CONSTRAINT ckc_limite_cliente CHECK ( limite_maximo_presupuesto > 1 );

ALTER TABLE tbl_crc_cliente ADD CONSTRAINT clientes_pk PRIMARY KEY ( id_cliente );

CREATE TABLE tbl_crc_det_factura (
    id_det_factura        NUMBER(9) NOT NULL,
    id_factura            NUMBER(8) NOT NULL,
    id_det_mantenimiento  NUMBER(8) NOT NULL,
    id_mecanico           NUMBER(5) NOT NULL,
    prd_lvl_number        NUMBER(8) NOT NULL,
    cantidad              NUMBER(4) NOT NULL,
    prd_cost              NUMBER(11, 3),
    valor_descuento       NUMBER(11, 3) NOT NULL,
    servicio              NUMBER(1) NOT NULL,
    repuesto              NUMBER(1) NOT NULL
);

ALTER TABLE tbl_crc_det_factura
    ADD CONSTRAINT ckc_repuesto_fac CHECK ( repuesto IN ( 0, 1 ) );

ALTER TABLE tbl_crc_det_factura
    ADD CONSTRAINT ckc_servicio_fac CHECK ( servicio IN ( 0, 1 ) );

ALTER TABLE tbl_crc_det_factura ADD CONSTRAINT factura_pk PRIMARY KEY ( id_det_factura );

CREATE TABLE tbl_crc_det_mantenimientos (
    id_det_mantenimiento  NUMBER(8) NOT NULL,
    id_mantenimiento      NUMBER(3) NOT NULL,
    cantidad              NUMBER(4) NOT NULL,
    prd_lvl_number        NUMBER(8) NOT NULL,
    estado                NUMBER(3) NOT NULL,
    id_mecanico           NUMBER(5) NOT NULL,
    id_vehiculo           NUMBER NOT NULL,
    org_lvl_number        NUMBER(12) NOT NULL
);

CREATE INDEX det_mantenimientos_idx ON
    tbl_crc_det_mantenimientos (
        id_det_mantenimiento
    ASC,
        prd_lvl_number
    ASC );

ALTER TABLE tbl_crc_det_mantenimientos ADD CONSTRAINT det_mantenimientos_pk PRIMARY KEY ( id_det_mantenimiento );

CREATE TABLE tbl_crc_estados_cliente (
    id_estado    NUMBER(3) NOT NULL,
    desc_estado  VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN tbl_crc_estados_cliente.desc_estado IS
    'Descripcion del estado';

ALTER TABLE tbl_crc_estados_cliente ADD CONSTRAINT estados_pk PRIMARY KEY ( id_estado );

CREATE TABLE tbl_crc_estados_mantenimientos (
    id_estado    NUMBER(3) NOT NULL,
    desc_estado  VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN tbl_crc_estados_mantenimientos.desc_estado IS
    'Descripcion del estado';

ALTER TABLE tbl_crc_estados_mantenimientos ADD CONSTRAINT estados_mantenimientos_pk PRIMARY KEY ( id_estado );

CREATE TABLE tbl_crc_estados_vehiculo (
    id_estado    NUMBER(3) NOT NULL,
    desc_estado  VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN tbl_crc_estados_vehiculo.desc_estado IS
    'Descripcion del estado';

ALTER TABLE tbl_crc_estados_vehiculo ADD CONSTRAINT estados_vehiculo_pk PRIMARY KEY ( id_estado );

CREATE TABLE tbl_crc_factura (
    id_factura                   NUMBER(8) NOT NULL,
    fecha_factura                DATE NOT NULL,
    id_cliente                   NUMBER(8) NOT NULL,
    id_mantenimiento             NUMBER(3) NOT NULL,
    nombres_cliente              VARCHAR2(60) NOT NULL,
    identificacion_cliente       VARCHAR2(20) NOT NULL,
    apellidos_cliente            VARCHAR2(60) NOT NULL,
    telefono_contacto_cliente    VARCHAR2(20) NOT NULL,
    direccion_cliente            VARCHAR2(150) NOT NULL,
    email_cliente                VARCHAR2(60) NOT NULL,
    nombres_mecanico             VARCHAR2(60) NOT NULL,
    identificacion_mecanico      VARCHAR2(20) NOT NULL,
    apellidos_mecanicocliente_1  VARCHAR2(60) NOT NULL,
    telefono_contacto_mecanico   VARCHAR2(20) NOT NULL,
    direccion_tienda             VARCHAR2(150) NOT NULL,
    email_serv_carcenter         VARCHAR2(60) NOT NULL,
    total_descuento              NUMBER(11, 3) NOT NULL,
    total_factura                NUMBER(11, 3) NOT NULL,
    org_lvl_number               NUMBER(12) NOT NULL
);

CREATE INDEX tbl_crc_factura__idx ON
    tbl_crc_factura (
        id_factura
    ASC,
        id_mantenimiento
    ASC,
        identificacion_cliente
    ASC );

ALTER TABLE tbl_crc_factura ADD CONSTRAINT tbl_crc_factura_pk PRIMARY KEY ( id_factura );

CREATE TABLE tbl_crc_mantenimientos (
    id_mantenimiento  NUMBER(3) NOT NULL,
    descripcion       VARCHAR2(150),
    fecha_agenda      DATE NOT NULL,
    fecha_entrada     DATE,
    fecha_salida      DATE,
    estado            NUMBER(3) NOT NULL,
    org_lvl_number    NUMBER(12) NOT NULL,
    imagen            BLOB,
    id_cliente        NUMBER(8) NOT NULL
);

COMMENT ON COLUMN tbl_crc_mantenimientos.descripcion IS
    'Descripción de la falla presentada en el vehiculo ';

ALTER TABLE tbl_crc_mantenimientos ADD CONSTRAINT mantenimientos_pk PRIMARY KEY ( id_mantenimiento );

CREATE TABLE tbl_crc_mecanico (
    id_mecanico        NUMBER(5) NOT NULL,
    identificacion     NUMBER(20) NOT NULL,
    nombres            VARCHAR2(60) NOT NULL,
    apellidos          VARCHAR2(60) NOT NULL,
    org_lvl_number     NUMBER(12) NOT NULL,
    telefono_contacto  NUMBER(20) NOT NULL,
    direccion          VARCHAR2(150) NOT NULL,
    email              VARCHAR2(60) NOT NULL
);

ALTER TABLE tbl_crc_mecanico ADD CONSTRAINT mecanico_pk PRIMARY KEY ( id_mecanico );

CREATE TABLE tbl_crc_productos (
    prd_lvl_number    NUMBER(8) NOT NULL,
    prd_name_full     VARCHAR2(50) NOT NULL,
    org_lvl_number    VARCHAR2(8) NOT NULL,
    prd_cost          NUMBER(11, 3) NOT NULL,
    prd_status        NUMBER(1) NOT NULL,
    servicio          NUMBER(1) NOT NULL,
    id_tipo_servicio  NUMBER(3) NOT NULL,
    repuesto          NUMBER(1) NOT NULL,
    inv_disponible    VARCHAR2(9) NOT NULL
);

CREATE INDEX tbl_crc_productos__idx ON
    tbl_crc_productos (
        prd_lvl_number
    ASC,
        org_lvl_number
    ASC );

ALTER TABLE tbl_crc_productos
    ADD CONSTRAINT ckc_repuesto CHECK ( repuesto IN ( 0, 1 ) );

ALTER TABLE tbl_crc_productos
    ADD CONSTRAINT ckc_servicio CHECK ( servicio IN ( 0, 1 ) );

ALTER TABLE tbl_crc_productos ADD CONSTRAINT servicios_pk PRIMARY KEY ( prd_lvl_number );

CREATE TABLE tbl_crc_tiendas (
    org_lvl_number  NUMBER(12) NOT NULL,
    org_full_name   VARCHAR2(20) NOT NULL,
    estado          NUMBER(1) NOT NULL
);

ALTER TABLE tbl_crc_tiendas
    ADD CONSTRAINT ckc_org_lvl_number CHECK ( org_lvl_number IN ( 0, 1 ) );

ALTER TABLE tbl_crc_tiendas ADD CONSTRAINT tiendas_pk PRIMARY KEY ( org_lvl_number );

CREATE TABLE tbl_crc_tipo_cliente (
    id_tipo_cliente    NUMBER(2) NOT NULL,
    desc_tipo_cliente  VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN tbl_crc_tipo_cliente.desc_tipo_cliente IS
    'Descripcion del estado';

ALTER TABLE tbl_crc_tipo_cliente ADD CONSTRAINT tipo_cliente_pk PRIMARY KEY ( id_tipo_cliente );

CREATE TABLE tbl_crc_tipo_documento (
    id_tipo_documento    NUMBER(2) NOT NULL,
    desc_tipo_documento  VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN tbl_crc_tipo_documento.desc_tipo_documento IS
    'Descripcion del estado';

ALTER TABLE tbl_crc_tipo_documento ADD CONSTRAINT tipo_documento_pk PRIMARY KEY ( id_tipo_documento );

CREATE TABLE tbl_crc_tipo_servicio (
    id_tipo_servicio  NUMBER(3) NOT NULL,
    desc_servicio     VARCHAR2(16) NOT NULL,
    valor_minimo      NUMBER(7, 3) NOT NULL,
    valor_maximo      NUMBER(7, 3) NOT NULL
);

ALTER TABLE tbl_crc_tipo_servicio ADD CONSTRAINT servicio_pk PRIMARY KEY ( id_tipo_servicio );

CREATE TABLE tbl_crc_vehiculo (
    id_vehiculo  NUMBER NOT NULL,
    id_cliente   NUMBER(8) NOT NULL,
    placa        VARCHAR2(8) NOT NULL,
    marca        VARCHAR2(20) NOT NULL,
    modelo       NUMBER(4) NOT NULL,
    color        VARCHAR2(20) NOT NULL,
    estado       NUMBER(3) NOT NULL
);

ALTER TABLE tbl_crc_vehiculo ADD CONSTRAINT vehiculo_pk PRIMARY KEY ( id_vehiculo );

ALTER TABLE tbl_crc_factura
    ADD CONSTRAINT cliente_fk FOREIGN KEY ( id_cliente )
        REFERENCES tbl_crc_cliente ( id_cliente );

ALTER TABLE tbl_crc_mantenimientos
    ADD CONSTRAINT cliente_fkv1 FOREIGN KEY ( id_cliente )
        REFERENCES tbl_crc_cliente ( id_cliente );

ALTER TABLE tbl_crc_det_factura
    ADD CONSTRAINT det_mantenimientosf_fk FOREIGN KEY ( id_det_mantenimiento )
        REFERENCES tbl_crc_det_mantenimientos ( id_det_mantenimiento );

ALTER TABLE tbl_crc_cliente
    ADD CONSTRAINT estado_cli_fk FOREIGN KEY ( estado )
        REFERENCES tbl_crc_estados_cliente ( id_estado );

ALTER TABLE tbl_crc_det_mantenimientos
    ADD CONSTRAINT estados_mantenimientos_fk FOREIGN KEY ( estado )
        REFERENCES tbl_crc_estados_mantenimientos ( id_estado );

ALTER TABLE tbl_crc_det_factura
    ADD CONSTRAINT factura_fk FOREIGN KEY ( id_factura )
        REFERENCES tbl_crc_factura ( id_factura );

ALTER TABLE tbl_crc_vehiculo
    ADD CONSTRAINT id_cliente_fk FOREIGN KEY ( id_cliente )
        REFERENCES tbl_crc_cliente ( id_cliente );

ALTER TABLE tbl_crc_mantenimientos
    ADD CONSTRAINT id_estado_mant_fk FOREIGN KEY ( estado )
        REFERENCES tbl_crc_estados_mantenimientos ( id_estado );

ALTER TABLE tbl_crc_vehiculo
    ADD CONSTRAINT id_estados_vehi_fk FOREIGN KEY ( estado )
        REFERENCES tbl_crc_estados_vehiculo ( id_estado );

ALTER TABLE tbl_crc_det_mantenimientos
    ADD CONSTRAINT mantenimientos_fk FOREIGN KEY ( id_mantenimiento )
        REFERENCES tbl_crc_mantenimientos ( id_mantenimiento );

ALTER TABLE tbl_crc_factura
    ADD CONSTRAINT mantenimientosc_fk FOREIGN KEY ( id_mantenimiento )
        REFERENCES tbl_crc_mantenimientos ( id_mantenimiento );

ALTER TABLE tbl_crc_det_mantenimientos
    ADD CONSTRAINT mecanico_fk FOREIGN KEY ( id_mecanico )
        REFERENCES tbl_crc_mecanico ( id_mecanico );

ALTER TABLE tbl_crc_det_factura
    ADD CONSTRAINT mecanicof_fk FOREIGN KEY ( id_mecanico )
        REFERENCES tbl_crc_mecanico ( id_mecanico );

ALTER TABLE tbl_crc_det_mantenimientos
    ADD CONSTRAINT productos_fk FOREIGN KEY ( prd_lvl_number )
        REFERENCES tbl_crc_productos ( prd_lvl_number );

ALTER TABLE tbl_crc_productos
    ADD CONSTRAINT servicio_fk FOREIGN KEY ( id_tipo_servicio )
        REFERENCES tbl_crc_tipo_servicio ( id_tipo_servicio );

ALTER TABLE tbl_crc_mantenimientos
    ADD CONSTRAINT tiendas_fk FOREIGN KEY ( org_lvl_number )
        REFERENCES tbl_crc_tiendas ( org_lvl_number );

ALTER TABLE tbl_crc_det_mantenimientos
    ADD CONSTRAINT tiendasdm_fk FOREIGN KEY ( org_lvl_number )
        REFERENCES tbl_crc_tiendas ( org_lvl_number );

ALTER TABLE tbl_crc_factura
    ADD CONSTRAINT tiendasf_fk FOREIGN KEY ( org_lvl_number )
        REFERENCES tbl_crc_tiendas ( org_lvl_number );

ALTER TABLE tbl_crc_mecanico
    ADD CONSTRAINT tiendasm_fk FOREIGN KEY ( org_lvl_number )
        REFERENCES tbl_crc_tiendas ( org_lvl_number );

ALTER TABLE tbl_crc_cliente
    ADD CONSTRAINT tipo_cliente_fk FOREIGN KEY ( id_tipo_cliente )
        REFERENCES tbl_crc_tipo_cliente ( id_tipo_cliente );

ALTER TABLE tbl_crc_cliente
    ADD CONSTRAINT tipo_documento_fk FOREIGN KEY ( id_tipo_documento )
        REFERENCES tbl_crc_tipo_documento ( id_tipo_documento );

ALTER TABLE tbl_crc_det_mantenimientos
    ADD CONSTRAINT vehiculo_fk FOREIGN KEY ( id_vehiculo )
        REFERENCES tbl_crc_vehiculo ( id_vehiculo );


-- ERRORS                                   0
-- WARNINGS                                 0
