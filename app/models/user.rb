class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable


  def short_name
    words = name.split(' ')
    words.first.first + words.last.first
  end
end
