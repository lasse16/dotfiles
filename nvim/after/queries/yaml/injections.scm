;; extends

; Set the injected language type of each run block to bash
(
 block_mapping_pair
 key: (flow_node
        (plain_scalar
          (string_scalar) @name (#eq? @name "steps")))
 (block_node
   (block_sequence
     (block_sequence_item
       (block_node
         (block_mapping
           (block_mapping_pair
             (#set! injection.language "bash")
             key: (flow_node
                    (plain_scalar
                      (string_scalar) @field_name (#eq? @field_name "run")
                      )
                    )
             value: (block_node (block_scalar) @injections.content)
             )
           )
         )
       )
     )
   )
 )
