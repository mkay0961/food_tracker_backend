class AuthSerializer < ActiveModel::Serializer
  attributes :test
  def test
    byebug
  end
end
