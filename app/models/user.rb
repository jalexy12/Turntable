class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
   belongs_to :rooms
   before_create :add_avatar

  private
    def add_avatar
      self.avatar = "http://www.stjohnsww.com/wp-content/uploads/2013/06/placeholder-person-180x180.gif"
    end
end
