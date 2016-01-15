class User < ApplicationRecord
  include Redis::Objects
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  sorted_set :online, global: true
  sorted_set :away, global: true

  def short_name
    words = name.split(' ')
    words.first.first + words.last.first
  end

  def appear
    User.online.add(id, id)
  end

  def disappear
    User.online.delete(id)
  end

  def away
    User.away.add(id, id)
  end
end
