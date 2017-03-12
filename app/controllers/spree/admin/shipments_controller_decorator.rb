# handle shipping errors gracefully on admin ui
Spree::Admin::ShipmentsController.class_eval do
  rescue_from Spree::ShippingError, :with => :handle_shipping_error

  private
    def handle_shipping_error(e)
      logger.error "***** Handle shipping error #{e.message}"
      try(load_object) rescue nil
      flash.now[:error] = e.message
      render :action => "edit"
    end
end
