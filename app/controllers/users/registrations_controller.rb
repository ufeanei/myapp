class Users::RegistrationsController < Devise::RegistrationsController

  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.paln_id == 2
          resorce.save_with_payment
        else
          resource.save_with_payment
        end
      end
    end
  end
  
end