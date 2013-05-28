actions :create
default_action :create if defined?(default_action)

# Validations copied here from File and Template resources so that
# stacktraces properly inform the user where the validation occurred

attribute :command_name, :kind_of => String, :required => true
attribute :run_list, :kind_of => String
attribute :other_json, :kind_of => Hash