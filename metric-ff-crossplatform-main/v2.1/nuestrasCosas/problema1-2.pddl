(define (problem itinerario_basico_dias_largos)
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
    (= (min-ciudades) 3)

    (= (min-dias-ciudad barcelona) 1) (= (max-dias-ciudad barcelona) 3)
    (= (min-dias-ciudad madrid) 1) (= (max-dias-ciudad madrid) 2)
    (= (min-dias-ciudad paris) 2) (= (max-dias-ciudad paris) 3)
    (= (min-dias-ciudad roma) 1) (= (max-dias-ciudad roma) 2)
    (= (min-dias-ciudad londres) 1) (= (max-dias-ciudad londres) 2)

    (= (dias-visitados) 0)
    (= (min-dias) 6) ;; Requiere al menos 6 días de viaje en total
  )

  (:goal
    (and
      (viaje-empezado)
      (>= (ciudades-visitadas) (min-ciudades))
      
      (>= (dias-visitados) (min-dias))
      (forall (?c - ciudad) (imply (visitada ?c) (elegido-dias ?c)))    
    )
  )

  (:metric minimize (ciudades-visitadas))
)
