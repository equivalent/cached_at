module ModelLastCachedAt
  module ClassMethods
    def last_cached(reload=false)
      last_cached_at = instance_variable_get(base_last_cached_at_var_name)
      return last_cached_at if last_cached_at and !reload
      instance_variable_set(base_last_cached_at_var_name, last_base_cached_at_change)
    end

    protected
    def base_last_cached_at_var_name
      "@#{self.model_name.underscore}_last_cached"
    end

    def last_base_cached_at_change
      self.maximum(:cached_at)
    end
  end
end
