class FriendshipValidation < ActiveModel::Validator
  def validate(record)
    record.errors[:name] << "You can't invite yourself" if record.sender_id == record.receiver_id
  end
end
