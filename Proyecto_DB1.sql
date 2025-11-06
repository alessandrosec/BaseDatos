CREATE TABLE Departamento (
    id_departamento NUMBER PRIMARY KEY,
    nombre_departamento VARCHAR2 (50)NOT NULL
);

CREATE TABLE Clase_Producto (
    id_clase_producto NUMBER PRIMARY KEY,
    nombre_clase_producto VARCHAR2 (100) NOT NULL
);

CREATE TABLE Clase_Empleado (
    id_clase_empleado NUMBER PRIMARY KEY,
    nombre_clase_empleado VARCHAR2 (75) NOT NULL
);

CREATE TABLE Municipio (
    id_municipio NUMBER PRIMARY KEY,
    id_departamento NUMBER NOT NULL,
    nombre_municipio VARCHAR2 (100) NOT NULL,
    
    CONSTRAINT fk_municipio_departamento
        FOREIGN KEY (id_departamento)               -- Propósito: Decirle a Oracle que esa columna es una FK | la columna id_departamento que acabo de crear
        REFERENCES Departamento (id_departamento)   -- Propósito: Decir a qué tabla y columna específica hace referencia     
);

CREATE TABLE Cliente (
    id_cliente NUMBER PRIMARY KEY,
    id_departamento NUMBER NOT NULL,
    nombre VARCHAR2 (50) NOT NULL,
    apellido VARCHAR2 (50) NOT NULL,
    direccion VARCHAR2 (200) NOT NULL,
    estado CHAR (1),
    
    CONSTRAINT fk_cliente_municipio
        FOREIGN KEY (id_departamento)
        REFERENCES Departamento (id_departamento)
);

CREATE TABLE Proveedor (
    id_proveedor NUMBER PRIMARY KEY,
    id_departamento NUMBER NOT NULL,
    razon_social VARCHAR2 (250) NULL,
    direccion VARCHAR2 (200) NOT NULL,
    estado CHAR (1) NOT NULL,
    
    CONSTRAINT fk_proveedor_departamento
        FOREIGN KEY (id_departamento)
        REFERENCES Departamento (id_departamento)
);

CREATE TABLE Tienda (
    id_tienda NUMBER PRIMARY KEY,
    nombre VARCHAR2 (200) NOT NULL,
    direccion VARCHAR2 (300),
    id_municipio NUMBER NOT NULL,
    id_departamento NUMBER NOT NULL,
    
    CONSTRAINT fk_tienda_municipio
        FOREIGN KEY (id_municipio)
        REFERENCES Municipio (id_municipio),
        
    CONSTRAINT fk_tienda_departamento
        FOREIGN KEY (id_departamento)
        REFERENCES Departamento (id_departamento)
);

CREATE TABLE Empleado (
    id_empleado NUMBER PRIMARY KEY,
    nombre VARCHAR2 (50) NOT NULL,
    apellido VARCHAR2 (50) NOT NULL,
    direccion VARCHAR (300) NULL,
    id_tienda NUMBER NOT NULL,
    id_clase_producto NUMBER NOT NULL,
    
    CONSTRAINT fk_empleado_tienda
        FOREIGN KEY (id_tienda)
        REFERENCES Tienda (id_tienda),
        
    CONSTRAINT fk_empleado_claseProducto
        FOREIGN KEY (id_clase_producto)
        REFERENCES Clase_Producto (id_clase_producto)
);

CREATE TABLE Ingreso (
    id_ingreso NUMBER PRIMARY KEY,
    
    -- Datos de Ingreso
    fecha DATE NOT NULL,
    tipo_ingreso VARCHAR2 (100) NOT NULL,
    documento VARCHAR2 (200) NOT NULL,
    serie VARCHAR2(50) NOT NULL,
    monto_total NUMBER (10,2),
    
    -- Datos de Transacción
    fecha_transaccion DATE DEFAULT SYSDATE, -- Asigna automaticamente fecha al Ingreso
    usuario_transaccion VARCHAR(75),
    
    -- Foreign Keys
    id_tienda NUMBER NOT NULL,
    id_empleado NUMBER NOT NULL,
    id_proveedor NUMBER NOT NULL,
    id_departamento NUMBER NOT NULL,
    
    CONSTRAINT fk_ingreso_tienda
        FOREIGN KEY (id_tienda)
        REFERENCES Tienda (id_tienda),
        
    CONSTRAINT fk_ingreso_empleado
        FOREIGN KEY (id_empleado)
        REFERENCES Empleado (id_empleado),
        
    CONSTRAINT fk_ingreso_proveedor
        FOREIGN KEY (id_proveedor)
        REFERENCES Proveedor (id_proveedor),
        
    CONSTRAINT fk_ingreso_departamento
        FOREIGN KEY (id_departamento)
        REFERENCES Departamento (id_departamento)
);

