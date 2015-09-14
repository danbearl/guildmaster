class User < ActiveRecord::Base
  include Authem::User
  has_one :profile
end
