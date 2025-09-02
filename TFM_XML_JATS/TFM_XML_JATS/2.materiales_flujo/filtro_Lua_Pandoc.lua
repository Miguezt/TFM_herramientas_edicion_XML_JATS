-- secciones.lua
-- Filtro para asignar IDs tipo sec1, sec2, ... y limpiar numeración en títulos

local sec_counter = 0

-- Función para limpiar numeración al principio del título
local function limpiar_numeracion(text)
  return text:gsub("^%d+[%.%d%s]*", ""):gsub("^%s+", "")
end

function Header(el)
  sec_counter = sec_counter + 1

  -- Reemplazar ID con secX
  el.identifier = "sec" .. sec_counter

  -- Limpiar numeración si existe
  if el.content and #el.content > 0 then
    local texto = pandoc.utils.stringify(el.content)
    local limpio = limpiar_numeracion(texto)
    el.content = {pandoc.Str(limpio)}
  end

  return el
end


-- ATENCIÓN: Para que funcione este es el código de PANDOC: pandoc -f docx -t jats -s -o 245-256b.xml 245-256b.docx --lua-filter=secciones.lua