(define (domain agencia_viajes)
  (:requirements :strips :typing :fluents)
  
  (:types 
    ciudad hotel - object
  )

  (:predicates
    (vuelo ?c1 - ciudad ?c2 - ciudad)      ;; Existe un vuelo directo entre c1 y c2
    (hotel-en ?h - hotel ?c - ciudad)      ;; El hotel h está en la ciudad c
    (actual ?c - ciudad)                   ;; El turista está actualmente en la ciudad c
    (visitada ?c - ciudad)                 ;; La ciudad c ya ha sido visitada
    (alojado ?h - hotel)                   ;; El turista se ha alojado en el hotel h
    (viaje-empezado)                       ;; Indica si el viaje ya ha comenzado
  )

  (:functions
    (ciudades-visitadas)                   ;; Contador numérico de ciudades en el itinerario
    (min-ciudades)                         ;; El mínimo de ciudades que exige el cliente
  )

  ;; ACCIÓN 1: Elegir la ciudad de inicio libremente
  (:action empezar-viaje
    :parameters (?c - ciudad ?h - hotel)
    :precondition (and 
      (not (viaje-empezado))               ;; No podemos empezar si ya ha empezado
      (hotel-en ?h ?c)                     ;; El hotel elegido debe estar en esa ciudad
    )
    :effect (and 
      (viaje-empezado)
      (actual ?c)
      (visitada ?c)
      (alojado ?h)                         
      (increase (ciudades-visitadas) 1)    ;; <--- ¡CAMBIADO AQUÍ! De 'assign' a 'increase'
    )
  )

  ;; ACCIÓN 2: Volar a otra ciudad y alojarse en su hotel
  (:action volar-y-alojar
    :parameters (?from - ciudad ?to - ciudad ?h - hotel)
    :precondition (and 
      (viaje-empezado)                     ;; El viaje ya debe haber comenzado
      (actual ?from)                       ;; Debemos estar en la ciudad de origen
      (vuelo ?from ?to)                    ;; Debe existir un vuelo al destino
      (not (visitada ?to))                 ;; No podemos repetir ciudades
      (hotel-en ?h ?to)                    ;; El hotel debe estar en la ciudad de destino
    )
    :effect (and 
      (not (actual ?from))                 ;; Ya no estamos en la antigua ciudad
      (actual ?to)                         ;; Ahora estamos en la nueva ciudad
      (visitada ?to)                       ;; Marcamos la nueva ciudad como visitada
      (alojado ?h)                         ;; Nos alojamos en el hotel del destino
      (increase (ciudades-visitadas) 1)    ;; Sumamos una ciudad al contador
    )
  )
)