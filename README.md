## Grape API Example

- API权限控制：scope （namespace）
- 版本：version
- 验证：authentication
- 数据格式：request/response payload
- 状态码：status code
- 文档：documentation
- 流量控制：access flow control

## CORS（跨域）

- 协议：http https
- 端口
- 域名

指定端口号 `rails s -p 6001`

## Debugging routes

API::Base.routes
API::Base.recognize_path '/v1/blogs'
rails grape:routes
