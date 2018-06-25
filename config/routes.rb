Rails.application.routes.draw do
  mount GrapeSwaggerRails::Engine => '/api/doc'
  mount API::Blogs, at: '/api'
end