CREATE TABLE Egreso(
    id_ingreso NUMBER PRIMARY KEY,
    
    -- Datos de Egreso
    fecha DATE NOT NULL,
    tipo_egreso VARCHAR2 (75),
    documento VARCHAR2 (100),
    serie VARCHAR2 (50),
    monto NUMBER (10,2),
    
    -- Datos de Transacción
    fecha_transaccion DATE DEFAULT SYSDATE,
    usuario_transaccion VARCHAR2 (100),
    
    -- Foreign Keys
    id_tienda NUMBER NOT NULL,
    id_empleado NUMBER NOT NULL,
    id_proveedor NUMBER NOT NULL,
    id_departamento NUMBER NOT NULL,
    
    CONSTRAINT fk_egreso_tienda
        FOREIGN KEY (id_tienda)
        REFERENCES Tienda (id_tienda),
        
    CONSTRAINT fk_egreso_empleado
        FOREIGN KEY (id_empleado)
        REFERENCES Empleado (id_empleado),
        
    CONSTRAINT fk_egreso_proveedor
        FOREIGN KEY (id_proveedor)
        REFERENCES Proveedor (id_proveedor),
        
    CONSTRAINT fk_egreso_departamento
        FOREIGN KEY (id_departamento)
        REFERENCES Departamento (id_departamento)
);

CREATE TABLE Producto (
    id_producto NUMBER PRIMARY KEY,
    nombre_producto VARCHAR2 (100),
    
    id_clase_producto NUMBER NOT NULL,
    
    CONSTRAINT fk_producto_claseProducto
        FOREIGN KEY (id_clase_producto)
        REFERENCES Clase_Producto (id_clase_producto)
);

CREATE TABLE Pasillo (
    id_pasillo NUMBER PRIMARY KEY,
    descripcion VARCHAR2 (250) NOT NULL,
    
    id_tienda NUMBER NOT NULL,
    
    CONSTRAINT fk_pasillo_tienda
        FOREIGN KEY (id_tienda)
        REFERENCES Tienda (id_tienda)
);

CREATE TABLE Promocion (
    id_promocion NUMBER PRIMARY KEY,
    nombre VARCHAR2 (200) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_final DATE NOT NULL,
    estado CHAR (1) DEFAULT 'A' NOT NULL,
    
    id_tienda NUMBER NOT NULL,
    
    CONSTRAINT fk_promocion_tienda
        FOREIGN KEY (id_tienda)
        REFERENCES Tienda (id_tienda),
        
    CONSTRAINT chk_promocion_fechas
        CHECK (fecha_final >= fecha_inicio),
        
    CONSTRAINT chk_pomocion_estado
        CHECK (estado IN ('A', 'I', 'F', 'C')) -- 'A' = Activa | 'I' = Inactiva | 'F' = Finalizada | 'C' = Cancelada
);

CREATE TABLE Inventario (
    id_inventario NUMBER PRIMARY KEY,
    fecha DATE NOT NULL,
    fecha_inicio DATE,
    fecha_final DATE,
    estado VARCHAR2 (50) DEFAULT 'En Proceso',
    
);

CREATE TABLE Departamento (
    id_departamento NUMBER PRIMARY KEY,
    nombre_departamento VARCHAR2 (50)NOT NULL
);

CREATE TABLE Clase_Producto (
    id_clase_producto NUMBER PRIMARY KEY,
    nombre_clase_producto VARCHAR2 (100) NOT NULL
);

CREATE TABLE Clase_Empleado (
    id_clase_empleado NUMBER PRIMARY KEY,
    nombre_clase_empleado VARCHAR2 (75) NOT NULL
);

