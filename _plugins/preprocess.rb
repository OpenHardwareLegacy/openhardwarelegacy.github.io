Jekyll::Hooks.register [:pages, :documents, :posts], :pre_render do |doc, payload|
  replacements = doc.site.config["string_replacements"] || []

  replacements.each do |r|
    next unless r["old"] && r["new"]
    doc.content = doc.content.gsub(r["old"], r["new"])
  end
end

