class HelloController < ApplicationController
  def index
    render json: {msg: "hello world"}, status: :ok
  end
end