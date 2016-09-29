class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         # attr_accessor :email, :password, :password_confirmation, :remember_me
       
  has_and_belongs_to_many :groups

  has_many :invitations, dependent: :destroy

  has_many :votations, dependent: :destroy

  has_many :admins, dependent: :destroy

  validates_presence_of :name

  validates :password, :format => {:with => /(?=.*[a-zA-Z])(?=.*[0-9]).{6,}/,
  message: "must include one number and one letter."}, on: :create
  validates :password, :format => {:with => /(?=.*[a-zA-Z])(?=.*[0-9]).{6,}/,
  message: "must include one number and one letter."}, on: :update, allow_blank: true


  # has_many :groups, :class_name => 'Group', :foreign_key => 'user_id'
  # http://www.spacevatican.org/2008/5/6/creating-multiple-associations-with-the-same-table/
end
