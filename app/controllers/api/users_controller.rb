class Api::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  
  def index
    users = User.all.page(params[:page])
    render json: {data: array_serializer(users), meta: pagination_meta(users) }
  end

  def show
    render json: { data: single_serializer(@user) }
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { data: single_serializer(user) }
    else
      render json: {errors: user.errors}, adapter: :json
    end
  end

  def update
    if @user.update(user_params)
      render json: { data: single_serializer(@user) }
    else
      render json: {errors: @user.errors}, adapter: :json
    end
  end

  def destroy
    if @user.present?
      @user.destroy
      render json: {message: "User Deleted Successfully"}, adapter: :json
    else
      render json: {message: "User not Present"}, adapter: :json
    end
  end

  def typeahead
    search = "%#{params[:input].parameterize}%"
    users = User.search(search, fields: [:first_name, :last_name, :email], match: :word_middle, operator: 'or') 
    render json: {data: array_serializer(users) }
  end

  private

    def set_user
      @user = User.find_by_id(params[:id])
      unless @user.present?
        render json: {message: "User Not Present"}
      end
    end

    def user_params
      params.require(:user).permit(:first_name,:last_name,:email)
    end

    def array_serializer(collection)
      ActiveModel::Serializer::CollectionSerializer.new(collection, serializer: UserSerializer)
    end

    def single_serializer(record)
      ActiveModelSerializers::SerializableResource.new(record, serializer: UserSerializer)
    end

    def pagination_meta(collection)
      {
        current_page: collection.current_page,
        next_page: collection.next_page,
        prev_page: collection.prev_page,
        total_page: collection.total_pages,
        total_count: collection.total_count
      } if collection.present?
    end
end
