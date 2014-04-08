SELECT DISTINCT
  cl.FC_DESCRIPCION,
  cl.FC_NIT,
  cl.FC_TELEFONO,
  cl.FC_VENDEDOR,
  hi.FCC_NROVENDEDOR,
  hi.FCC_NUMERO,
  hi.FCC_CODIGO,
  hi.FCC_Usuario,
  us.Nombre
FROM
  "'edMesPeriodo.text'\HIST_Scuentasxcobrar.dat" hi
  INNER JOIN Sclientes cl ON (hi.FCC_CODIGO=cl.FC_CODIGO)
  INNER JOIN Susuarios us ON (hi.FCC_USUARIO=us.Code)
WHERE
  (hi.FCC_TIPOTRANSACCION = 54) AND
  (hi.FCC_MONTODOCUMENTO > 0)   AND
  (hi.FCC_NROVENDEDOR <> '') AND
  (hi.FCC_NROVENDEDOR = :VEND)
ORDER BY
  hi.FCC_CODIGO,
  hi.FCC_NUMERO
