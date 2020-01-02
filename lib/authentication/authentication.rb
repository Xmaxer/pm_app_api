module Authentication
  class Authentication
    class << self
      def get_token(user)
        JsonWebToken.encode({user_id: user.id}, user.get_decrypted_secret_key)
      end

      def authenticate(token, user_id)
        user = User.find_by(id: user_id)
        return nil unless user
        secret_key = user.get_decrypted_secret_key
        decoded_result = JsonWebToken.decode(token, secret_key)
        return nil unless decoded_result
        user
      end

      def logout(token, user_id)
        user = User.find_by(id: user_id)
        return false unless user
        secret_key = user.get_decrypted_secret_key
        JsonWebToken.expire(token, secret_key)
      end

      def logout_all(user)
        return false unless user
        user.change_secret_key
      end
    end
  end
end