CREATE TABLE Municipio (
    id_municipio NUMBER PRIMARY KEY,
    id_departamento NUMBER NOT NULL,
    nombre_municipio VARCHAR2 (100) NOT NULL,
    
    CONSTRAINT fk_municipio_departamento
        FOREIGN KEY (id_departamento)               -- Propósito: Decirle a Oracle que esa columna es una FK | la columna id_departamento que acabo de crear
        REFERENCES Departamento (id_departamento)   -- Propósito: Decir a qué tabla y columna específica hace referencia     
);

CREATE TABLE Cliente (
    id_cliente NUMBER PRIMARY KEY,
    id_departamento NUMBER NOT NULL,
    nombre VARCHAR2 (50) NOT NULL,
    apellido VARCHAR2 (50) NOT NULL,
    direccion VARCHAR2 (200) NOT NULL,
    estado CHAR (1),
    
    CONSTRAINT fk_cliente_municipio
        FOREIGN KEY (id_departamento)
        REFERENCES Departamento (id_departamento)
);

CREATE TABLE Proveedor (
    id_proveedor NUMBER PRIMARY KEY,
    id_departamento NUMBER NOT NULL,
    razon_social VARCHAR2 (250) NULL,
    direccion VARCHAR2 (200) NOT NULL,
    estado CHAR (1) NOT NULL,
    
    CONSTRAINT fk_proveedor_departamento
        FOREIGN KEY (id_departamento)
        REFERENCES Departamento (id_departamento)
);

CREATE TABLE Tienda (
    id_tienda NUMBER PRIMARY KEY,
    nombre VARCHAR2 (200) NOT NULL,
    direccion VARCHAR2 (300),
    id_municipio NUMBER NOT NULL,
    id_departamento NUMBER NOT NULL,
    
    CONSTRAINT fk_tienda_municipio
        FOREIGN KEY (id_municipio)
        REFERENCES Municipio (id_municipio),
        
    CONSTRAINT fk_tienda_departamento
        FOREIGN KEY (id_departamento)
        REFERENCES Departamento (id_departamento)
);

CREATE TABLE Empleado (
    id_empleado NUMBER PRIMARY KEY,
    nombre VARCHAR2 (50) NOT NULL,
    apellido VARCHAR2 (50) NOT NULL,
    direccion VARCHAR (300) NULL,
    id_tienda NUMBER NOT NULL,
    id_clase_producto NUMBER NOT NULL,
    
    CONSTRAINT fk_empleado_tienda
        FOREIGN KEY (id_tienda)
        REFERENCES Tienda (id_tienda),
        
    CONSTRAINT fk_empleado_claseProducto
        FOREIGN KEY (id_clase_producto)
        REFERENCES Clase_Producto (id_clase_producto)
);

CREATE TABLE Ingreso (
    id_ingreso NUMBER PRIMARY KEY,
    
    -- Datos de Ingreso
    fecha DATE NOT NULL,
    tipo_ingreso VARCHAR2 (100) NOT NULL,
    documento VARCHAR2 (200) NOT NULL,
    serie VARCHAR2(50) NOT NULL,
    monto_total NUMBER (10,2),
    
    -- Datos de Transacción
    fecha_transaccion DATE DEFAULT SYSDATE, -- Asigna automaticamente fecha al Ingreso
    usuario_transaccion VARCHAR(75),
    
    -- Foreign Keys
    id_tienda NUMBER NOT NULL,
    id_empleado NUMBER NOT NULL,
    id_proveedor NUMBER NOT NULL,
    id_departamento NUMBER NOT NULL,
    
    CONSTRAINT fk_ingreso_tienda
        FOREIGN KEY (id_tienda)
        REFERENCES Tienda (id_tienda),
        
    CONSTRAINT fk_ingreso_empleado
        FOREIGN KEY (id_empleado)
        REFERENCES Empleado (id_empleado),
        
    CONSTRAINT fk_ingreso_proveedor
        FOREIGN KEY (id_proveedor)
        REFERENCES Proveedor (id_proveedor),
        
    CONSTRAINT fk_ingreso_departamento
        FOREIGN KEY (id_departamento)
        REFERENCES Departamento (id_departamento)
);

