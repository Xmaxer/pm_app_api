class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
        current_user: current_user,
        api_key: api_key(query)
    }
    result = PmAppApiSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development e
  end

  private

  def current_user

    return nil if request.headers['Authorization'].blank?
    token = request.headers['Authorization'].split(' ').last
    return nil if token.blank?
    user = Authentication::Authentication.authenticate(token)
    return nil unless user
    user.current_token = token
    user
  end

  def api_key(query)
    if request.headers['apikey']
      key = Authentication::Authentication.authenticate_api_key(request.headers['apikey'])
      ApiKeyHistory.create(api_key: key, query: query)
      return key
    end
    nil
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { error: { message: e.message, backtrace: e.backtrace }, data: {} }, status: 500
  end
end
