module Wordnik

  class OperationParameter
    require 'active_model'
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :name, :description, :required, :param_type, :default_value, :allowable_values

    validates_presence_of :name, :description, :required, :param_type, :default_value, :allowable_values

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name.to_s.underscore.to_sym}=", value)
      end
    end

    def human_name
      return "request body" if self.param_type == 'body'
      self.name
    end

    def has_allowable_array?
      self.allowable_values.present? && self.allowable_values.include?(",")
    end

    def required?
      self.required
    end

    # It's an ActiveModel thing..
    def persisted?
      false
    end

  end

end