SQL> 
SQL> 
SQL> CREATE OR REPLACE PACKAGE PKG_CARCENTER IS
  2  
  3    /*
  4           PROPIEDAD INTELECTUAL DE SODIMAC
  5           PACKAGE  : PKG_INSTALADOR
  6           DESCRIPCION  : PKG PARA USAR EN EL PROYECTO DE CARCENTER PARA EL MANEJO DEL INVENTARIO DE LOS PRODUCTOS EN TIENDA
  7  
  8       */
  9  
 10   P_TAG            VARCHAR2 (1000);
 11   P_PARAMETROS     VARCHAR2 (4000);
 12   P_SEPARADOR      VARCHAR2 (1000) := '#';
 13   P_RESULTADO      NUMBER (4);
 14   P_MENSAJE        VARCHAR2 (1000);
 15   V_CODIGO_INTERNO VARCHAR2(100);
 16   V_ESTADO_INTERNO VARCHAR2(4000);
 17   v_err_n          NUMBER;
 18   v_err_msj        VARCHAR2(4000);
 19  
 20   PROCEDURE PRC_GET_INVENTARIO (P_ID_MANTENIMIENTO   IN VARCHAR2,
 21                                P_FACILITY_ID   IN NUMBER,
 22                                P_PRODUCTOS IN NUMBER);
 23  
 24  END PKG_CARCENTER;
 25  /

Package created


SQL> CREATE OR REPLACE PACKAGE BODY PKG_CARCENTER IS
  2  
  3  
  4    PROCEDURE PRC_GET_INVENTARIO (P_ID_MANTENIMIENTO   IN VARCHAR2,
  5                                P_FACILITY_ID   IN NUMBER,
  6                                P_PRODUCTOS IN NUMBER)
  7  IS
  8      BEGIN
  9  
 10         P_TAG          := 'CRCMANINV';
 11         P_PARAMETROS   := '#' || P_FACILITY_ID  || '#' || P_PRODUCTOS || '#' || P_ID_MANTENIMIENTO ||'#'  ;
 12  
 13          PKG_SGL_SQL.PRC_EXE_SQL_NAME_TAG (P_TAG,
 14                                            P_PARAMETROS,
 15                                            P_SEPARADOR,
 16                                            P_RESULTADO,
 17                                            P_MENSAJE);
 18  
 19  
 20    EXCEPTION
 21      WHEN OTHERS THEN
 22       v_err_n   := SQLCODE;
 23       v_err_msj := 'Error en PKG_CARCENTER.PRC_GET_INVENTARIO: ' || SQLERRM;
 24       PKG_LOG_EXCEPCIONES.PRC_CAPTURA_ERROR (v_err_n,
 25                                              v_err_msj,
 26                                              null,
 27                                              'PKG_CARCENTER.PRC_GET_INVENTARIO');
 28    END PRC_GET_INVENTARIO;
 29  
 30  
 31  
 32   END PKG_CARCENTER;
 33  
 34  /

Package body created


SQL> 