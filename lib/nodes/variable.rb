module DoxyHaml

  class Variable < Member

    def type
      @type ||= Type.new nil, self, xpath(%Q{type}).first
    end

    def static?
      @static ||= (xpath_param 'static') == 'yes'
    end

  end

end
