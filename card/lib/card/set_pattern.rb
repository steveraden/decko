class Card
  class SetPattern
    
    class << self
      attr_accessor :pattern_code, :pattern_id, :junction_only, :assigns_type, :anchorless
      
      def find pattern_code
        Card.set_patterns.find { |sub| sub.pattern_code == pattern_code }        
      end
    
      def junction_only?
        !!junction_only
      end
    
      def anchorless?
        !!anchorless
      end

      def new card
        super if pattern_applies? card
      end

      def pattern
        Card.fetch(self.pattern_id, :skip_modules=>true).cardname
      end

      def register pattern_code, opts={}
        if self.pattern_id = Card::Codename[pattern_code]
          self.pattern_code = pattern_code
          Card.set_patterns.insert opts.delete(:index).to_i, self
          self.anchorless = !respond_to?( :anchor_name )
          opts.each { |key, val| send "#{key}=", val }
        else
          warn "no codename for pattern_code #{pattern_code}"
        end
      end

      def pattern_applies? card
        junction_only? ? card.cardname.junction? : true
      end
    
      def write_tmp_file pattern_code, from_file, seq
        to_file = "#{Card.paths['tmp/set_pattern'].first}/#{seq}-#{pattern_code}.rb"
        klass = "Card::#{pattern_code.camelize}Set"
        file_content = <<EOF
# -*- encoding : utf-8 -*-
class #{klass} < Card::SetPattern
  cattr_accessor :options
  class << self
# ~~~~~~~~~~~ above autogenerated; below pulled from #{from_file} ~~~~~~~~~~~

#{ File.read from_file }

# ~~~~~~~~~~~ below autogenerated; above pulled from #{from_file} ~~~~~~~~~~~
  end
  register "#{pattern_code}", (options || {})
end

EOF
        File.write to_file, file_content
        to_file
      end
    end


    # Instance methods

    def initialize card
      unless self.class.anchorless?
        @anchor_name = self.class.anchor_name(card).to_name
        @anchor_id = if self.class.respond_to? :anchor_id
          self.class.anchor_id card
        else
          Card.fetch_id @anchor_name
        end
      end
      self
    end

    def module_key
      (defined? @module_key) ? @module_key : @module_key = begin
        if self.class.anchorless?
          self.class.pattern_code.camelize
        elsif anchor_codenames
          "#{self.class.pattern_code.camelize}::#{anchor_codenames.map(&:to_s).map(&:camelize) * '::'}"
        end
      end
    end

    def module_list
      module_key and Card::Set.modules[ :nonbase ][ module_key ]
    end

    def format_module_list klass
      module_key and hash = Card::Set.modules[ :nonbase_format ][ klass ] and hash[ module_key ]
    end

    def anchor_codenames
      @anchor_name.parts.map do |part|
        part_id = Card.fetch_id part
        part_id && Card::Codename[ part_id.to_i ] or return nil
      end
    end

    def pattern
      @pattern ||= self.class.pattern
    end

    def to_s
      self.class.anchorless? ? pattern.s : "#{@anchor_name}+#{pattern}"
    end

    def inspect
      "<#{self.class} #{to_s.to_name.inspect}>"
    end

    def safe_key
      caps_part = self.class.pattern_code.gsub(' ','_').upcase
      self.class.anchorless? ? caps_part : "#{caps_part}-#{@anchor_name.safe_key}"
    end

    def rule_set_key
      if self.class.anchorless?
        self.class.pattern_code
      elsif @anchor_id
        [ @anchor_id, self.class.pattern_code ].map( &:to_s ) * '+'
      end
    end
  
  end
end