CREATE TABLE Egreso(
    id_ingreso NUMBER PRIMARY KEY,
    
    -- Datos de Egreso
    fecha DATE NOT NULL,
    tipo_egreso VARCHAR2 (75),
    documento VARCHAR2 (100),
    serie VARCHAR2 (50),
    monto NUMBER (10,2),
    
    -- Datos de Transacción
    fecha_transaccion DATE DEFAULT SYSDATE,
    usuario_transaccion VARCHAR2 (100),
    
    -- Foreign Keys
    id_tienda NUMBER NOT NULL,
    id_empleado NUMBER NOT NULL,
    id_proveedor NUMBER NOT NULL,
    id_departamento NUMBER NOT NULL,
    
    CONSTRAINT fk_egreso_tienda
        FOREIGN KEY (id_tienda)
        REFERENCES Tienda (id_tienda),
        
    CONSTRAINT fk_egreso_empleado
        FOREIGN KEY (id_empleado)
        REFERENCES Empleado (id_empleado),
        
    CONSTRAINT fk_egreso_proveedor
        FOREIGN KEY (id_proveedor)
        REFERENCES Proveedor (id_proveedor),
        
    CONSTRAINT fk_egreso_departamento
        FOREIGN KEY (id_departamento)
        REFERENCES Departamento (id_departamento)
);

CREATE TABLE Producto (
    id_producto NUMBER PRIMARY KEY,
    nombre_producto VARCHAR2 (100),
    
    id_clase_producto NUMBER NOT NULL,
    
    CONSTRAINT fk_producto_claseProducto
        FOREIGN KEY (id_clase_producto)
        REFERENCES Clase_Producto (id_clase_producto)
);

CREATE TABLE Pasillo (
    id_pasillo NUMBER PRIMARY KEY,
    descripcion VARCHAR2 (250) NOT NULL,
    
    id_tienda NUMBER NOT NULL,
    
    CONSTRAINT fk_pasillo_tienda
        FOREIGN KEY (id_tienda)
        REFERENCES Tienda (id_tienda)
);

CREATE TABLE Promocion (
    id_promocion NUMBER PRIMARY KEY,
    nombre VARCHAR2 (200) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_final DATE NOT NULL,
    estado CHAR (1) DEFAULT 'A' NOT NULL,
    
    id_tienda NUMBER NOT NULL,
    
    CONSTRAINT fk_promocion_tienda
        FOREIGN KEY (id_tienda)
        REFERENCES Tienda (id_tienda),
        
    CONSTRAINT chk_promocion_fechas
        CHECK (fecha_final >= fecha_inicio),
        
    CONSTRAINT chk_pomocion_estado
        CHECK (estado IN ('A', 'I', 'F', 'C')) -- 'A' = Activa | 'I' = Inactiva | 'F' = Finalizada | 'C' = Cancelada
);

CREATE TABLE Inventario (
    id_inventario NUMBER PRIMARY KEY,
    fecha DATE NOT NULL,
    fecha_inicio DATE,
    fecha_final DATE,
    estado VARCHAR2 (50) DEFAULT 'En Proceso',
    
);

CREATE TABLE Detalle_Ingreso (
    id_detalle_ingreso NUMBER PRIMARY KEY,
    id_ingreso NUMBER NOT NULL,
    id_tienda NUMBER NOT NULL,
    id_producto NUMBER NOT NULL,
    id_clase_producto NUMBER NOT NULL,
    cantidad NUMBER NOT NULL,
    precio_unitario NUMBER(10,2) NOT NULL,
    fecha_transaccion DATE DEFAULT SYSDATE,
    usuario_transaccion VARCHAR2(75),
    
    CONSTRAINT fk_detingreso_ingreso
        FOREIGN KEY (id_ingreso)
        REFERENCES Ingreso (id_ingreso),
        
    CONSTRAINT fk_detingreso_tienda
        FOREIGN KEY (id_tienda)
        REFERENCES Tienda (id_tienda),
        
    CONSTRAINT fk_detingreso_producto
        FOREIGN KEY (id_producto)
        REFERENCES Producto (id_producto),
        
    CONSTRAINT fk_detingreso_claseproducto
        FOREIGN KEY (id_clase_producto)
        REFERENCES Clase_Producto (id_clase_producto)
);

