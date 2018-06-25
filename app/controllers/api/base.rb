module API
  class Base < Grape::API
    mount V1::Blogs

    add_swagger_documentation(
      info: {
        title: '',
        contact_email: ''
      },
      mount_path: 'doc/swagger',
      doc_version: ''
    )
  end
end
