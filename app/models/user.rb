class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_and_belongs_to_many :groups

  has_many :invitations, dependent: :destroy

  has_many :votations, dependent: :destroy

  has_many :admins, dependent: :destroy
  # has_many :groups, :class_name => 'Group', :foreign_key => 'user_id'
  # http://www.spacevatican.org/2008/5/6/creating-multiple-associations-with-the-same-table/
end
