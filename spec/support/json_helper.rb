module JsonHelper
  def json
    MultiJson.load(response.body, symbolize_keys: true).with_indifferent_access if response&.body.present?
  end
end
