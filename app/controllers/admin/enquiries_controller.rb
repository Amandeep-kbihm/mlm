class Admin::EnquiriesController < Admin::BaseController
  before_action :set_enquiry, only: :update

  def index
    respond_to do |format|
      format.html
      format.json { render(json: EnquiryDatatable.new(view_context)) and return }
    end
  end

  def update
    @enquiry.update(status: Enquiry::STATUS[:resolved])
    redirect_to :back
  end

  private

  def set_enquiry
    @enquiry = Enquiry.find params[:id]
  end

end