module FlashMessages
  extend ActiveSupport::Concern

  private

  def success(message, suffix: ' successfully')
    flash[:notice] = message + suffix.to_s
  end

  def failure(message, prefix: 'Something went wrong and ')
    flash[:alert] = prefix.to_s + message
  end
end
