(define (problem itinerario_basico)
  (:domain agencia_viajes)
  
  (:objects
    barcelona madrid paris roma londres - ciudad
    h_bcn h_mad h_par h_rom h_lon h_lon_barato - hotel
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
    (hotel-en h_lon_barato londres)

    ;; Inicialización de las funciones numéricas
    (= (ciudades-visitadas) 0)
    (= (min-ciudades) 3)            ;; El cliente quiere visitar como mínimo 3 ciudades

    (= (min-dias-ciudad barcelona) 1) (= (max-dias-ciudad barcelona) 1)
    (= (min-dias-ciudad madrid) 1) (= (max-dias-ciudad madrid) 1)
    (= (min-dias-ciudad paris) 1) (= (max-dias-ciudad paris) 1)
    (= (min-dias-ciudad roma) 1) (= (max-dias-ciudad roma) 1)
    (= (min-dias-ciudad londres) 1) (= (max-dias-ciudad londres) 1)

    (= (dias-visitados) 0)
    (= (min-dias) 3)

    (= (precio-vuelo barcelona madrid) 100000) (= (precio-vuelo madrid barcelona) 100000)
    (= (precio-vuelo madrid paris) 100) (= (precio-vuelo paris madrid) 100000)
    (= (precio-vuelo paris roma) 100000) (= (precio-vuelo roma paris) 100000)
    (= (precio-vuelo roma londres) 100000) (= (precio-vuelo londres roma) 100000)
    (= (precio-vuelo londres barcelona) 100000) (= (precio-vuelo barcelona londres) 10)

    (= (precio-hotel h_bcn) 100000)
    (= (precio-hotel h_mad) 100000)
    (= (precio-hotel h_par) 100000)
    (= (precio-hotel h_rom) 100000)
    (= (precio-hotel h_lon) 100000)
    (= (precio-hotel h_lon_barato) 1000)

    (= (precio-total) 0)
  )

  (:goal
    (and
      (viaje-empezado)
      (>= (ciudades-visitadas) (min-ciudades))  ;; Objetivo: Haber visitado 3 o más ciudades
      
      (>= (dias-visitados) (min-dias))
      (forall (?c - ciudad) (imply (visitada ?c) (elegido-dias ?c)))    
    )
  )

  ;; TODO ¿solucionar error?
  ;;(:metric minimize (ciudades-visitadas))
  (:metric minimize (precio-total))

)