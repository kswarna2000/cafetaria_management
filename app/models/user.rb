class User < ActiveRecord::Base
  has_secure_password
  has_many :todos

  validates :first_name, presence: true
  validates :email, presence: true

  def to_displayable_string
    "name:#{name} gmail:#{gmail} password#{password}"
  end

  def self.new_user(newuser)
    role = newuser[:role]
    first_name = newuser[:first_name]
    last_name = newuser[:last_name]
    email = newuser[:email]
    password = newuser[:password_digest]
    new(first_name: first_name, last_name: last_name, email: email, password: password, role: role)
  end
  def self.check(credentials)
    where("gmail=? and password=?", credentials["email"], credentials["password"]).exists?
  end

  def self.customers
    where(role: "customer")
  end
end
