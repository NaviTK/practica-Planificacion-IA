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
  )

  (:goal
    (and
      (viaje-empezado)
      (>= (ciudades-visitadas) (min-ciudades))  ;; Objetivo: Haber visitado 3 o más ciudades
    )
  )

  ;; ¡ESTA ES LA LÍNEA QUE FALTA PARA SOLUCIONAR EL ERROR!
  (:metric minimize (ciudades-visitadas))
)