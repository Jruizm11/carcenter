--5.  Consulta de Clientes que han comprado un acumulado $100.000 en los últimos 60 día

WITH VENTAS AS (
  select cf.id_cliente, sum (total_factura) ACUMULADO from tbl_crc_factura cf
where fecha_factura >= trunc(sysdate-60)
group by cf.id_cliente
having sum (total_factura) >= '100000')
SELECT CL.*, V.ACUMULADO FROM Tbl_Crc_Cliente CL
JOIN VENTAS V
ON V.id_cliente = CL.ID_CLIENTE


--6.	Consulta de los 100 productos más vendidos en los últimos 30 días

WITH productos AS (
select df.prd_lvl_number, sum (cantidad) cantidad from tbl_crc_det_factura df
inner join tbl_crc_factura f
on f.id_factura = df.id_factura
where f.fecha_factura >= trunc(sysdate-30)
group by df.prd_lvl_number
order by cantidad desc)
select * from productos
where rownum <=100

--7.	Consulta de las tiendas que han vendido más de 100 UND del producto 100 en los últimos 60 días.

WITH vendidos AS (
select  f.org_lvl_number, sum (cantidad) Sumatoria from tbl_crc_det_factura df
inner join tbl_crc_factura f
on f.id_factura = df.id_factura
where df.prd_lvl_number = 100
group by f.org_lvl_number
having sum (cantidad) >= 100)
select t.*, sumatoria from tbl_crc_tiendas t
join vendidos v
on v.org_lvl_number = t.org_lvl_number

--8.	Consulta de todos los clientes que han tenido más de un(1) mantenimento en los últimos 30 días.


WITH mantenimientos AS (
select m.id_cliente, count (*) from tbl_crc_mantenimientos m
where m.fecha_entrada >= trunc(sysdate-30)
group by id_cliente
having count (*)>1)
select c.* from tbl_crc_cliente c
join mantenimientos a
on a.id_cliente = c.id_cliente