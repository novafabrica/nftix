# == Schema Information
#
# Table name: users
#
#  id                        :integer          not null, primary key
#  username                  :string(255)
#  first_name                :string(255)
#  last_name                 :string(255)
#  email                     :string(255)
#  hashed_password           :string(255)
#  remember_token            :string(255)
#  enabled                   :boolean
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

  has_many :tickets, :class_name => 'Ticket', :foreign_key => 'creator_id'
  has_many :assigned_tickets, :foreign_key => 'owner_id', :class_name => 'Ticket'
  has_many :comments
  has_many :group_assignments
  has_many :ticket_groups, :through => :group_assignments, :source => :ticket_group

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

  default_scope -> { order("users.last_name ASC, users.first_name ASC") }

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

  def self.form_dropdown
    self.all.map {|u| [u.full_name, u.id]} + [["None", ""]]
  end

  def self.authenticate(email="", password="")
    user = self.find_by_email(email)
    return (user && user.authentication_password  == password) ? user : false
  end

  def create_password_token
    update_attribute(:password_token, User.create_token(self.username + self. email))
  end

  def email_reset_token
    return false unless email.present?
    PostOffice.password_reset(self).deliver
  end

  # <tt>self.create_token</tt> is a general-use hashing class
  # method. Pass in any string and it will be salted and then
  # hashed using the SHA1 algorithm.
  def self.create_token(string="")
    Digest::SHA1.hexdigest("Use the #{string} with #{Time.now}")
  end

end
