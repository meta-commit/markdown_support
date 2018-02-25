require 'redcarpet'
require 'byebug'

class CustomRender < Redcarpet::Render::HTML
  def block_quote(quote)
    byebug
    %(<blockquote class="my-custom-class">#{quote}</blockquote>)
  end
end

# class RendererNew < Redcarpet::Render::HTML
#   def block_code(code, language)
#     byebug
#     "hgffgghfghfghfgfgfgfghghfgfhfghhgf"
#   end
# end

# class RenderWithoutCode < Redcarpet::Render::HTML
#   def block_code(code, language)
#     nil
#   end
# end
#
# block_code(code, language)
# block_quote(quote)
# block_html(raw_html)
# footnotes(content)
# footnote_def(content, number)
# header(text, header_level)
# hrule()
# list(contents, list_type)
# list_item(text, list_type)
# paragraph(text)
# table(header, body)
# table_row(content)
# table_cell(content, alignment)