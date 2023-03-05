class User < ActiveRecord::Base 
    
    has_many :pets

    include BCrypt
    
    #retrieve password from hash
    def password
        @password ||= Password.new(password_hash)
    end
    
      # create the password hash
    def password=(new_pass)
        @password = Password.create(new_pass)
        self.password_hash = @password
    end

    def full_name(user)
        "#{user.firstname} #{user.lastname}"
    end

end