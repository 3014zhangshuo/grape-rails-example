module API
  module Default
    extend ActiveSupport::Concern

    included do
      include Helpers::Common
      version 'v1', using: :path

      # except xml binary
      content_type :json, 'application/json'
      # content_type :xml, 'application/xml'
      content_type :txt, 'text/plain'
      # content_ty  pe :binary, 'application/octet-stream'
      default_format :json

      rescue_from ActiveRecord::RecordNotFound, NoMethodError do |e|
        error!({code:2, error:'not found'}, 400)
      end
    end
  end
end
