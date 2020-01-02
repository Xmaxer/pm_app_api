module Constants
  module Errors

    USER_EMAIL_NOT_PRESENT_ERROR = {code: 20, message: "Not present"}
    USER_EMAIL_NOT_UNIQUE_ERROR = {code: 21, message: "Already taken"}

    USER_PASSWORD_NOT_PRESENT_ERROR = {code: 30, message: "Not present"}
    USER_PASSWORD_TOO_LONG_ERROR = {code: 31, message: "%{count} is the maximum length"}
    USER_PASSWORD_TOO_SHORT_ERROR = {code: 33, message: "%{count} is the minimum length"}

    USER_FIRST_NAME_NOT_PRESENT_ERROR = {code: 70, message: "Not present"}
    USER_FIRST_NAME_TOO_LONG_ERROR = {code: 71, message: "%{count} is the maximum length"}
    USER_FIRST_NAME_TOO_SHORT_ERROR = {code: 72, message: "%{count} is the minimum length"}

    USER_LAST_NAME_TOO_LONG_ERROR = {code: 60, message: "%{count} is the maximum length"}
    USER_LAST_NAME_TOO_SHORT_ERROR = {code: 61, message: "%{count} is the minimum length"}

    EMAIL_INVALID_ERROR = {code: 40, message: "Invalid email"}
    PASSWORD_INVALID_ERROR = {code: 41, message: "Invalid password"}
    USERNAME_INVALID_ERROR = {code: 42, message: "Invalid username"}
    EMAIL_REQUIRED_ERROR = {code: 43, message: "Email is required"}
    PASSWORD_CONFIRMATION_INVALID_ERROR = {code: 44, message: "Invalid password confirmation"}

    NOT_AUTHENTICATED_ERROR = {code: 50, message: "Not authenticated"}

=begin
    START_DATE_GREATER_THAN_END_DATE_ERROR = {code: 80, message: "End date greater than start date"}
    STARTING_AMOUNT_GREATER_THAN_ENDING_AMOUNT_ERROR = {code: 81, message: "Starting amount cannot be greater than ending amount"}
    DATE_RANGE_WITH_EQUALS_ERROR = {code: 82, message: "Cannot specify a date range when looking for a specific date"}
=end
  end
end
