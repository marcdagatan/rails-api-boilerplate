Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.base_controller_class = "ActionController::API"

  config.lograge.custom_options = ->(_event) do
    { current_time: Time.zone.now }
  end
end
