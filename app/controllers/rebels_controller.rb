class RebelsController < ApplicationController
  skip_before_action :verify_authenticity_token, on: [:create]
  @@default_redirect_target = "https://www.extinctionrebellion.be/thank-you"

  def new
    @rebel = Rebel.new
  end

  def create
    @rebel = Rebel.new(rebel_params)
    if @rebel.save
      return redirect_to redirect_target
    else
      render :new
    end
  end

  private

  def redirect_target
      target = params[:redirect_to]
      if not target.nil? and target.include? "://"
        return target
      end
      return @@default_redirect_target
  end

  def rebel_params
    params.require(:rebel).permit(
      :consent,
      :name,
      :email,
      :language,
      :local_group_id,
      :notes,
      :phone,
      :postcode
    )
  end
end
