CREATE OR REPLACE PACKAGE PKG_CARCENTER IS

  /*
         PROPIEDAD INTELECTUAL DE SODIMAC
         PACKAGE  : PKG_INSTALADOR
         DESCRIPCION  : PKG PARA USAR EN EL PROYECTO DE CARCENTER PARA EL MANEJO DEL INVENTARIO DE LOS PRODUCTOS EN TIENDA

     */

 P_TAG            VARCHAR2 (1000);
 P_PARAMETROS     VARCHAR2 (4000);
 P_SEPARADOR      VARCHAR2 (1000) := '#';
 P_RESULTADO      NUMBER (4);
 P_MENSAJE        VARCHAR2 (1000);
 V_CODIGO_INTERNO VARCHAR2(100);
 V_ESTADO_INTERNO VARCHAR2(4000);
 v_err_n          NUMBER;
 v_err_msj        VARCHAR2(4000);

 PROCEDURE PRC_GET_INVENTARIO (P_ID_MANTENIMIENTO   IN VARCHAR2,
                              P_FACILITY_ID   IN NUMBER,
                              P_PRODUCTOS IN NUMBER);
                                   
END PKG_CARCENTER;
/

CREATE OR REPLACE PACKAGE BODY PKG_CARCENTER IS


  PROCEDURE PRC_GET_INVENTARIO (P_ID_MANTENIMIENTO   IN VARCHAR2,
                              P_FACILITY_ID   IN NUMBER,
                              P_PRODUCTOS IN NUMBER)
IS
    BEGIN

       P_TAG          := 'CRCMANINV';
       P_PARAMETROS   := '#' || P_FACILITY_ID  || '#' || P_PRODUCTOS || '#' || P_ID_MANTENIMIENTO ||'#'  ;

        PKG_SGL_SQL.PRC_EXE_SQL_NAME_TAG (P_TAG,
                                          P_PARAMETROS,
                                          P_SEPARADOR,
                                          P_RESULTADO,
                                          P_MENSAJE);


  EXCEPTION
    WHEN OTHERS THEN
     v_err_n   := SQLCODE;
     v_err_msj := 'Error en PKG_CARCENTER.PRC_GET_INVENTARIO: ' || SQLERRM;
     PKG_LOG_EXCEPCIONES.PRC_CAPTURA_ERROR (v_err_n,
                                            v_err_msj,
                                            null,
                                            'PKG_CARCENTER.PRC_GET_INVENTARIO');
  END PRC_GET_INVENTARIO;



 END PKG_CARCENTER;

/