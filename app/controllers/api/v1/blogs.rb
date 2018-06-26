module API
  module V1
    class Blogs < Grape::API
      include Default
  
      # rescue_from ActiveRecord::RecordNotFound, NoMethodError do |e|
      #   error!({code:2, error:'not found'}, 400)
      # end

      # rescue_from NoMethodError do |e|
      #   error!({code:3, error:'system error'}, 422)
      # end

      # rescue_from :all

      # http_basic do |username, password|
      #   username == 't' and password == 'h'
      # end

      # filter order before before_validation after_validation after
      before do
        unless request.headers['X-Api-Secret-Key'] == 'key'
          #error! 'forbidden', 403
          error!({code:1, message:'forbidden'}, 403)
        end
      end

      after do
      end

      before_validation do
      end

      after_validation do
      end

      # version 'v1', using: :path do
      #   get '/test/f' do
      #     raise NoMethodError
      #   end
      # end
      #
      # version 'v2', using: :path do
      #   get '/test/f' do
      #     'test f v2'
      #   end
      # end

      # alias namespace resource group segment
      resources :blogs do
        # /blogs/3/comments
        route_param :id do
          resources :comments do
            get do
              build_response data: "blog comments #{params[:id]}"
            end
          end
        end

        get do
          build_response data: { blogs: [] } # <= response
        end

        params do
          use :id_validator
        end

        # /api/blogs/2
        get ':id', requirements: { id: /\d/ } do
          build_response data: "id #{params[:id]}"
        end

        desc "create a blog"

        params do
           requires :title, type: String, desc: "博客标题"
           requires :content, type: String, desc: "博客内容", as: :body # only alias

           optional :tags, type: Array, desc: "博客标签", allow_blank: false
           # covert string to Symbol
           optional :state, type: Symbol, default: :pending, values: [:pending, :done]
           optional :meta_name, type: { value: String, message: "meta_name比必须为字符串" },
             regexp: /^s\-/

           optional :cover, type: File
           given :cover do
             requires :weight, type: Integer, values: { value: ->(v) { v >= -1 }, message: "weight必须大于等于-1" }
           end

           optional :comments, type: Array do
             requires :content, type: String, allow_blank: false
           end

           optional :category, type: Hash do
             requires :id, type: Integer
           end
         end

        post do
          build_response data: "post #{params}"
        end

        put ':id' do
          build_response data: "put #{params[:id]}"
        end

        delete ':id' do
          build_response data: "delete #{params[:id]}"
        end

        # blog/hot/pop/3
        get 'hot(/pop(/:id))' do
          build_response data: "hot #{params[:id]}"
        end

        # ignore swagger init (hidden: true)
        get 'lasest', hidden: true do
          redirect '/api/blogs/popular' # 返回给浏览器 301 302 调整码
        end

        get 'popular' do
          status 400
          build_response data: 'popular'
        end
      end
    end
  end
end
