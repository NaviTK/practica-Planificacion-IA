(define (problem itinerario_basico)
  (:domain agencia_viajes)
  
  (:objects
    barcelona madrid paris roma londres - ciudad
    h_bcn h_mad h_par h_rom h_lon - hotel
  )

  (:init
    ;; Definición del mapa de vuelos (Grafo conexo)
    (vuelo barcelona madrid) (vuelo madrid barcelona)
    (vuelo madrid paris) (vuelo paris madrid)
    (vuelo paris roma) (vuelo roma paris)
    (vuelo roma londres) (vuelo londres roma)
    (vuelo londres barcelona) (vuelo barcelona londres)

    ;; Distribución de hoteles (un hotel por ciudad)
    (hotel-en h_bcn barcelona)
    (hotel-en h_mad madrid)
    (hotel-en h_par paris)
    (hotel-en h_rom roma)
    (hotel-en h_lon londres)

    ;; Inicialización de las funciones numéricas
    (= (ciudades-visitadas) 0)
    (= (min-ciudades) 3)            ;; El cliente quiere visitar como mínimo 3 ciudades

    (= (min-dias-ciudad barcelona) 1) (= (max-dias-ciudad barcelona) 2)
    (= (min-dias-ciudad madrid) 1) (= (max-dias-ciudad madrid) 1)
    (= (min-dias-ciudad paris) 1) (= (max-dias-ciudad paris) 1)
    (= (min-dias-ciudad roma) 1) (= (max-dias-ciudad roma) 1)
    (= (min-dias-ciudad londres) 1) (= (max-dias-ciudad londres) 1)

    (= (dias-visitados) 0)
    (= (min-dias) 4)

    ;; Extensión 2: Interés de las ciudades (1 a 3, siendo 1 más interesante)
    (= (interes barcelona) 3)
    (= (interes madrid) 2)
    (= (interes paris) 2)
    (= (interes roma) 1)
    (= (interes londres) 2)
    (= (interes-total) 0)

    ;; Extensión 3: Precios
    (= (precio-vuelo barcelona madrid) 10) (= (precio-vuelo madrid barcelona) 1000)
    (= (precio-vuelo madrid paris) 10) (= (precio-vuelo paris madrid) 10)
    (= (precio-vuelo paris roma) 10) (= (precio-vuelo roma paris) 10)
    (= (precio-vuelo roma londres) 10) (= (precio-vuelo londres roma) 10)
    (= (precio-vuelo londres barcelona) 10) (= (precio-vuelo barcelona londres) 10)

    (= (precio-hotel h_bcn) 10)
    (= (precio-hotel h_mad) 10)
    (= (precio-hotel h_par) 10)
    (= (precio-hotel h_rom) 1000) ;; Hotel en Roma es carísimo
    (= (precio-hotel h_lon) 10)
    (= (precio-total) 0)
  )

  (:goal
    (and
      (viaje-empezado)
      (>= (ciudades-visitadas) (min-ciudades))  ;; Objetivo: Haber visitado 3 o más ciudades
      
      (>= (dias-visitados) (min-dias))
      (forall (?c - ciudad) (imply (visitada ?c) (and (elegido-dias ?c) (interesado ?c))))    
    )
  )

  ;; Métrica ponderada: Priorizando el menor PRECIO (multiplicamos el precio por un peso alto)
  (:metric minimize (+ (* 100 (precio-total)) (* 1 (interes-total))))
  
)
