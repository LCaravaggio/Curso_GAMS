$TITLE  Model basico.GMS: Economia cerrada 2x2
$OFFLISTING

$ONTEXT
                      Sectores               Consumidores
   Mercados  |    X       Y        W    |        HOG
   ------------------------------------------------------
        PX   |  100             -100    |
        PY   |          100     -100    |
        PW   |                   200    |       -200
        PL   |  -25     -75             |        100
        PK   |  -75     -25             |        100
   ------------------------------------------------------

$OFFTEXT

PARAMETERS
  TX       Impuesto ad-valorem sobre los insumos del sector X
  LDOT     Multiplicador de la dotación de trabajo ;

LDOT  = 1 ;

$ONTEXT

$MODEL: basico

$SECTORS:
        X       ! Nivel de actividad del sector X
        Y       ! Nivel de actividad del sector Y
        W       ! Nivel de actividad del sector W

$COMMODITIES:
        PX      ! Precio del bien X
        PY      ! Precio del bien Y
        PL      ! Precio del factor L
        PK      ! Precio del factor K
        PW      ! Bienestar (funcion de gasto)

$CONSUMERS:
        HOG    ! Nivel de ingreso para el consumidor HOG

$PROD:X s:1
        O:PX  Q:100
        I:PL  Q: 25
        I:PK  Q: 75

$PROD:Y s:1
        O:PY  Q:100
        I:PL  Q: 75
        I:PK  Q: 25

$PROD:W s:1
        O:PW   Q:200
        I:PX   Q:100
        I:PY   Q:100

$DEMAND:HOG
        D:PW   Q:200
        E:PL   Q:(100*LDOT)
        E:PK   Q:100

$OFFTEXT

$SYSINCLUDE mpsgeset basico

PW.FX = 1;

$INCLUDE basico.GEN
SOLVE basico USING MCP;


*       Solve the counterfactuals

LDOT = 1.1;

$INCLUDE basico.GEN
SOLVE basico USING MCP;
