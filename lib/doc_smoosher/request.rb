module DocSmoosher
  class Request < ApiObject
    attr_accessor :call_type, :path, :fields, :response, :example

    def initialize(params = {}, &block)
      # Defaults
      self.call_type = :get

      super(params)
    end


    def fields
      @fields ||= []
    end

    def field(params = {}, &block)
      if params.class == Field
        f = params
      else
        f = Field.new(params, &block)
      end
      fields << f unless fields.include?(f)
      p
    end

    def as_json(options={})
      super.merge(
        {
          :fields => fields.map(&:as_json),
          :parameters => parameters.map(&:as_json),
          :example => example
        }
      )
    end
  end
end
