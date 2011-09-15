class UserSession < Authlogic::Session::Base
  # specify configuration here, such as:
  # logout_on_timeout true
  # ...many more options in the documentation
  find_by_login_method :find_by_login_or_email
  
  def to_key
     new_record? ? nil : [ self.send(self.class.primary_key) ]
  end
end