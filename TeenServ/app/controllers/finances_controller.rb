class FinancesController < ApplicationController

  #Creating and updating the finances model happens in the charges controller after charging the customer.
  # This controller will just have an index action and view so we can render all TeenServ's financial records.

  def index
  @finances = Finance.all()
  end

end
