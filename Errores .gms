
********************************************************************************
*                 MODELO DE LOGISTICA Y MINIMIZACION DE COSTOS                 *
********************************************************************************

$Ontext
-----------------------------------Ejercicio------------------------------------
A continuacion, se presenta el Modelo de Transporte realizado por Dantzig 1963
modificado, o sea, se le han agregado errores.
Trate de solucionar dichos errores de manera tal que al hacer correr el GAMS
este arroje el resultado correcto.
--------------------------------------------------------------------------------

$Offtext

$TITLE  Modelo de Logistica

$OFFUPPER

$OFFSYMLIST $OFFSYMXREF

OPTION LIMROW=0, LIMCOL=0 ;

  Sets
       i   Plantas     / Seattle
                         San-Diego /
       j   Mercados    / Nueva-York Chicago Topeka /

  Parameters

       a(i)  Capacidad de la Planta i en toneladas
         /    Seattle     350
              San_Diego   600  /

       b(j)  Demanda en el Mercado j en toneladas
         /    Nueva-York  325
              Chicago     300
              Topeka      275  /

  Table d(i,j)  Distancia en miles de millas
                    Nueva-York      Chicago      Topeka
      Seattle          2.5           1.7          1.8
      San-Diego        2.5           1.8          1.4

  Scalar f  Costo de flete en dolares por tonelada por miles de millas /90/

  Parameter c(i,j)  Costo de transporte en miles de dolares por tonelada

            c(i,j) = f * d(i,j) / 1000

  Positive Variables
       x(i,j)  Cantidades trasladadas en toneladas
       z       Costo total de transporte en miles de dolares

  Equations
       Costo_Total  Función objetivo
       Oferta       Oferta limite observada en la planta i
       Demanda(j)   Demanda del mercado j a satisfacer

  Costo_Total ..  z =e= sum((i,j), c(i,j)/x(i,j)) ;

  Oferta(i) ..    sum(i, x(i,j)) = a(i) ;

  Demanda ..      sum(j, x(i,j)) =l= b(j) ;

  Model logistica /all/ ;

  Solve logistica using nlp minimizing z ;

  Display x.l, x.m ;
