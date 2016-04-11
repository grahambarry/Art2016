class SessionsController < ApplicationController

  def new
      respond_to do |f|
    f.js { render layout: false, content_type: 'text/javascript' }
    f.html
  end
end
  end
def to_key
  new_record? ? nil : [ self.send(self.class.primary_key) ]
end

  def create
    use = Use.find_by(email: params[:session][:email].downcase)
    if use && use.authenticate(params[:session][:password])
      if use.activated?
        log_in use
        params[:session][:remember_me] == '1' ? remember(use) : forget(use)
        redirect_back_or root_url
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end



end