module Constants
  module Errors

    USER_EMAIL_NOT_PRESENT_ERROR = {code: 20, message: "Email not present"}
    USER_EMAIL_NOT_UNIQUE_ERROR = {code: 21, message: "%{value} is already taken"}
    USER_EMAIL_NOT_VALID_ERROR = {code: 22, message: "%{value} is not a valid"}

    USER_PASSWORD_NOT_PRESENT_ERROR = {code: 30, message: "Not present"}
    USER_PASSWORD_TOO_LONG_ERROR = {code: 31, message: "%{count} is the maximum length"}
    USER_PASSWORD_TOO_SHORT_ERROR = {code: 33, message: "%{count} is the minimum length"}

    USER_FIRST_NAME_NOT_PRESENT_ERROR = {code: 70, message: "Not present"}
    USER_FIRST_NAME_TOO_LONG_ERROR = {code: 71, message: "%{count} is the maximum length"}
    USER_FIRST_NAME_TOO_SHORT_ERROR = {code: 72, message: "%{count} is the minimum length"}

    USER_LAST_NAME_TOO_LONG_ERROR = {code: 60, message: "%{count} is the maximum length"}
    USER_LAST_NAME_TOO_SHORT_ERROR = {code: 61, message: "%{count} is the minimum length"}
    USER_DOES_NOT_EXIST_ERROR = {code: 70, message: "User doesn't exist"}

    USER_IS_COMPANY_OWNER_ERROR = {code: 71, message: "Cannot remove the company owner"}

    AUTHENTICATION_EMAIL_INVALID_ERROR = {code: 40, message: "Invalid email"}
    AUTHENTICATION_PASSWORD_INVALID_ERROR = {code: 41, message: "Invalid password"}

    PASSWORD_CONFIRMATION_INVALID_ERROR = {code: 44, message: "Invalid password confirmation"}

    NOT_AUTHENTICATED_ERROR = {code: -1, message: "Not authenticated"}

    COMPANY_NAME_TOO_LONG_ERROR = {code: 100, message: "%{count} is the maximum length"}
    COMPANY_NAME_TOO_SHORT_ERROR = {code: 101, message: "%{count} is the minimum length"}
    COMPANY_NAME_NOT_PRESENT_ERROR = {code: 102, message: "Not present"}

    COMPANY_DESCRIPTION_TOO_LONG_ERROR = {code: 110, message: "%{count} is the maximum length"}

    COMPANY_DESCRIPTION_TOO_LONG_ERROR = {code: 111, message: "%{count} is the maximum length"}


    NOT_COMPANY_OWNER_ERROR = {code: 120, message: "You must be the company owner."}
    COMPANY_DOES_NOT_EXIST_ERROR = {code: 121, message: "Company doesn't exist"}
    COMPANY_ROLE_DOES_NOT_EXIST_ERROR = {code: 122, message: "Company role doesn't exist."}
    COMPANY_ROLE_COLOUR_INVALID_ERROR = {code: 200, message: "%{value} is not a valid HEX colour code"}

    COMPANY_ROLE_NAME_TOO_LONG_ERROR = {code: 210, message: "%{count} is the maximum length"}
    COMPANY_ROLE_NAME_NOT_PRESENT_ERROR = {code: 211, message: "Name not present"}

    ASSET_NAME_TOO_LONG_ERROR = {code: 300, message: "%{count} is the maximum length"}
    ASSET_NAME_TOO_SHORT_ERROR = {code: 301, message: "%{count} is the minimum length"}
    ASSET_NAME_NOT_PRESENT_ERROR = {code: 302, message: "Not present"}
    ASSET_NOT_FOUND_ERROR = {code: 303, message: "Asset not found"}

    ASSET_DESCRIPTION_TOO_LONG_ERROR = {code: 310, message: "%{count} is the maximum length"}

    API_KEY_NAME_TOO_LONG_ERROR = {code: 400, message: "%{count} is the maximum length"}
    API_KEY_NAME_NOT_PRESENT_ERROR = {code: 401, message: "Not present"}

    FILE_NOT_VALID_ERROR = {code: 500, message: "File type is invalid"}
    HEADERS_NOT_SET_ERROR = {code: 501, message: "Headers are not correctly set"}
    COLUMNS_NOT_DEFINED_ERROR = {code: 502, message: "Columns are not properly defined"}

=begin
    START_DATE_GREATER_THAN_END_DATE_ERROR = {code: 80, message: "End date greater than start date"}
    STARTING_AMOUNT_GREATER_THAN_ENDING_AMOUNT_ERROR = {code: 81, message: "Starting amount cannot be greater than ending amount"}
    DATE_RANGE_WITH_EQUALS_ERROR = {code: 82, message: "Cannot specify a date range when looking for a specific date"}
=end
  end
end
