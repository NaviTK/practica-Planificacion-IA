(define (problem itinerario_basico_precios)
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

    ;; París es una ciudad extremadamente cara en este test
    (= (precio-vuelo barcelona madrid) 10) (= (precio-vuelo madrid barcelona) 10)
    (= (precio-vuelo madrid paris) 5000) (= (precio-vuelo paris madrid) 5000)
    (= (precio-vuelo paris roma) 5000) (= (precio-vuelo roma paris) 5000)
    (= (precio-vuelo roma londres) 10) (= (precio-vuelo londres roma) 10)
    (= (precio-vuelo londres barcelona) 10) (= (precio-vuelo barcelona londres) 10)

    (= (precio-hotel h_bcn) 50)
    (= (precio-hotel h_mad) 50)
    (= (precio-hotel h_par) 9000)
    (= (precio-hotel h_rom) 50)
    (= (precio-hotel h_lon) 50)

    (= (precio-total) 0)
  )

  (:goal
    (and
      (viaje-empezado)
      (>= (ciudades-visitadas) (min-ciudades))
      
      (>= (dias-visitados) (min-dias))
      (forall (?c - ciudad) (imply (visitada ?c) (elegido-dias ?c)))    
    )
  )

  (:metric minimize (precio-total))
)
