class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :nickname, :name
end
