; extends

; Hologram
(sigil
  (sigil_name) @_sigil_name
  (quoted_content) @injection.content
  (#eq? @_sigil_name "HOLO")
  (#set! injection.language "holo"))
