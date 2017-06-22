
module AbstractController

  module Rendering

    def render(*args, &block)

      options = _normalize_render(*args, &block)

      # COMMON TEMPLATE MODIFICATION
      options[:template] = self.class.template unless self.class.template.blank?

      rendered_body = render_to_body(options)
      if options[:html]
        _set_html_content_type
      else
        _set_rendered_content_type rendered_format
      end
      self.response_body = rendered_body
    end

  end
end
