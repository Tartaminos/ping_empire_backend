module Api
  class UsersController < ApplicationController
    skip_before_action :authorized, only: [ :register, :login ]

    def register
      user_parameter = user_params
      begin
        @user = User.new(
          username: user_parameter[:username],
          email: user_parameter[:email],
          password: user_parameter[:password]
        )
      rescue => e
        logger.error e.backtrace.join("\n")
        render json: { error: "Ser instantiation failed" }, status: :internal_server_error
      end
      if @user.save
        token = encode_token({ user_id: @user.id })
        render json: { user: @user, token: token }, status: :created
      else
        render json:  { error: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def login
      @user = User.find_by(email: params[:email])

      if @user && @user.authenticate(params[:password])
        token = encode_token({ user_id: @user.id })

        @user.update(last_login: Time.now)

        render json: { user: @user, token: token }, status: :ok
      else
        render json: { error: "Invalid email or password" }, status: :unauthorized
      end
    end

    private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    rescue ActionController::ParameterMissing => e
      logger.error "missing: #{e.message}"
      render json: { error: "invalid" }, status: :bad_request
    end
  end
end
