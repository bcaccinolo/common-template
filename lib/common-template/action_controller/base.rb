module ActionController
  class Base < Metal

    class << self
      attr_accessor :template
      attr_accessor :common_actions

      def common_template temp, *options
        self.template = temp
        parse_options options.first
      end

      def parse_options opt
        if opt.nil? or opt.empty?
          self.common_actions = []
        elsif opt.has_key?(:just)
          self.common_actions = opt[:just]
        else
          raise ArgumentError
        end
      end
    end

    def relevant_for(action)
      return(true) if self.class.common_actions.empty?
      return(true) if self.class.common_actions.include?(action.to_sym)
      false
    end

  end
end

