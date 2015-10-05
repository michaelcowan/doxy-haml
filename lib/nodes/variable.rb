module DoxyHaml

  class Variable < Member

    def type
      @type ||= Type.new nil, self, xpath(%Q{type}).first
    end

  end

end
