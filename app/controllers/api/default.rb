module API
  module Default
    extend ActiveSupport::Concern

    included do
      include Helpers::Common
      version 'v1', using: :path # api/v1/...

      # except xml binary
      # content_type :xml, 'application/xml'
      # content_type :binary, 'application/octet-stream'
      content_type :json, 'application/json'
      content_type :txt, 'text/plain'

      default_format :json

      rescue_from ActiveRecord::RecordNotFound, NoMethodError do |e|
        error!({code:2, error:'not found'}, 400)
      end
    end
  end
end
