$TITLE  Model basico_GOB: Economia cerrada 2x2 con Gobierno (Impuestos y provision de bienes publicos)

$ontext

El supuesto de redistribución de suma-fija es un truco conveniente
que simplifica el análisis de la política fiscal. En la práctica, los gobiernos
usan a menudo el dinero para comprar cosas que los mercados privados no brindan.
La gente valora la provisión pública, pero por alguna razón no es fácil
para recolectar dinero de los beneficiarios de estos bienes publicos.

En este modelo usamos un truco para proporcionar a ambos consumidores un
suministro completo del bien público. El gobierno como agente consumidor compra
el bien público (es decir, para su propio "consumo") con ingresos fiscales.
La restriccion de racionamiento asigna a cada hogar (consumidor privado)
una "dotación" del bien público, cuya suma se corresponde con la cantidad
realmente producida de ese bien publico.

PG es el costo marginal del bien público. PG1 y PG2 son las valoraciones privadas
del bien público por parte de los dos consumidores privados (HOG 1 y HOG2).
Las valoraciones privadas de los bienes publicos no aparecen en la MCS,
pero para hacer cualquier análisis de bienestar, necesitamos conocer estos valores.

La situacion presentada en la siguiente MCS representa un Optimo de Pareto:
éste satisface las condiciones de Samuelson que establece que la suma de las
valoraciones privadas de los bienes publicos debe igualarse con el costo de
proveerlos.

MCS inicial (benchmark)

             Sectores Productivos          Consumidores

Mercados|    X    Y    G   W1   W2        HOG1    HOG2   GOVT
 ---------------------------------------------------------------
   PX   |  100            -70  -30
   PY   |       100       -30  -70
   PG   |             50                                  -50
   PL   |  -50  -30  -20                    50      50
   PK   |  -30  -50  -20                    50      50

   TAX  |  -20  -20  -10                                   50

   PW1  |                  125            -125
   PW2  |                       125               -125
   PG1  |                  -25              25
   PG2  |                       -25                 25
---------------------------------------------------------------

$offtext

SCALAR  TAX     Impuesto al VA;

$ONTEXT

$MODEL:basico_GOB

$SECTORS:
        X       ! Nivel de actividad del sector X
        Y       ! Nivel de actividad del sector Y
        G       ! Nivel de actividad del sector G  (bienes publicos)
        W1      ! Nivel de actividad del sector W1 (HOG 1 welfare index)
        W2      ! Nivel de actividad del sector W2 (HOG 2 welfare index)

$COMMODITIES:
        PX      ! Precio del bien X
        PY      ! Precio del bien Y
        PG      ! Precio del bien G (costo marginal de los bienes publicos)
        PL      ! Precio del factor L (neto de impuesto)
        PK      ! Precio del factor K
        PW1     ! Precio del bienestar W1 (HOG 1)
        PW2     ! Precio del bienestar W2 (HOG 2)
        PG1     ! Valuacion privada de los bienes publicos (HOG 1)
        PG2     ! Valuacion privada de los bienes publicos (HOG 2)

$CONSUMERS:
        HOG1   ! HOG 1
        HOG2   ! HOG 2
        GOV    ! Gobierno

$AUXILIARY:
        LGP     ! Nivel de provision de bienes publicos por el gobierno

*       Se supone que el pago de impuestos en el bechmarch constituye un
*       impuesto uniforme al VA:

$PROD:X  s:1
        O:PX     Q:100
        I:PL     Q: 50   P:1.25  A:GOV  T:TAX
        I:PK     Q: 30   P:1.25  A:GOV  T:TAX

$PROD:Y   s:1
        O:PY     Q:100
        I:PL     Q: 30   P:1.25  A:GOV  T:TAX
        I:PK     Q: 50   P:1.25  A:GOV  T:TAX

$PROD:G  s:1
        O:PG     Q: 50
        I:PL     Q: 20  P:1.25  A:GOV  T:TAX
        I:PK     Q: 20  P:1.25  A:GOV  T:TAX

*       En los datos de la MCS tenemos un monto de 50 del bien publico producido
*       Si queremos suponer que esta es una cantidad óptima, entonces la suma de
*       los precios de demanda de los HOGs por este bien publico debe sumar 1.
*       demanda precios de cada uno de los consumidores por 50 unidades del público
*       Las funciones de utilidad a continuación se especifican (calibrado) de modo
*       que cada consumidor "exija" 50 unidades del bien público si el precio es 0.5
*       dados los niveles de consumo del resto de los bienes.

$PROD:W1   s:1
        O:PW1   Q:125
        I:PX    Q: 70
        I:PY    Q: 30
        I:PG1   Q: 50   P:0.5

$PROD:W2   s:1
        O:PW2   Q:125
        I:PX    Q: 30
        I:PY    Q: 70
        I:PG2   Q: 50   P:0.5

$DEMAND:GOV
        D:PG

$DEMAND:HOG1
        D:PW1   Q:125
        E:PL    Q: 50
        E:PK    Q: 50
        E:PG1   Q: 50  R:LGP

$DEMAND:HOG2
        D:PW2   Q:125
        E:PL    Q: 50
        E:PK    Q: 50
        E:PG2   Q: 50  R:LGP

$CONSTRAINT:LGP
        LGP =E= G;

$OFFTEXT
$SYSINCLUDE mpsgeset basico_GOB

*       Replicamos el benchmark

TAX = 0.25;
LGP.L = 1;
PG1.L = 0.5;
PG2.L = 0.5;

basico_GOB.ITERLIM = 0;
$INCLUDE basico_GOB.GEN
SOLVE basico_GOB USING MCP;

basico_GOB.ITERLIM = 2000;

*       Ejericio 1:
*       -----------
*       Verificar que el bechmark es una situacion de optimo.
*       Para ello realizar una simulacion con un impuesto mayor/menor al
*       existente (ej. TAX=0.26 y TAX=0.24)


*       Ejericio 2:
*       -----------
*       ¿como harian para cada bien de manera diferenciada?
*       Suponga por ejemplo que los bienes publicos estan gravados por
*       una tasa que corresponde a la mitad de la que paga el resto de la
*       economia.
