class UserValidation < ActiveModel::Validator
    def not_same_id(record)
        if record.sender_id == record.receiver_id
        record.errors[:name] << "You can't invite yourself" 
        end
      end
end