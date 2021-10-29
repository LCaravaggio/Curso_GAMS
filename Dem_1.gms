Parameters px1, px2, I ;
px1 =  25 ;
px2 =  25 ;
I   = 100 ;
Variables U, x1, x2 ;
Equations fo, rp ;
fo.. U =e= 50*x1**0.5*x2**0.5 ;
rp.. I =g= px1*x1+px2*x2   ;
model MAXU1 /all/ ;
x1.L=1; x2.L=1;
solve MAXU1 using nlp max U;



$ONTEXT
$MODEL:MAXU2

$SECTORS:
X ! NIVEL DE ACTIVIDAD DE X = DEMANDA DEL BIEN X
Y ! NIVEL DE ACTIVIDAD DE Y = DEMANDA DEL BIEN Y
$COMMODITIES:
PX ! PRECIO DE X
PY ! PRECIO DE Y
PL ! PRECIO DEL FACTOR L (ARTIFICIAL)
$CONSUMERS:
HOG ! INGRESO DEL CONSUMIDOR

$PROD:X
O:PX Q:1
I:PL Q:25
$PROD:Y
O:PY Q:1
I:PL Q:25
$DEMAND:HOG s:1
E:PL Q:100
D:PX Q:1
D:PY Q:1

$OFFTEXT
$SYSINCLUDE mpsgeset MAXU2
$INCLUDE MAXU2.GEN
PL.FX = 1;
SOLVE MAXU2 USING MCP;




