class ApplicationController < ActionController::API
    before_action :authorized

    def options
      head :ok
    end

    def encode_token(payload)
      JWT.encode(payload, Rails.application.secret_key_base)
    rescue => e
      logger.error "Generate JWT token error: #{e.message}"
      nil
    end

    def decoded_token
      if auth_header
        token = auth_header.split(" ")[1]
        begin
          JWT.decode(token, Rails.application.secret_key_base, true, algorithm: "HS256")
        rescue JWT::DecodeError => e
          logger.error "Decode JWT error: #{e.message}"
          nil
        rescue => e
          logger.error "JWT ERROR decoded_token: #{e.message}"
          logger.error e.backtrace.join("\n")
          nil
        end
      end
    end

    def auth_header
      request.headers["Authorization"]
    end

    def logged_in_user
      if decoded_token
        user_id = decoded_token[0]["user_id"]
        @user = User.find_by(id: user_id)
      end
    end

    def logged_in?
      !!logged_in_user
    end

    def authorized
      logger.debug "Executando o método authorized"
      unless logged_in?
        logger.debug "Usuário não está logado"
        render json: { message: "Please log in" }, status: :unauthorized
      else
        logger.debug "Usuário está logado"
      end
    end

    rescue_from StandardError do |e|
      logger.error "Exception: #{e.message}"
      logger.error e.backtrace.join("\n")
      render json: { error: "Erro interno do servidor" }, status: :internal_server_error
    end
end
