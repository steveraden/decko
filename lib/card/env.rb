# Card::Env can differ for each request; Wagn.config should not

class Card
  module Env
    class << self
      def reset args={}
        @@env = { :main_name => nil }
      
        if c = args[:controller]
          self[:controller] = c
          self[:session] = c.request.session
          self[:params] = c.request.params
          self[:ajax] = c.request.xhr? || c.request.params[:simulate_xhr]
          self[:host]       = Wagn.config.override_host     || c.request.env['HTTP_HOST']
          self[:protocol]   = Wagn.config.override_protocol || c.request.protocol
        
        end
      end
    
      def [] key
        @@env[key.to_sym]
      end
    
      def []= key, value
        @@env[key.to_sym] = value
      end
      
      #hacky - should be in module
      def recaptcha_on?
        if self[:recaptcha_on].nil?
          self[:recaptcha_count] = 0
          self[:recaptcha_on] = have_recaptcha_keys? && !Auth.signed_in? && !Auth.needs_setup? && !Auth.always_ok?
        end
        self[:recaptcha_on]
      end

      def params
        self[:params] ||= {}
      end
    
      def ajax?
        self[:ajax]
      end
    
      def method_missing method_id, *args
        case args.length
        when 0 ; self[ method_id ]
        when 1 ; self[ method_id ] = args[0]
        else   ; super
        end
      end
    
      private
    
      def have_recaptcha_keys?
        !!( Wagn.config.recaptcha_public_key && Wagn.config.recaptcha_private_key )
      end
    end
  end  
  Env.reset
end

