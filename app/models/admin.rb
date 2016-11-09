# encoding: utf-8
require 'bcrypt'
class Admin < ActiveRecord::Base
  attr_accessible :name, :password
  validates :name, :password, presence: true
  before_create :make_password
  attr_accessor :password

  def auth?(pwd)
    self.encrypt_pwd == generate_encrypt_pwd(pwd)
  end

  private
  def make_password
    self.salt        = generate_salt
    self.encrypt_pwd = generate_encrypt_pwd(@password)
  end

  def generate_salt
    ::BCrypt::Engine.generate_salt
  end

  def generate_encrypt_pwd(pwd)
    ::BCrypt::Engine.hash_secret(pwd, self.salt)
  end


end
