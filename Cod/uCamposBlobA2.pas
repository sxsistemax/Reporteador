unit uCamposBlobA2;

interface

Uses Classes, Forms, DB,  dbisamtb;

Type

  // Tabla SFixed, Campo FX_COSTOS
  TUnPrecio =  Record
     PorcUtil,
     PorcUtilEx      :  Boolean;
     Utilidad,
     UtilidadEx,
     SinImpuesto,
     MtoImpuesto1,
     MtoImpuesto2,
     TotalPrecio,
     TotalPrecioEx   :  Currency;
     TipoRound       :  Byte;
  end;

  TPrecios =  Array[1..6] of TUnPrecio;

  TCostos = Record
    CodeCompra       :  String[50];
    VImpuesto1         ,
    VImpuesto2         : Boolean;  //Impuestos Activados
    CostoAnteriorBs ,
    CostoAnteriorEx  ,
    CostoActualBs      ,
    CostoActualEx       ,
    CostoPromedioBs ,
    CostoPromedioEx ,
    MImpuesto1          ,
    MImpuesto2          : Currency;
    PorcentImp1           ,
    Exento1                    ,
    PorcentImp2           ,
    Excnto2        	    : Boolean;
    FechaVencimiento    : TDateTime;
    NumeroDeLote        : String[42];
    CostoReferencia     : Double;
    Precios             : TPrecios;
  end;

  // Tabla SFixed, Campo FX_ESTADISTICA
  TUnicoEstadisticas   = Array[0..2,0..16,0..20] of Double;
  // Fin SFixed

// Tabla SFixed
Function SFixedCostos( FX_COSTOS: TBlobField) : TCostos;


implementation

Function SFixedCostos( FX_COSTOS: TBlobField) : TCostos;
var
  R : TCostos;
  S : TStream;
  T :  TDBISAMTable;
Begin
  T := TDBISAMTable.Create(Application);
  S := T.CreateBlobStream(FX_COSTOS, bmRead) ;
  try
    S.Read(R, sizeof(R)) ;
  finally
    S.Free;
  end;

  Result := R;
End;

Function SFixedCostos( FX_COSTOS: TBlobField) : TCostos;
var
  R : TCostos;
  S : TStream;
  T :  TDBISAMTable;
Begin
  T := TDBISAMTable.Create(Application);
  S := T.CreateBlobStream(FX_COSTOS, bmRead) ;
  try
    S.Read(R, sizeof(R)) ;
  finally
    S.Free;
  end;

  Result := R;
End;
end.
