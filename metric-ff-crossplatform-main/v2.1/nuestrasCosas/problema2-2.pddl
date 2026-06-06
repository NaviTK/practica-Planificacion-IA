(define (problem itinerario_basico_interes)
  (:domain agencia_viajes)
  
  (:objects
    barcelona madrid paris roma londres - ciudad
    h_bcn h_mad h_par h_rom h_lon - hotel
  )

  (:init
    (vuelo barcelona madrid) (vuelo madrid barcelona)
    (vuelo madrid paris) (vuelo paris madrid)
    (vuelo paris roma) (vuelo roma paris)
    (vuelo roma londres) (vuelo londres roma)
    (vuelo londres barcelona) (vuelo barcelona londres)

    (hotel-en h_bcn barcelona)
    (hotel-en h_mad madrid)
    (hotel-en h_par paris)
    (hotel-en h_rom roma)
    (hotel-en h_lon londres)

    (= (ciudades-visitadas) 0)
    (= (min-ciudades) 3)

    (= (min-dias-ciudad barcelona) 1) (= (max-dias-ciudad barcelona) 1)
    (= (min-dias-ciudad madrid) 1) (= (max-dias-ciudad madrid) 1)
    (= (min-dias-ciudad paris) 1) (= (max-dias-ciudad paris) 1)
    (= (min-dias-ciudad roma) 1) (= (max-dias-ciudad roma) 1)
    (= (min-dias-ciudad londres) 1) (= (max-dias-ciudad londres) 1)

    (= (dias-visitados) 0)
    (= (min-dias) 3)

    ;; Barcelona y Madrid tienen interés máximo (1), el resto es poco interesante (3)
    (= (interes barcelona) 1)
    (= (interes madrid) 1)
    (= (interes paris) 3)
    (= (interes roma) 3)
    (= (interes londres) 3)

    (= (interes-total) 0)
  )

  (:goal
    (and
      (viaje-empezado)
      (>= (ciudades-visitadas) (min-ciudades))
      
      (>= (dias-visitados) (min-dias))
      (forall (?c - ciudad) (imply (visitada ?c) (and (elegido-dias ?c) (interesado ?c))))    
    )
  )

  (:metric minimize (interes-total))
)
