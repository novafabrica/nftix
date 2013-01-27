# == Schema Information
#
# Table name: users
#
#  id                        :integer(4)      not null, primary key
#  first_name                :string(50)
#  last_name                 :string(50)
#  username                  :string(20)
#  email                     :string(255)
#  hashed_password           :string(255)     default(""), not null
#  enabled                   :boolean(1)      default(TRUE)
#  remember_token            :string(40)
#  remember_token_expires_at :datetime
#  created_at                :datetime
#  updated_at                :datetime
#

# Users are the site administrators who have access to
# to the staff area.
require 'bcrypt'
class User < ActiveRecord::Base
  include BCrypt
  include Rememberable

  cattr_accessor :per_page
  @@per_page = 15

  attr_accessor  :password, :previous_password

  validates :first_name,  :length => {:within => 2..50}
  validates :last_name,  :length => {:within => 2..50}

  has_many :created_tickets, :class_name => 'Ticket', :foreign_key => 'creator_id'
  has_many :tickets, :foreign_key => 'owner_id'

  # validates :username,
  #   :length => {:within => 8..25},
  #   :format => {:with => /\A([a-z0-9_]+)\z/i},
  #   :uniqueness => { :case_sensitive => false, :message => "already exists. Please try again." }

  validates :password,
    :length => {:within => 8..25},
    :confirmation => true,
    :on => :create

  validates :password,
    :length => {:within => 8..25},
    :confirmation => true,
    :on => :update,
    :allow_blank => true

  validates :email,
    :uniqueness => {:message => "already has an account associated with it."},
    :format => {:with => STANDARD_EMAIL_REGEX, :message => "is an invalid address"}

  # validate anytime form params include :password or :email_confirmation
  # i.e. if you send :password, you must send :previous_password
  # You can update :email w/o it as long as :email_confirmation is nil
  validates :previous_password, :auto_password => true, :on => :update

  default_scope :order => "users.last_name ASC, users.first_name ASC"

  before_create :create_hashed_password
  before_update :update_hashed_password
  after_save :sanitize_object

  def authentication_password
    Password.new(hashed_password)
  end

  def create_hashed_password
    self.hashed_password = Password.create(password)
  end

  def update_hashed_password
    if password.present?
      self.hashed_password = Password.create(password)
    end
  end

  def sanitize_object
    self.password = nil
    self.password_confirmation = nil
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.authenticate(email="", password="")
    user = self.find_by_email(email)
    return (user && user.authentication_password  == password) ? user : false
  end

  # def email_new_password(password='*encrypted*')
  #   return false unless email.present?
  #   PostOffice.delay.new_admin_password(self, password)
  # end

  # <tt>self.create_token</tt> is a general-use hashing class
  # method. Pass in any string and it will be salted and then
  # hashed using the SHA1 algorithm.
  def self.create_token(string="")
    Digest::SHA1.hexdigest("Use the #{string} with #{Time.now}")
  end

end
