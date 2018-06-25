Rails.application.routes.draw do
  mount GrapeSwaggerRails::Engine => '/api/doc'
  mount API::Base, at: '/api'
end
