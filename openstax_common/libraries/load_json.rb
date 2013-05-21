class OpenStaxChefUtilities

  def self.add_settings_to_node(node, settings, previous_keys = [])
    settings.each do |key, value|
      if value.is_a? Hash
        add_settings_to_node(node, value, Array.new(previous_keys).push(key))
      else
        target_attribute = node.normal
        previous_keys.each do |previous_key|
          target_attribute = target_attribute[previous_key]
        end
        target_attribute[key] = value
      end
    end
  end

end