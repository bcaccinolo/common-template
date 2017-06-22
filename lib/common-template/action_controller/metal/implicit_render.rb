
module ActionController
  module ImplicitRender

    def default_render(*args)

      # COMMON template rendering
      if self.relevant_for(action_name) and
          template_exists?(self.class.template.to_s,  _prefixes, variants: request.variant)
        render(*args)

      elsif template_exists?(action_name.to_s, _prefixes, variants: request.variant)
        render(*args)
      elsif any_templates?(action_name.to_s, _prefixes)
        message = "#{self.class.name}\##{action_name} is missing a template " \
          "for this request format and variant.\n" \
          "\nrequest.formats: #{request.formats.map(&:to_s).inspect}" \
          "\nrequest.variant: #{request.variant.inspect}"

        raise ActionController::UnknownFormat, message
      elsif interactive_browser_request?
        message = "#{self.class.name}\##{action_name} is missing a template " \
          "for this request format and variant.\n\n" \
          "request.formats: #{request.formats.map(&:to_s).inspect}\n" \
          "request.variant: #{request.variant.inspect}\n\n" \
          "NOTE! For XHR/Ajax or API requests, this action would normally " \
          "respond with 204 No Content: an empty white screen. Since you're " \
          "loading it in a web browser, we assume that you expected to " \
          "actually render a template, not nothing, so we're showing an " \
          "error to be extra-clear. If you expect 204 No Content, carry on. " \
          "That's what you'll get from an XHR or API request. Give it a shot."

        raise ActionController::UnknownFormat, message
      else
        logger.info "No template found for #{self.class.name}\##{action_name}, rendering head :no_content" if logger
        super
      end
    end
  end
end

