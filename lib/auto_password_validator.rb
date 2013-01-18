class AutoPasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.methods.include?(:email_confirmation)
    skip_validation = value.nil? || (record.password.blank? && record.email_confirmation.blank?)
    else
     skip_validation = value.nil? || (record.password.blank?)
    end
    unless skip_validation || record.authentication_password == value
      record.errors[attribute] << "is incorrect."
    end
  end
end