CREATE TABLE Detalle_Egreso (
    id_detalle_egreso NUMBER PRIMARY KEY,
    linea NUMBER,
    id_egreso NUMBER NOT NULL,
    id_tienda NUMBER NOT NULL,
    id_producto NUMBER NOT NULL,
    id_clase_producto NUMBER NOT NULL,
    cantidad NUMBER NOT NULL,
    precio_unitario NUMBER(10,2) NOT NULL,
    fecha_transaccion DATE DEFAULT SYSDATE,
    usuario_transaccion VARCHAR2(75),
    
    CONSTRAINT fk_detegreso_egreso
        FOREIGN KEY (id_egreso)
        REFERENCES Egreso (id_ingreso),
        
    CONSTRAINT fk_detegreso_tienda
        FOREIGN KEY (id_tienda)
        REFERENCES Tienda (id_tienda),
        
    CONSTRAINT fk_detegreso_producto
        FOREIGN KEY (id_producto)
        REFERENCES Producto (id_producto),
        
    CONSTRAINT fk_detegreso_claseproducto
        FOREIGN KEY (id_clase_producto)
        REFERENCES Clase_Producto (id_clase_producto)
);

CREATE TABLE Detalle_Inventario (
    id_detalle_inventario NUMBER PRIMARY KEY,
    id_inventario NUMBER NOT NULL,
    id_tienda NUMBER NOT NULL,
    id_producto NUMBER NOT NULL,
    id_clase_producto NUMBER NOT NULL,
    cantidad_inicial NUMBER,
    cantidad_final NUMBER,
    cantidad_actual NUMBER,
    precio_inicial NUMBER(10,2),
    precio_final NUMBER(10,2),
    precio_actual NUMBER(10,2),
    fecha_transaccion DATE DEFAULT SYSDATE,
    
    CONSTRAINT fk_detinventario_inventario
        FOREIGN KEY (id_inventario)
        REFERENCES Inventario (id_inventario),
        
    CONSTRAINT fk_detinventario_tienda
        FOREIGN KEY (id_tienda)
        REFERENCES Tienda (id_tienda),
        
    CONSTRAINT fk_detinventario_producto
        FOREIGN KEY (id_producto)
        REFERENCES Producto (id_producto),
        
    CONSTRAINT fk_detinventario_claseproducto
        FOREIGN KEY (id_clase_producto)
        REFERENCES Clase_Producto (id_clase_producto)
);

CREATE TABLE Estanteria (
    id_estanteria NUMBER PRIMARY KEY,
    id_pasillo NUMBER NOT NULL,
    id_tienda NUMBER NOT NULL,
    descripcion VARCHAR2(250),
    
    CONSTRAINT fk_estanteria_pasillo
        FOREIGN KEY (id_pasillo)
        REFERENCES Pasillo (id_pasillo),
        
    CONSTRAINT fk_estanteria_tienda
        FOREIGN KEY (id_tienda)
        REFERENCES Tienda (id_tienda)
);

CREATE TABLE Casilla (
    id_casilla NUMBER PRIMARY KEY,
    id_estanteria NUMBER NOT NULL,
    id_pasillo NUMBER NOT NULL,
    id_tienda NUMBER NOT NULL,
    descripcion VARCHAR2(250),
    id_producto NUMBER NOT NULL,
    id_clase_producto NUMBER NOT NULL,
    precio NUMBER(10,2),
    
    CONSTRAINT fk_casilla_estanteria
        FOREIGN KEY (id_estanteria)
        REFERENCES Estanteria (id_estanteria),
        
    CONSTRAINT fk_casilla_pasillo
        FOREIGN KEY (id_pasillo)
        REFERENCES Pasillo (id_pasillo),
        
    CONSTRAINT fk_casilla_tienda
        FOREIGN KEY (id_tienda)
        REFERENCES Tienda (id_tienda),
        
    CONSTRAINT fk_casilla_producto
        FOREIGN KEY (id_producto)
        REFERENCES Producto (id_producto),
        
    CONSTRAINT fk_casilla_claseproducto
        FOREIGN KEY (id_clase_producto)
        REFERENCES Clase_Producto (id_clase_producto)
);




-- DISPENSADORES
CREATE SEQUENCE seq_departamento
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE seq_clase_producto
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE seq_clase_empleado
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;
