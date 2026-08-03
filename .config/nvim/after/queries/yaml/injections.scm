; extends

; Sourcehut build manifests (.build.yml): each task is a single-key
; mapping under "tasks", keyed by an arbitrary task name (not a fixed
; key like "run"/"script"), so the upstream heuristics don't match it.
; Ref: https://man.sr.ht/builds.sr.ht/manifest.md
(block_mapping_pair
  key: (flow_node) @_tasks
  (#eq? @_tasks "tasks")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (block_node
          (block_mapping
            .
            (block_mapping_pair
              value: (block_node
                (block_scalar) @injection.content)) .)
          (#set! injection.language "bash")
          (#offset! @injection.content 0 1 0 0))))))
