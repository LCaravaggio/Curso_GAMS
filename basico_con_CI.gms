$TITLE  Model basico_CI: Economia cerrada 2X2 con insumos intermedios y anidamiento

$ontext

James R. Makusen
Thomas F. Rutherford

Department of Economics
University of Colorado

November, 1995 (revised)

                 Sectores de Produccion      Consumidor
   Mercados |    X       Y        W    |       CONS
   ------------------------------------------------------
       PX   |  120     -20     -100    |
       PY   |  -20     120     -100    |
       PW   |                   200    |       -200
       PL   |  -40     -60             |        100
       PK   |  -60     -40             |        100
    ------------------------------------------------------

$offtext

SCALAR  TX      impuesto ad-valorem sobre el VA del sector X /0/;

$ONTEXT

$MODEL: basico_CI

$SECTORS:
        X       ! Nivel de actividad del sector X
        Y       ! Nivel de actividad del sector Y
        W       ! Nivel de actividad del sector W (Hicksian welfare index)

$COMMODITIES:
        PX      ! Precio del bien X
        PY      ! Precio del bien Y
        PL      ! Precio del factor L
        PK      ! Precio del factor K
        PW      ! Indice de precios del bienestar (funcion de gasto)

$CONSUMERS:
        CONS    ! Nivel de ingreso para el consumidor HOG (agente unico)

*       MPSGE permite el uso de funciones compuestas a partir de funciones CES.

*       Las siguientes funciones de produccion CES comprenden 2 niveles.
*       El el VA, L y K se agregan de acuerdo a una funciòn Cobb-Douglas (va:1).
*       En el nivel superior, Y y VA(L,K) presentan una elasticidad de sustituciòn menor (s:0.5)


$PROD:X s:0.5  va:1
        O:PX  Q:120
        I:PY  Q: 20
        I:PL   Q:40  va: A:CONS  T:TX
        I:PK   Q:60  va: A:CONS  T:TX

$PROD:Y s:0.75  va:1
        O:PY   Q:120
        I:PX   Q: 20
        I:PL   Q: 60  va:
        I:PK   Q: 40  va:

$PROD:W s:1
        O:PW   Q:200
        I:PX   Q:100
        I:PY   Q:100

$DEMAND:CONS
        D:PW   Q:200
        E:PL   Q:100
        E:PK   Q:100

$OFFTEXT
$SYSINCLUDE mpsgeset basico_CI

*       Replicamos el bechmark:

        basico_CI.ITERLIM = 0;
$INCLUDE basico_CI.GEN
        SOLVE basico_CI USING MCP;


        basico_CI.ITERLIM = 2000;

*       Salario fijo = numerario:

        PL.FX = 1;

*       Ejericio 1
*       ----------
*       Escenario:  100% de impuesto sobre el VA del sector X.
*       Analice los resultados obtenidos y comparelos con el benchmark


*       Ejericio 2
*       ----------
*       Modifique el anidado de la funcion de produccion de X. Ahora considere
*       un mayor grado de sustitución entre K y el insumo Y (energìa por ejemplo)
*       y deje que este compuesto de K-Y se sustituyan con L en el nivel superior.
*       Antes de correr el mismo escenario anterior piense si la carga impositiva
*       sobre la produccion de X es mayor o menor que en el caso anterior.
*       Compare y comente los resultados.


*       Ejericio 3
*       ----------
*       Suponga que el insumo utilizado en Y contamina (emite CO2 por combustion)
*       Grave entonces al insumo Y con un impuesto de 2.5 $ (calcule primero la tasa ad-valorem)
*       Utilice la estructura de la funcion de produccion anterior donde Y-K tienen mayor sustitución
*       Compare con el resultado anterior y comente los resultados.
