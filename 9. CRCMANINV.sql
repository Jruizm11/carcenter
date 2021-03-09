WITH CAP_INV_RESTA AS
(SELECT CANTIDAD FROM TBL_CRC_DET_MANTENIMIENTOS
WHERE PRD_LVL_NUMBER = #P_PRODUCTOS AND ORG_LVL_NUMBER =#P_FACILITY_ID
AND ESTADO IN (1)), ----ESTADOS 1: CREADO, 2: ATENDIDO, 3:TERMINADO, 4:TERMINADO PARCIALMENTE, 5:PAGO, 6:CANCELADO, 7:PENDIENTE }

CAP_INV_SUMA AS
(SELECT CANTIDAD FROM TBL_CRC_DET_MANTENIMIENTOS
WHERE PRD_LVL_NUMBER = #P_PRODUCTOS AND ORG_LVL_NUMBER =#P_FACILITY_ID
AND ESTADO IN (6))----ESTADOS 1: CREADO, 2: ATENDIDO, 3:TERMINADO, 4:TERMINADO PARCIALMENTE, 5:PAGO, 6:CANCELADO, 7:PENDIENTE }

UPDATE TBL_CRC_PRODUCTOS D
SET D.INV_DISPONIBLE = D.INV_DISPONIBLE + ((SELECT CANTIDAD FROM CAP_INV_SUMA)-(SELECT CANTIDAD FROM CAP_INV_RESTA))
WHERE  PRD_LVL_NUMBER = #P_PRODUCTOS AND ORG_LVL_NUMBER =#P_FACILITY_ID

COMMIT;