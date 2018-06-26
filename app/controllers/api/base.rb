module API
  class Base < Grape::API
    mount V1::Blogs

    add_swagger_documentation(
      info: {
        title: 'Swagger Eample',
        contact_email: '3014zhangshuo@gmail.com'
      },
      mount_path: 'doc/swagger',
      doc_version: '1.0'
    )
  end
end
